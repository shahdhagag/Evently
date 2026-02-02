import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeHelper {
  /// Format date based on locale
  static String formatDate(DateTime date, String locale) {
    return DateFormat('MMMM dd, yyyy', locale).format(date);
  }

  /// Convert TimeOfDay to safe stored format (HH:mm)
  static String toStoredTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  /// Parse stored HH:mm back to TimeOfDay
  static TimeOfDay fromStoredTime(String time) {
    final date = DateFormat('HH:mm').parse(time);
    return TimeOfDay(hour: date.hour, minute: date.minute);
  }

  /// Display localized time
  static String formatTime(BuildContext context, TimeOfDay time) {
    return time.format(context);
  }
}
