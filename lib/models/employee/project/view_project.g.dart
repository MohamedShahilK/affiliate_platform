// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectView _$ProjectViewFromJson(Map<String, dynamic> json) => ProjectView(
      status: json['status'] as String?,
      response: json['response'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProjectViewToJson(ProjectView instance) =>
    <String, dynamic>{
      'status': instance.status,
      'response': instance.response,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      title: json['title'] as String?,
      id: json['id'] as String?,
      userID: json['userID'] as String?,
      projects: json['projects'] == null
          ? null
          : Projects.fromJson(json['projects'] as Map<String, dynamic>),
      contactList: (json['contactList'] as List<dynamic>?)
          ?.map((e) => ContactList.fromJson(e as Map<String, dynamic>))
          .toList(),
      quotationList: (json['quotationList'] as List<dynamic>?)
          ?.map((e) => QuotationList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'userID': instance.userID,
      'projects': instance.projects,
      'contactList': instance.contactList,
      'quotationList': instance.quotationList,
    };

Projects _$ProjectsFromJson(Map<String, dynamic> json) => Projects(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      customerId: json['customerId'] as String?,
      quotationId: json['quotationId'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      contactName: json['contactName'] as String?,
      quotationRefr: json['quotationRefr'] as int?,
      quotationName: json['quotationName'] as String?,
    );

Map<String, dynamic> _$ProjectsToJson(Projects instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'customerId': instance.customerId,
      'quotationId': instance.quotationId,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'contactName': instance.contactName,
      'quotationRefr': instance.quotationRefr,
      'quotationName': instance.quotationName,
    };

ContactList _$ContactListFromJson(Map<String, dynamic> json) => ContactList(
      contactID: json['contactID'] as String?,
      contactName: json['contactName'] as String?,
    );

Map<String, dynamic> _$ContactListToJson(ContactList instance) =>
    <String, dynamic>{
      'contactID': instance.contactID,
      'contactName': instance.contactName,
    };

QuotationList _$QuotationListFromJson(Map<String, dynamic> json) =>
    QuotationList(
      quoteID: json['quoteID'] as String?,
      quoteRefr: json['quoteRefr'] as String?,
    );

Map<String, dynamic> _$QuotationListToJson(QuotationList instance) =>
    <String, dynamic>{
      'quoteID': instance.quoteID,
      'quoteRefr': instance.quoteRefr,
    };
