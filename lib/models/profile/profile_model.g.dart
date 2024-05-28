// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProfileView _$GetProfileViewFromJson(Map<String, dynamic> json) => GetProfileView(
      status: json['status'] as String?,
      response: json['response'] as String?,
      data: (json['data'] as List<dynamic>?)?.map((e) => _$DataFromJson(e as Map<String, dynamic>)).toList(),
    );

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      tableTitle: json['table_title'] as String?,
      userDesignation: json['user_Designation'] as String?,
      userID: json['user_ID'] as String?,
      employee: json['employee'] == null ? null : _$EmployeeFromJson(json['employee'] as Map<String, dynamic>),
    );

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      type: json['type'] as String?,
      joiningDate: json['joining_date'] as String?,
      permanentAddress: json['permanent_address'] as String?,
      communicationAddress: json['communication_address'] as String?,
      educationDetails: json['education_details'] as String?,
      previousExperiences: json['previous_experiences'] as String?,
      maritalStatus: json['marital_status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      userId2: json['userId'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      userCode: json['user_code'] as String?,
      status: json['status'] as String?,
      mobileNumber: json['mobile_number'] as String?,
      email: json['email'] as String?,
      desName: json['des_name'] as String?,
      desId: json['des_id'] as String?,
      password: json['password'] as String?,
      profilePic: json['profile_pic'] as String?,
      userType: json['user_type'] as String?,
      location: json['location'] as String?,
    );
