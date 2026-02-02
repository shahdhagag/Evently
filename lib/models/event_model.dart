import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  /// collection Name
  static const String collectionName = 'Events';

  /// attributes
  String id;
  final String eventImage;
  final DateTime date;
  final String time;
  final String title;
  final String description;
  final String eventName;
  bool isFavorite;
  String userUid;
  Timestamp lastUpdated;

  EventModel({
    this.id = '',
    required this.date,
    required this.title,
    required this.description,
    required this.eventName,
    required this.eventImage,
    this.isFavorite = false,
    required this.time,
    required this.userUid,
    Timestamp? lastUpdated,
  }) : lastUpdated = lastUpdated ?? Timestamp.now();

  /// json => object
  EventModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        date = DateTime.fromMillisecondsSinceEpoch(json['date']),
        title = json['title'] ?? '',
        description = json['description'] ?? '',
        eventName = json['eventName'] ?? '',
        eventImage = json['eventImage'] ?? '',
        isFavorite = json['isFavorite'] ?? false,
        time = json['time'] ?? '',
        userUid = json['userUid'] ?? '',
        lastUpdated = json['lastUpdated'] ?? Timestamp.now();

  /// object => json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'title': title,
      'description': description,
      'eventName': eventName,
      'eventImage': eventImage,
      'isFavorite': isFavorite,
      'time': time,
      'userUid': userUid,
      'lastUpdated': lastUpdated,
    };
  }

  /// copyWith (also allow updating lastUpdated)
  EventModel copyWith({
    String? title,
    String? description,
    DateTime? date,
    String? time,
    String? eventName,
    String? eventImage,
    bool? isFavorite,
    Timestamp? lastUpdated,
  }) {
    return EventModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      time: time ?? this.time,
      eventName: eventName ?? this.eventName,
      eventImage: eventImage ?? this.eventImage,
      isFavorite: isFavorite ?? this.isFavorite,
      userUid: userUid,
      lastUpdated: lastUpdated ?? Timestamp.now(),
    );
  }
}
