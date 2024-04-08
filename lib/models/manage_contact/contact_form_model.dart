// ignore_for_file: lines_longer_than_80_chars

import 'package:json_annotation/json_annotation.dart';

part 'contact_form_model.g.dart';

@JsonSerializable()
class ContactFormModel {
  ContactFormModel({this.status, this.response, this.data});

  factory ContactFormModel.fromJson(Map<String, dynamic> json) => _$ContactFormModelFromJson(json);

  final String? status;
  final String? response;
  final List<Data>? data;
}

@JsonSerializable()
class Data {
  Data({this.title, this.contactSources, this.contactType});
  final String? title;
  final List<ContactSources>? contactSources;
  final Map<String, dynamic>? contactType;
}

@JsonSerializable()
class ContactSources {
  ContactSources({this.id, this.sourceName, this.status});

  final String? id;
  final String? sourceName;
  final String? status;
}
