// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars

part of 'leave_form_submit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetLeaveFormSubmit _$GetLeaveFormSubmitFromJson(Map<String, dynamic> json) => GetLeaveFormSubmit(
      status: json['status'] as String?,
      response: json['response'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)?.map((e) => _$DataFromJson(e as Map<String, dynamic>)).toList(),
    );

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      title: json['title'] as String?,
      userID: json['user_ID'] as String?,
     
    );


