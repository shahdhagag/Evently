import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseFunctions {
  static CollectionReference<EventModel> getEventsCollection() {
    return FirebaseFirestore.instance
        .collection(EventModel.collectionName)
        .withConverter<EventModel>(
          fromFirestore:
              (
                DocumentSnapshot<Map<String, dynamic>> snapshot,
                SnapshotOptions? options,
              ) {
                return EventModel.fromJson(snapshot.data()!);
              },
          toFirestore: (value, SetOptions? options) {
            return value.toJson();
          },
        );
  }
  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(UserModel.collectionName)
        .withConverter<UserModel>(
          fromFirestore:
              (
                DocumentSnapshot<Map<String, dynamic>> snapshot,
                SnapshotOptions? options,
              ) {
                return UserModel.fromJson(snapshot.data()!);
              },
          toFirestore: (value, SetOptions? options) {
            return value.toJson();
          },
        );
  }

  static  createUserDB(UserModel user) async {
      try {
        final docRef = getUserCollection().doc(user.id);

        await docRef.set(user);

        print('User created successfully');
      } catch (e) {
        print(e);
      }
    }
  /// 1. CREATE USER + SEND VERIFICATION
  static Future<void> createUser(
    String emailAddress,
    String password,
    String name,
  ) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );
      createUserDB(UserModel(
        id: credential.user!.uid,
        emil: emailAddress,
        name: name,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ));

      // Send verification email immediately after signup
      await credential.user!.updateDisplayName(name);
      await credential.user!.reload();
      await credential.user!.sendEmailVerification();

      print('User created and verification email sent.');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print('Firebase Auth Error: ${e.code}');
      }
      rethrow;
    } catch (e) {
      print('Other Error: $e');
      rethrow;
    }
  }

  /// 2. LOGIN + CHECK VERIFICATION
  static Future<void> login(
    String emailAddress,
    String password,
    Function onLoginSuccess,
    Function onLoginError,
  ) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      // Check if the user has verified their email
      if (credential.user != null && !credential.user!.emailVerified) {
        // Option: Send it again if they try to log in but aren't verified
     //   await credential.user!.sendEmailVerification();

        // Sign them out so they aren't "logged in" with an unverified account
        await FirebaseAuth.instance.signOut();

        onLoginError("Please verify your email. We've sent another link.");
        return;
      }

      onLoginSuccess();
      print('Logged in as: ${credential.user?.email}');
    } on FirebaseAuthException catch (e) {
      onLoginError("Login failed: ${e.code}");
      rethrow;
    } catch (e) {
      onLoginError("An unexpected error occurred.");
      rethrow;
    }
  }

  /// 3 REST PASSWORD
  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
      print('Password reset email sent to $email');
    } on FirebaseAuthException catch (e) {
      print('Firebase error: ${e.code}');
    }
  }

  /// 4 SIGN IN WITH GOOGLE
  // Note: Google accounts are usually pre-verified by Google,
  // so you typically don't need to manually check verification here.
  static Future<UserCredential?> signInWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn(scopes: ['email']);

      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }

      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      final user = userCredential.user;
      if (user == null) return userCredential;

      /// 🔥 CHECK FIRESTORE
      final docRef = getUserCollection().doc(user.uid);
      final doc = await docRef.get();

      /// 🔥 CREATE USER ONLY FIRST TIME
      if (!doc.exists) {
        await createUserDB(
          UserModel(
            id: user.uid,
            emil: user.email ?? '',
            name: user.displayName ?? 'Google User',
            createdAt: DateTime.now().millisecondsSinceEpoch,
          ),
        );
      }

      return userCredential;
    } catch (e) {
      print('Google Sign-In Error: $e');
      rethrow;
    }
  }

  /// 5. LOGOUT
  static Future<void> logout() async {
    try {
      // Sign out from Firebase Auth
      await FirebaseAuth.instance.signOut();

      // Sign out from Google if signed in
      final GoogleSignIn googleSignIn = GoogleSignIn();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }

      print('User successfully logged out.');
    } catch (e) {
      print('Logout Error: $e');
      rethrow;
    }
  }

  /// 6. add event

  static Future<void> addEventsToFirestore(EventModel event) async {
    final docRef = FirebaseFirestore.instance
        .collection(EventModel.collectionName)
        .doc();

    event.id = docRef.id;

    await docRef.set({
      ...event.toJson(),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

// GET EVENTS ONCE
  static Future<QuerySnapshot<EventModel>> getEvents(String? eventName) async {
    final collectionRef = getEventsCollection();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception("No user logged in");

    Query<EventModel> query = collectionRef.where("userUid", isEqualTo: uid);

    if (eventName != null && eventName.isNotEmpty) {
      query = query.where('eventName', isEqualTo: eventName);
    }

    return await query.get();
  }

// STREAM EVENTS
  static Stream<QuerySnapshot<EventModel>> getEventsStream(String? eventName) {
    final collectionRef = getEventsCollection();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception("No user logged in");

    Query<EventModel> query = collectionRef.where("userUid", isEqualTo: uid);

    if (eventName != null && eventName.isNotEmpty) {
      query = query.where('eventName', isEqualTo: eventName);
    }

    return query.snapshots();
  }


  /// 8. DELETE EVENT
  static Future<void> deleteEvent(String eventId) async {
    try {
      await getEventsCollection().doc(eventId).delete();
      print('Event deleted successfully');
    } catch (e) {
      print('Delete Event Error: $e');
      rethrow;
    }
  }

  /// 9. UPDATE EVENT
  static Future<void> updateEvent(EventModel event) async {
    try {
      var docRef = getEventsCollection().doc(event.id);
      await docRef.update(event.toJson());
    } catch (e) {
      throw Exception("Firestore update failed: $e");
    }
  }

}
