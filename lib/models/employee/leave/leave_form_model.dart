// ignore_for_file: lines_longer_than_80_chars

import 'package:json_annotation/json_annotation.dart';

part 'leave_form_model.g.dart';

@JsonSerializable()
class GetLeaveForm {
  GetLeaveForm({required this.status, required this.response, required this.data});

  factory GetLeaveForm.fromJson(Map<String, dynamic> json) => _$GetLeaveFormFromJson(json);

  final String? status;
  final String? response;
  final List<GetLeaveFormData>? data;
}

@JsonSerializable()
class GetLeaveFormData {
  GetLeaveFormData({required this.userID, required this.title, required this.employeeList, required this.leavesType, required this.leavesDuration});
  final String? userID;
  final String? title;
  final List<GetLeaveFormEmployeeList>? employeeList;
  final List<GetLeaveFormLeavesType>? leavesType;
  final LeavesDuration? leavesDuration;
}

@JsonSerializable()
class GetLeaveFormEmployeeList {
  GetLeaveFormEmployeeList({required this.id, required this.firstName, required this.lastName, required this.userCode});
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? userCode;
}

@JsonSerializable()
class GetLeaveFormLeavesType {
  GetLeaveFormLeavesType({required this.id, required this.name, required this.status, required this.createdAt, required this.updatedAt});
  final String? id;
  final String? name;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
}

@JsonSerializable()
class LeavesDuration {
  LeavesDuration({required this.hourOff, required this.hdM, required this.hdE, required this.fD});
  final String? hourOff;
  final String? hdM;
  final String? hdE;
  final String? fD;
}
