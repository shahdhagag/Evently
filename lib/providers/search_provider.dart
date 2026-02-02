import 'package:flutter/material.dart';
import 'package:evently/models/event_model.dart';

class FavoriteSearchProvider extends ChangeNotifier {
  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  void updateSearch(String value) {
    _searchQuery = value.toLowerCase();
    notifyListeners();
  }

  List<EventModel> filterEvents(List<EventModel> events) {
    if (_searchQuery.isEmpty) return events;

    return events.where((event) {
      return event.title.toLowerCase().contains(_searchQuery) ||
          event.description.toLowerCase().contains(_searchQuery) ||
          event.eventName.toLowerCase().contains(_searchQuery);
    }).toList();
  }
}
