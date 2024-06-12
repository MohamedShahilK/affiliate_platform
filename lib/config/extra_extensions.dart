import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  String formatToString() {
    final hourString = hour.toString().padLeft(2, '0');
    final minuteString = minute.toString().padLeft(2, '0');
    return '$hourString:$minuteString';
  }
}
