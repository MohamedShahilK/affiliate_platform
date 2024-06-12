// ignore_for_file: lines_longer_than_80_chars

import 'package:json_annotation/json_annotation.dart';

part 'get_checkout_form_model.g.dart';

@JsonSerializable()
class GetCheckOutFormModel {
  GetCheckOutFormModel({required this.status, required this.response, required this.data});

  factory GetCheckOutFormModel.fromJson(Map<String, dynamic> json) => _$GetCheckOutFormModelFromJson(json);

  final String? status;
  final String? response;
  final List<Data>? data;
}

@JsonSerializable()
class Data {
  Data({
    required this.tableTitle,
    required this.isdate,
    required this.userDesignation,
    required this.userID,
    required this.projectList,
    required this.employeeList,
    required this.checkOutProjectData,
    required this.checkInId,
    required this.workFrom,
    required this.checkIndatetime,
  });
  final String? tableTitle;
  final String? isdate;
  final String? userDesignation;
  final String? userID;
  final List<ProjectList>? projectList;
  final List<EmployeeList>? employeeList;
  final List<CheckOutProjectData>? checkOutProjectData;
  final String? checkInId;
  final String? workFrom;
  final String? checkIndatetime;
}

@JsonSerializable()
class ProjectList {
  ProjectList({required this.id, required this.name});
  final String? id;
  final String? name;
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
class CheckOutProjectData {
  CheckOutProjectData({
    required this.id,
    required this.employee,
    required this.datetime,
    required this.workFrom,
    required this.remarks,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.latitude,
    required this.longitude,
    required this.projectname,
    required this.parentId,
    required this.projects,
    required this.checkinProjects,
    required this.reqHoursMin,
    required this.reqFullTime,
    required this.checkInSubId,
    required this.checkInMainId,
  });
  final String? id;
  final String? employee;
  final String? datetime;
  final String? workFrom;
  final String? remarks;
  final String? createdAt;
  final String? updatedAt;
  final String? status;
  final String? latitude;
  final String? longitude;
  final String? projectname;
  final String? parentId;
  final String? projects;
  final String? checkinProjects;
  final String? reqHoursMin;
  final String? reqFullTime;
  final String? checkInSubId;
  final String? checkInMainId;
}
