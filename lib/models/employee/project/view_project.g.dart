// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars

part of 'view_project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectView _$ProjectViewFromJson(Map<String, dynamic> json) => ProjectView(
      status: json['status'] as String?,
      response: json['response'] as String?,
      data: (json['data'] as List<dynamic>?)?.map((e) => _$DataFromJson(e as Map<String, dynamic>)).toList(),
    );

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      title: json['title'] as String?,
      id: json['id'] as String?,
      userID: json['user_ID'] as String?,
      projects: json['projects'] == null ? null : _$ProjectsFromJson(json['projects'] as Map<String, dynamic>),
      contactList: (json['contact_list'] as List<dynamic>?)?.map((e) => _$ContactListFromJson(e as Map<String, dynamic>)).toList(),
      quotationList: (json['quotation_list'] as List<dynamic>?)?.map((e) => _$QuotationListFromJson(e as Map<String, dynamic>)).toList(),
    );

Projects _$ProjectsFromJson(Map<String, dynamic> json) => Projects(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      customerId: json['customer_id'] as String?,
      quotationId: json['quotation_id'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      contactName: json['contact_name'] as String?,
      quotationRefr: json['quotation_refr'] as int?,
      quotationName: json['quotation_name'] as String?,
    );

ContactList _$ContactListFromJson(Map<String, dynamic> json) => ContactList(
      contactID: json['contactID'] as String?,
      contactName: json['contactName'] as String?,
    );

QuotationList _$QuotationListFromJson(Map<String, dynamic> json) => QuotationList(
      quoteID: json['quoteID'] as String?,
      quoteRefr: json['quoteRefr'] as String?,
    );
