// ignore_for_file: lines_longer_than_80_chars

import 'package:json_annotation/json_annotation.dart';

part 'attendance_model.g.dart';

@JsonSerializable()
class GetAttendanceModel {
  GetAttendanceModel({required this.status, required this.response, required this.data});

  factory GetAttendanceModel.fromJson(Map<String, dynamic> json) => _$GetAttendanceModelFromJson(json);

  final String? status;
  final String? response;
  final List<Data>? data;
}

@JsonSerializable()
class Data {
  Data({
    required this.userDesignation,
    required this.filterDate,
    required this.userID,
    required this.employee,
    required this.dropDownemployee,
    required this.attendanceDataList,
    required this.attendanceSummary,
  });
  final String? userDesignation;
  final String? filterDate;
  final String? userID;
  final List<Employee>? employee;
  final List<Employee>? dropDownemployee;
  final List<AttendanceDataList>? attendanceDataList;
  final List<AttendanceSummary>? attendanceSummary;
}

@JsonSerializable()
class Employee {
  Employee({required this.userId, required this.firstName, required this.lastName, required this.userCode});
  final String? userId;
  final String? firstName;
  final String? lastName;
  final String? userCode;
}

@JsonSerializable()
class AttendanceDataList {
  AttendanceDataList({required this.userId, required this.date, required this.attendance, required this.leavelink});
  final String? userId;
  final String? date;
  final String? attendance;
  final String? leavelink;
}

@JsonSerializable()
class AttendanceSummary {
  AttendanceSummary({
    required this.firstName,
    required this.lastName,
    required this.userCode,
    required this.employee,
    required this.isHoursOff,
    required this.isHalfdayMorning,
    required this.isFullday,
    required this.isHalfdayAfternoon,
    required this.isLeave,
    required this.isHoliday,
    required this.isPresent,
    required this.isAbsent,
    required this.isOffday,
  });
  final String? firstName;
  final String? lastName;
  final String? userCode;
  final String? employee;
  final String? isHoursOff;
  final String? isHalfdayMorning;
  final String? isFullday;
  final String? isHalfdayAfternoon;
  final String? isLeave;
  final String? isHoliday;
  final String? isPresent;
  final String? isAbsent;
  final String? isOffday;
}
