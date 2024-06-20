// ignore_for_file: lines_longer_than_80_chars

import 'package:intl/intl.dart';

class UtilityFunctions {
  static String convertIntoNormalDateTimeStringFromDateTimeString(String dateTimeString) {
    final toDateTime = DateTime.parse(dateTimeString);
    final normalDateString = DateFormat('dd-MM-yyyy hh:mm a').format(toDateTime);
    return normalDateString;
  }

  static String convertIntoNormalDateTimeStringFromDateTimeStringForTimezone(String dateTimeString) {
    final toDateTime = DateTime.parse(dateTimeString);
    final normalDateString = DateFormat('yyyy-MM-dd HH:mm:ss').format(toDateTime);
    return normalDateString;
  }

  static String convertIntoNormalDateStringFromDateTimeString(String dateTimeString) {
    final toDateTime = DateTime.parse(dateTimeString);
    final normalDateString = DateFormat('dd-MM-yyyy').format(toDateTime);
    return normalDateString;
  }

  String getDayOfWeek(String date) {
    // Define the input date format
    final inputFormat = DateFormat('dd-MM-yyyy');

    // Parse the input date string to a DateTime object
    final dateTime = inputFormat.parse(date);

    // Define the output format for the day of the week
    final outputFormat = DateFormat('EEEE');

    // Format the DateTime object to get the day of the week
    final dayOfWeek = outputFormat.format(dateTime);

    return dayOfWeek;
  }
}
