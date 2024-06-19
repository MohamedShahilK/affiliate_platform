// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars

part of 'attendance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAttendanceModel _$GetAttendanceModelFromJson(Map<String, dynamic> json) => GetAttendanceModel(
      status: json['status'] as String?,
      response: json['response'] as String?,
      data: (json['data'] as List<dynamic>?)?.map((e) => _$DataFromJson(e as Map<String, dynamic>)).toList(),
    );

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      userDesignation: json['user_Designation'] as String?,
      filterDate: json['filter_date'] as String?,
      userID: json['user_ID'] as String?,
      employee: (json['employee'] as List<dynamic>?)?.map((e) => _$EmployeeFromJson(e as Map<String, dynamic>)).toList(),
      dropDownemployee: (json['drop_down_employee'] as List<dynamic>?)?.map((e) => _$EmployeeFromJson(e as Map<String, dynamic>)).toList(),
      attendanceDataList: (json['attendance_data_list'] as List<dynamic>?)?.map((e) => _$AttendanceDataListFromJson(e as Map<String, dynamic>)).toList(),
      attendanceSummary: (json['attendance__summary'] as List<dynamic>?)?.map((e) => _$AttendanceSummaryFromJson(e as Map<String, dynamic>)).toList(),
    );

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
      userId: json['userId'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      userCode: json['user_code'] as String?,
    );

AttendanceDataList _$AttendanceDataListFromJson(Map<String, dynamic> json) => AttendanceDataList(
      userId: json['userId'] as String?,
      date: json['date'] as String?,
      attendance: json['attendance'] as String?,
      leavelink: json['leavelink'] as String?,
    );

AttendanceSummary _$AttendanceSummaryFromJson(Map<String, dynamic> json) => AttendanceSummary(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      userCode: json['user_code'] as String?,
      employee: json['employee'] as String?,
      isHoursOff: json['IsHours_Off'] as String?,
      isHalfdayMorning: json['IsHalfday_Morning'] as String?,
      isFullday: json['IsFullday'] as String?,
      isHalfdayAfternoon: json['IsHalfday_Afternoon'] as String?,
      isLeave: json['IsLeave'] as String?,
      isHoliday: json['IsHoliday'] as String?,
      isPresent: json['IsPresent'] as String?,
      isAbsent: json['IsAbsent'] as String?,
      isOffday: json['IsOffday'] as String?,
    );
