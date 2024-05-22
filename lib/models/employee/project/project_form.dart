// ignore_for_file: lines_longer_than_80_chars

import 'package:json_annotation/json_annotation.dart';

part 'project_form.g.dart';

@JsonSerializable()
class ProjectForm {
  ProjectForm({required this.status, required this.response, required this.data});

  factory ProjectForm.fromJson(Map<String, dynamic> json) => _$ProjectFormFromJson(json);

  final String? status;
  final String? response;
  final List<Data>? data;
}

@JsonSerializable()
class Data {
  Data({
    required this.tableTitle,
    required this.userDesignation,
    required this.contactList,
    required this.quotationList,
    required this.projectStatus,
  });
  final String? tableTitle;
  final String? userDesignation;
  final List<ContactList>? contactList;
  final List<QuotationList>? quotationList;
  final List<String>? projectStatus;
}

@JsonSerializable()
class ContactList {
  ContactList({required this.contactID, required this.contactName});
  final String? contactID;
  final String? contactName;
}

@JsonSerializable()
class QuotationList {
  QuotationList({required this.quoteID, required this.quoteRefr});
  final String? quoteID;
  final String? quoteRefr;
}
