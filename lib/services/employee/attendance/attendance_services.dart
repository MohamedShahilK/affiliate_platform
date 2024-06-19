// ignore_for_file: lines_longer_than_80_chars, avoid_print

import 'package:affiliate_platform/api/api.dart';

class AttendanceServices {
  factory AttendanceServices() {
    return _singleton;
  }

  AttendanceServices._internal();
  static final AttendanceServices _singleton = AttendanceServices._internal();

  final api = Api();

  // 
}
