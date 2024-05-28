// ignore_for_file: lines_longer_than_80_chars

import 'package:json_annotation/json_annotation.dart';

part 'leave_model.g.dart';

@JsonSerializable()
class GetAllLeaves {
  GetAllLeaves({required this.status, required this.response, required this.data});

  factory GetAllLeaves.fromJson(Map<String, dynamic> json) => _$GetAllLeavesFromJson(json);

  final String? status;
  final String? response;
  final List<Data>? data;
}

@JsonSerializable()
class Data {
  Data({
    required this.tableTitle,
    required this.userDesignation,
    required this.userID,
    required this.totalLeaves,
    required this.leavesList,
    required this.leavesType,
    required this.leavesDuration,
    required this.users,
  });
  final String? tableTitle;
  final String? userDesignation;
  final String? userID;
  final int? totalLeaves;
  final List<LeavesList>? leavesList;
  final List<LeavesType>? leavesType;
  final LeavesDuration? leavesDuration;
  final List<Users>? users;
}

@JsonSerializable()
class LeavesList {
  LeavesList({
    required this.id,
    required this.employee,
    required this.leaveDate,
    required this.leaveDuration,
    required this.leaveType,
    required this.leaveStartDate,
    required this.leaveEndDate,
    required this.leavesIntervals,
    required this.leavesHouroffText,
    required this.leaveReason,
    required this.status,
    required this.approvalStatus,
    required this.approvalStatusRemarks,
    required this.approvalBy,
    required this.approvalOn,
    required this.bridgeLeave,
    required this.createdBy,
    required this.createdAt,
    required this.updatedBy,
    required this.updatedAt,
    required this.firstName,
    required this.lastName,
    required this.userCode,
    required this.leavesTypeName,
  });
  final String? id;
  final String? employee;
  final String? leaveDate;
  final String? leaveDuration;
  final String? leaveType;
  final String? leaveStartDate;
  final String? leaveEndDate;
  final String? leavesIntervals;
  final String? leavesHouroffText;
  final String? leaveReason;
  final String? status;
  final String? approvalStatus;
  final String? approvalStatusRemarks;
  final String? approvalBy;
  final String? approvalOn;
  final String? bridgeLeave;
  final String? createdBy;
  final String? createdAt;
  final String? updatedBy;
  final String? updatedAt;
  final String? firstName;
  final String? lastName;
  final String? userCode;
  final String? leavesTypeName;
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
  LeavesDuration({required this.hourOff, required this.hdM, required this.hdE, required this.fD});
  final String? hourOff;
  final String? hdM;
  final String? hdE;
  final String? fD;
}

@JsonSerializable()
class Users {
  Users({required this.id, required this.firstName, required this.lastName, required this.email});
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
}
