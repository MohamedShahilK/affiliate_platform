// ignore_for_file: lines_longer_than_80_chars

import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class GetProfileView {
  GetProfileView({required this.status, required this.response, required this.data});

  factory GetProfileView.fromJson(Map<String, dynamic> json) => _$GetProfileViewFromJson(json);

  final String? status;
  final String? response;
  final List<Data>? data;
}

@JsonSerializable()
class Data {
  Data({required this.tableTitle, required this.userDesignation, required this.userID, required this.employee});
  final String? tableTitle;
  final String? userDesignation;
  final String? userID;
  final Employee? employee;
}

@JsonSerializable()
class Employee {
  Employee({
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
    required this.mobileNumber,
    required this.email,
    required this.desName,
    required this.desId,
    required this.password,
    required this.profilePic,
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
  final String? mobileNumber;
  final String? email;
  final String? desName;
  final String? desId;
  final String? password;
  final String? profilePic;
  final String? userType;
  final String? location;
}
