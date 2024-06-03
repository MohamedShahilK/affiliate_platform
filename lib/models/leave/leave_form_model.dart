// ignore_for_file: lines_longer_than_80_chars

import 'package:json_annotation/json_annotation.dart';

part 'leave_form_model.g.dart';

@JsonSerializable()
class GetLeaveForm {
  GetLeaveForm({required this.status, required this.response, required this.data});
  final String? status;
  final String? response;
  final List<Data>? data;
}

@JsonSerializable()
class Data {
  Data({required this.userID, required this.title, required this.employeeList, required this.leavesType, required this.leavesDuration});
  final String? userID;
  final String? title;
  final List<EmployeeList>? employeeList;
  final List<LeavesType>? leavesType;
  final LeavesDuration? leavesDuration;
}

@JsonSerializable()
class EmployeeList {
  EmployeeList({required this.id, required this.firstName, required this.lastName, required this.userCode});
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? userCode;
}

@JsonSerializable()
class LeavesType {
  LeavesType({required this.id, required this.name, required this.status, required this.createdAt, required this.updatedAt});
  final String? id;
  final String? name;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
}

@JsonSerializable()
class LeavesDuration {
  LeavesDuration({required this.s1, required this.s2, required this.s3, required this.s4});
  final String? s1;
  final String? s2;
  final String? s3;
  final String? s4;
}
