// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_form_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetLeaveForm _$GetLeaveFormFromJson(Map<String, dynamic> json) => GetLeaveForm(
      status: json['status'] as String?,
      response: json['response'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetLeaveFormToJson(GetLeaveForm instance) =>
    <String, dynamic>{
      'status': instance.status,
      'response': instance.response,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      userID: json['userID'] as String?,
      title: json['title'] as String?,
      employeeList: (json['employeeList'] as List<dynamic>?)
          ?.map((e) => EmployeeList.fromJson(e as Map<String, dynamic>))
          .toList(),
      leavesType: (json['leavesType'] as List<dynamic>?)
          ?.map((e) => LeavesType.fromJson(e as Map<String, dynamic>))
          .toList(),
      leavesDuration: json['leavesDuration'] == null
          ? null
          : LeavesDuration.fromJson(
              json['leavesDuration'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'userID': instance.userID,
      'title': instance.title,
      'employeeList': instance.employeeList,
      'leavesType': instance.leavesType,
      'leavesDuration': instance.leavesDuration,
    };

EmployeeList _$EmployeeListFromJson(Map<String, dynamic> json) => EmployeeList(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      userCode: json['userCode'] as String?,
    );

Map<String, dynamic> _$EmployeeListToJson(EmployeeList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'userCode': instance.userCode,
    };

LeavesType _$LeavesTypeFromJson(Map<String, dynamic> json) => LeavesType(
      id: json['id'] as String?,
      name: json['name'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$LeavesTypeToJson(LeavesType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

LeavesDuration _$LeavesDurationFromJson(Map<String, dynamic> json) =>
    LeavesDuration(
      s1: json['s1'] as String?,
      s2: json['s2'] as String?,
      s3: json['s3'] as String?,
      s4: json['s4'] as String?,
    );

Map<String, dynamic> _$LeavesDurationToJson(LeavesDuration instance) =>
    <String, dynamic>{
      's1': instance.s1,
      's2': instance.s2,
      's3': instance.s3,
      's4': instance.s4,
    };
