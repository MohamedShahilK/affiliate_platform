// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars

part of 'leave_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllLeaves _$GetAllLeavesFromJson(Map<String, dynamic> json) => GetAllLeaves(
      status: json['status'] as String?,
      response: json['response'] as String?,
      data: (json['data'] as List<dynamic>?)?.map((e) => _$DataFromJson(e as Map<String, dynamic>)).toList(),
    );

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      tableTitle: json['table_title'] as String?,
      // userDesignation: json['user_Designation'] as String?,
      userID: json['user_ID'] as String?,
      totalLeaves: json['total_leaves'] as int?,
      leavesList: (json['leaves_list'] as List<dynamic>?)?.map((e) => _$LeavesListFromJson(e as Map<String, dynamic>)).toList(),
      leavesType: (json['leaves_type'] as List<dynamic>?)?.map((e) => _$LeavesTypeFromJson(e as Map<String, dynamic>)).toList(),
      leavesDuration: json['leaves_duration'] == null
          ? null
          : _$LeavesDurationFromJson(
              json['leaves_duration'] as Map<String, dynamic>,
            ),
      users: (json['employee_list'] as List<dynamic>?)?.map((e) => _$UsersFromJson(e as Map<String, dynamic>)).toList(),
    );

LeavesList _$LeavesListFromJson(Map<String, dynamic> json) => LeavesList(
      id: json['id'] as String?,
      employee: json['employee'] as String?,
      leaveDate: json['leave_date'] as String?,
      leaveDuration: json['leave_duration'] as String?,
      leaveType: json['leave_type'] as String?,
      leaveStartDate: json['leave_start_date'] as String?,
      leaveEndDate: json['leave_end_date'] as String?,
      leavesIntervals: json['leaves_intervals'] as String?,
      leavesHouroffText: json['leaves_houroff_text'] as String?,
      leaveReason: json['leave_reason'] as String?,
      status: json['status'] as String?,
      approvalStatus: json['approval_status'] as String?,
      approvalStatusRemarks: json['approval_status_remarks'] as String?,
      approvalBy: json['approval_by'] as String?,
      approvalOn: json['approval_on'] as String?,
      bridgeLeave: json['bridge_leave'] as String?,
      createdBy: json['created_by'] as String?,
      createdAt: json['created_at'] as String?,
      updatedBy: json['updated_by'] as String?,
      updatedAt: json['updated_at'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      userCode: json['user_code'] as String?,
      leavesTypeName: json['leaves_type_name'] as String?,
    );

LeavesType _$LeavesTypeFromJson(Map<String, dynamic> json) => LeavesType(
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

Users _$UsersFromJson(Map<String, dynamic> json) => Users(
      id: json['id'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      userCode: json['user_code'] as String?,
    );
