// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/models/attendance/attendance_model.dart';
import 'package:affiliate_platform/services/attendance/attendance_services.dart';

class AttendanceBloc {
  AttendanceBloc() {
    initDetails();
  }

  Future<void> initDetails() async {
    await getAttendaceDetails();
  }

  Future<GetAttendanceModel?> getAttendaceDetails() async {
    final respModel = await AttendanceServices().getAttendaceDetails();
    return respModel;
  }

  void clearStreams() {}

  void dispose() {}
}
