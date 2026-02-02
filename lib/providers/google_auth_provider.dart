// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// class GoogleAuthProvider extends ChangeNotifier {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: ['email', 'profile'],
//   );
//
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//
//   String? _errorMessage;
//   String? get errorMessage => _errorMessage;
//
//   User? _user;
//   User? get user => _user;
//
//   Future<UserCredential?> signInWithGoogle() async {
//     _errorMessage = null;
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       // 1. Trigger the Google sign-in flow
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) {
//         // User canceled the sign-in
//         _isLoading = false;
//         notifyListeners();
//         return null;
//       }
//
//       // 2. Obtain authentication details
//       final GoogleSignInAuthentication googleAuth =
//       await googleUser.authentication;
//
//       // 3. Create a new credential
//       final credential = GoogleAuthProviderForFirebase.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       // 4. Sign in with Firebase
//       final userCredential =
//       await _firebaseAuth.signInWithCredential(credential);
//
//       _user = userCredential.user;
//       _isLoading = false;
//       notifyListeners();
//
//       return userCredential;
//     } catch (e) {
//       _errorMessage = e.toString();
//       _isLoading = false;
//       notifyListeners();
//       return null;
//     }
//   }
//
//   Future<void> signOut() async {
//     try {
//       await _googleSignIn.signOut();
//       await _firebaseAuth.signOut();
//       _user = null;
//       notifyListeners();
//     } catch (e) {
//       _errorMessage = e.toString();
//       notifyListeners();
//     }
//   }
// }
//
// /// Helper class to avoid naming conflict with our provider
// class GoogleAuthProviderForFirebase extends FirebaseAuth {
//   static OAuthCredential credential({
//     String? accessToken,
//     String? idToken,
//   }) {
//     return GoogleAuthProvider.credential(
//       accessToken: accessToken,
//       idToken: idToken,
//     );
//   }
// }
