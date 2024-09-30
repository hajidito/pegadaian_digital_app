import 'package:intl/intl.dart';

class CustomDateFormatter {
  static String formatLong(DateTime date) {
    return DateFormat('HH:mm:ss').format(date);
  }

  static String getDate(DateTime date) {
    return DateFormat('dd').format(date);
  }

  static String getDay(DateTime date) {
    return DateFormat('EEE').format(date);
  }

  static String getTime(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }
}
