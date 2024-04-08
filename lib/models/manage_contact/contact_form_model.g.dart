// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars

part of 'contact_form_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactFormModel _$ContactFormModelFromJson(Map<String, dynamic> json) => ContactFormModel(
      status: json['status'] as String?,
      response: json['response'] as String?,
      data: (json['data'] as List<dynamic>?)?.map((e) => _$DataFromJson(e as Map<String, dynamic>)).toList(),
    );

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      title: json['title'] as String?,
      contactSources: (json['contactSources'] as List<dynamic>?)?.map((e) => _$ContactSourcesFromJson(e as Map<String, dynamic>)).toList(),
      contactType: json['contactType'] as Map<String, dynamic>?,
    );

ContactSources _$ContactSourcesFromJson(Map<String, dynamic> json) => ContactSources(
  id: json['id'] as String?,
  sourceName: json['source_name'] as String?,
  status: json['status'] as String?,
);
