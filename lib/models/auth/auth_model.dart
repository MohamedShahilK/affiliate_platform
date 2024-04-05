// ignore_for_file: lines_longer_than_80_chars

import 'package:json_annotation/json_annotation.dart';

part 'auth_model.g.dart';

@JsonSerializable()
class AuthModel {
  AuthModel({required this.status, required this.response, required this.accessToken});

  factory AuthModel.fromJson(Map<String, dynamic> json) => _$AuthModelFromJson(json);

  final String? status;
  final String? response;
  final String? accessToken;
}
