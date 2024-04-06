// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_form_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactFormModel _$ContactFormModelFromJson(Map<String, dynamic> json) =>
    ContactFormModel(
      status: json['status'] as String?,
      response: json['response'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContactFormModelToJson(ContactFormModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'response': instance.response,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      title: json['title'] as String?,
      contactSources: (json['contactSources'] as List<dynamic>?)
          ?.map((e) => ContactSources.fromJson(e as Map<String, dynamic>))
          .toList(),
      contactType: json['contactType'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'title': instance.title,
      'contactSources': instance.contactSources,
      'contactType': instance.contactType,
    };

ContactSources _$ContactSourcesFromJson(Map<String, dynamic> json) =>
    ContactSources()
      ..id = json['id'] as String?
      ..sourceName = json['sourceName'] as String?
      ..status = json['status'] as String?;

Map<String, dynamic> _$ContactSourcesToJson(ContactSources instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sourceName': instance.sourceName,
      'status': instance.status,
    };
