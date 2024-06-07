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
}
