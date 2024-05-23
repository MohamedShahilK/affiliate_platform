// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars

part of 'project_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectForm _$ProjectFormFromJson(Map<String, dynamic> json) => ProjectForm(
      status: json['status'] as String?,
      response: json['response'] as String?,
      data: (json['data'] as List<dynamic>?)?.map((e) => _$DataFromJson(e as Map<String, dynamic>)).toList(),
    );

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      tableTitle: json['table_title'] as String?,
      userDesignation: json['user_designation'] as String?,
      contactList: (json['contact_list'] as List<dynamic>?)?.map((e) => _$ContactListFromJson(e as Map<String, dynamic>)).toList(),
      quotationList: (json['quotation_list'] as List<dynamic>?)?.map((e) => _$QuotationListFromJson(e as Map<String, dynamic>)).toList(),
      projectStatus: (json['project_status'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

ContactList _$ContactListFromJson(Map<String, dynamic> json) => ContactList(
      contactID: json['contactID'] as String?,
      contactName: json['contactName'] as String?,
    );

QuotationList _$QuotationListFromJson(Map<String, dynamic> json) => QuotationList(
      quoteID: json['QuoteID'] as String?,
      quoteRefr: json['QuoteRefr'] as String?,
    );
