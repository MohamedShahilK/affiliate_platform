// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars

part of 'leave_form_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetLeaveForm _$GetLeaveFormFromJson(Map<String, dynamic> json) => GetLeaveForm(
      status: json['status'] as String?,
      response: json['response'] as String?,
      data: (json['data'] as List<dynamic>?)?.map((e) =>  _$DataFromJson(e as Map<String, dynamic>)).toList(),
    );

GetLeaveFormData _$DataFromJson(Map<String, dynamic> json) => GetLeaveFormData(
      userID: json['user_ID'] as String?,
      title: json['title'] as String?,
      employeeList: (json['employee_list'] as List<dynamic>?)?.map((e) => _$EmployeeListFromJson(e as Map<String, dynamic>)).toList(),
      leavesType: (json['leaves_type'] as List<dynamic>?)?.map((e) => _$LeavesTypeFromJson(e as Map<String, dynamic>)).toList(),
      leavesDuration: json['leaves_duration'] == null ? null :  _$LeavesDurationFromJson(json['leavesDuration'] as Map<String, dynamic>),
    );

GetLeaveFormEmployeeList _$EmployeeListFromJson(Map<String, dynamic> json) => GetLeaveFormEmployeeList(
      id: json['id'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      userCode: json['user_code'] as String?,
    );

GetLeaveFormLeavesType _$LeavesTypeFromJson(Map<String, dynamic> json) => GetLeaveFormLeavesType(
      id: json['id'] as String?,
      name: json['name'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

LeavesDuration _$LeavesDurationFromJson(Map<String, dynamic> json) => LeavesDuration(
      hourOff: json['1'] as String?,
      hdM: json['2'] as String?,
      hdE: json['3'] as String?,
      fD: json['4'] as String?,
    );
