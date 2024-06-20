// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/models/attendance/attendance_model.dart';
import 'package:affiliate_platform/services/attendance/attendance_services.dart';
import 'package:rxdart/rxdart.dart';

class AttendanceBloc {
  AttendanceBloc() {
    initDetails();
  }

  final getAttendanceStream = BehaviorSubject<GetAttendanceModel?>();

  final employeeNameStream = BehaviorSubject<String>.seeded('');
  final dateStream = BehaviorSubject<String>.seeded('');

  Future<void> initDetails() async {
    await getAttendaceDetails();
  }

  Future<void> getAttendaceDetails({String? filterDate}) async {
    final respModel = await AttendanceServices().getAttendaceDetails(filterDate: filterDate);
    getAttendanceStream.add(respModel);
  }

  void clearStreams() {
    employeeNameStream.add('');
    dateStream.add('');
  }

  void dispose() {
    getAttendanceStream.close();
  }
}
