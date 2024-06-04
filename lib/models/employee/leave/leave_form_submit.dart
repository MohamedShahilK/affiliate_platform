// ignore_for_file: lines_longer_than_80_chars

import 'package:json_annotation/json_annotation.dart';
part 'leave_form_submit.g.dart';

@JsonSerializable()
class GetLeaveFormSubmit {
  GetLeaveFormSubmit({required this.status, required this.response, required this.message, required this.data});

  factory GetLeaveFormSubmit.fromJson(Map<String, dynamic> json) => _$GetLeaveFormSubmitFromJson(json);

  final String? status;
  final String? response;
  final String? message;
  final List<Data>? data;
}

@JsonSerializable()
class Data {
  Data({
    required this.title,
    required this.userID,
  });
  final String? title;
  final String? userID;
}
