// ignore_for_file: lines_longer_than_80_chars

import 'package:json_annotation/json_annotation.dart';

part 'get_allcheckout.g.dart';

@JsonSerializable()
class GetAllCheckouts {
  GetAllCheckouts({required this.status, required this.response, required this.data});

  factory GetAllCheckouts.fromJson(Map<String, dynamic> json) => _$GetAllCheckoutsFromJson(json);

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
    required this.employee,
    required this.project,
    required this.fromdate,
    required this.todate,
    required this.projectStatus,
    required this.checkoutData,
    required this.projectList,
    required this.employeeList,
  });

  final String? tableTitle;
  final String? userDesignation;
  final String? userID;
  final String? employee;
  final String? project;
  final String? fromdate;
  final String? todate;
  final String? projectStatus;
  final List<CheckoutData>? checkoutData;
  final List<ProjectList>? projectList;
  final List<EmployeeList>? employeeList;
}

@JsonSerializable()
class CheckoutData {
  CheckoutData({
    required this.firstName,
    required this.lastName,
    required this.id,
    required this.parentId,
    required this.refrMain,
    required this.refrSub,
    required this.checkOutId,
    required this.inTime,
    required this.outTime,
    required this.breakTime,
    required this.hours,
    required this.totalProjects,
  });
  final String? firstName;
  final String? lastName;
  final String? id;
  final String? parentId;
  final String? refrMain;
  final String? refrSub;
  final String? checkOutId;
  final String? inTime;
  final String? outTime;
  final String? breakTime;
  final String? hours;
  final String? totalProjects;
}

@JsonSerializable()
class ProjectList {
  ProjectList({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.customerId,
    required this.quotationId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.contactName,
    required this.quotationRefr,
    required this.quotationName,
  });
  final String? id;
  final String? name;
  final String? description;
  final String? startDate;
  final String? endDate;
  final String? customerId;
  final String? quotationId;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final String? contactName;
  final String? quotationRefr;
  final String? quotationName;
}

@JsonSerializable()
class EmployeeList {
  EmployeeList({
    required this.id,
    required this.userId,
    required this.type,
    required this.joiningDate,
    required this.permanentAddress,
    required this.communicationAddress,
    required this.educationDetails,
    required this.previousExperiences,
    required this.maritalStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.userId2,
    required this.firstName,
    required this.lastName,
    required this.userCode,
    required this.status,
    required this.dname,
    required this.did,
    required this.email,
    required this.mobileNumber,
    required this.salaryCtc,
    required this.userType,
    required this.location,
  });
  final String? id;
  final String? userId;
  final String? type;
  final String? joiningDate;
  final String? permanentAddress;
  final String? communicationAddress;
  final String? educationDetails;
  final String? previousExperiences;
  final String? maritalStatus;
  final String? createdAt;
  final String? updatedAt;
  final String? userId2;
  final String? firstName;
  final String? lastName;
  final String? userCode;
  final String? status;
  final String? dname;
  final String? did;
  final String? email;
  final String? mobileNumber;
  final String? salaryCtc;
  final String? userType;
  final String? location;
}
