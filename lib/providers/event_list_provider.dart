import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/firebase_functions/firebase_functions.dart';
import 'package:evently/models/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class EventListProvider extends ChangeNotifier {
  List<EventModel> eventsList = [];

  final List<String> _eventsNameKeys = [
    'All',
    'Sports',
    'Birthday',
    'Meeting',
    'Gaming',
    'Workshop',
    'Book Club',
    'Exhibition',
    'Holiday',
    'Eating',
  ];

  // Translated names for UI
  List<String> get eventsNameList => _eventsNameKeys.map((e) => e.tr()).toList();

  int selectedIndex = 0;
  bool isLoading = false;

  final Map<String, List<EventModel>> _eventsCache = {};

  StreamSubscription<QuerySnapshot<EventModel>>? _eventsStreamSub;
  StreamSubscription<dynamic>? _subscription;

  bool _isStreamStarted = false;

  EventListProvider() {
    getEventsFromFirestore();
    _startStream();
  }

  /// Fetch events from Firestore for current tab
  Future<void> getEventsFromFirestore() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    final categoryKey = _eventsNameKeys[selectedIndex];

    // Return cached data if available
    if (_eventsCache.containsKey(categoryKey)) {
      eventsList = List.from(_eventsCache[categoryKey]!);
      eventsList.sort((a, b) => b.lastUpdated.compareTo(a.lastUpdated));
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      Query<EventModel> query = FirebaseFunctions.getEventsCollection()
          .where('userUid', isEqualTo: currentUser.uid);

      if (categoryKey != 'All') {
        query = query.where('eventName', isEqualTo: categoryKey);
      }

      query = query.orderBy('createdAt', descending: true);

      final snapshot = await query.get();
      eventsList = snapshot.docs.map((doc) => doc.data()).toList();
      eventsList.sort((a, b) => b.lastUpdated.compareTo(a.lastUpdated));

      // Cache the results
      _eventsCache[categoryKey] = List.from(eventsList);
    } catch (e) {
      print("Error fetching events: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Change category tab
  void changeCategory(int index) {
    selectedIndex = index;
    final categoryKey = _eventsNameKeys[selectedIndex];

    if (_eventsCache.containsKey(categoryKey)) {
      eventsList = List.from(_eventsCache[categoryKey]!);
    } else {
      eventsList = [];
      getEventsFromFirestore(); // fetch from Firestore if not cached
    }

    // Sort by date
    eventsList.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }

  /// Add or update event locally (UI-first)
  void _insertAtTop(EventModel event) {
    final categoryKey = event.eventName;

    // Remove old instance from all caches
    for (final key in _eventsCache.keys) {
      _eventsCache[key]?.removeWhere((e) => e.id == event.id);
    }

    // Insert at top of category cache
    _eventsCache[categoryKey] ??= [];
    _eventsCache[categoryKey]!.insert(0, event);

    // Insert at top of 'All' cache
    _eventsCache['All'] ??= [];
    _eventsCache['All']!.insert(0, event);

    // Update visible list based on current tab
    final currentTabKey = _eventsNameKeys[selectedIndex];
    if (currentTabKey == 'All') {
      eventsList = List.from(_eventsCache['All']!);
    } else if (currentTabKey == categoryKey) {
      eventsList = List.from(_eventsCache[categoryKey]!);
    }

    notifyListeners();
  }

  /// Add event (immediate UI update + Firestore)
  Future<void> addEvent(EventModel newEvent) async {
    _insertAtTop(newEvent);

    try {
      await FirebaseFunctions.addEventsToFirestore(newEvent);
    } catch (e) {
      print("Failed to add event: $e");
    }
  }

  /// Update event (immediate UI update + Firestore)
  Future<void> updateEvent(EventModel updatedEvent) async {
    _insertAtTop(updatedEvent);

    try {
      await FirebaseFunctions.updateEvent(updatedEvent);
    } catch (e) {
      print("Failed to update event: $e");
    }
  }

  /// Delete event
  Future<void> deleteEvent(String eventId) async {
    try {
      await FirebaseFunctions.deleteEvent(eventId);

      // Remove from all caches
      for (var key in _eventsCache.keys) {
        _eventsCache[key]?.removeWhere((e) => e.id == eventId);
      }

      eventsList.removeWhere((e) => e.id == eventId);
      notifyListeners();
    } catch (e) {
      print("Error deleting event: $e");
    }
  }

  /// Firestore stream to auto-update UI
  void _startStream() {
    if (_isStreamStarted) return;
    _isStreamStarted = true;

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    final query = FirebaseFunctions.getEventsCollection()
        .where('userUid', isEqualTo: currentUser.uid)
        .orderBy('createdAt', descending: true);

    _eventsStreamSub = query.snapshots().listen((snapshot) {
      for (var change in snapshot.docChanges) {
        final event = change.doc.data();
        if (event == null) continue;

        if (change.type == DocumentChangeType.removed) {
          for (final key in _eventsCache.keys) {
            _eventsCache[key]?.removeWhere((e) => e.id == event.id);
          }

          final currentTabKey = _eventsNameKeys[selectedIndex];
          if (currentTabKey == 'All' || currentTabKey == event.eventName) {
            eventsList.removeWhere((e) => e.id == event.id);
          }
        } else {
          _insertAtTop(event);
        }
      }
    });
  }

  /// Favorite events
  List<EventModel> get allFavoriteEvents {
    final Map<String, EventModel> uniqueEvents = {};
    _eventsCache.forEach((_, list) {
      for (var event in list) {
        if (event.isFavorite) uniqueEvents[event.id] = event;
      }
    });
    return uniqueEvents.values.toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  /// Reset provider
  void reset() {
    _eventsStreamSub?.cancel();
    _eventsStreamSub = null;

    _subscription?.cancel();
    _subscription = null;

    eventsList.clear();
    _eventsCache.clear();

    selectedIndex = 0;
    isLoading = false;
    notifyListeners();
  }

  /// GoRouter refresh
  void GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription?.cancel();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _eventsStreamSub?.cancel();
    _subscription?.cancel();
    super.dispose();
  }
}