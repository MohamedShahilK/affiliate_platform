// ignore_for_file: lines_longer_than_80_chars

import 'package:json_annotation/json_annotation.dart';

part 'view_project.g.dart';

@JsonSerializable()
class ProjectView {
  ProjectView({required this.status, required this.response, required this.data});

  final String? status;
  final String? response;
  final List<Data>? data;
}

@JsonSerializable()
class Data {
  Data({required this.title, required this.id, required this.userID, required this.projects, required this.contactList, required this.quotationList});

  final String? title;
  final String? id;
  final String? userID;
  final Projects? projects;
  final List<ContactList>? contactList;
  final List<QuotationList>? quotationList;
}

@JsonSerializable()
class Projects {
  Projects({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.customerId,
    required this.quotationId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.contactName,
    required this.quotationRefr,
    required this.quotationName,
  });
  final String? id;
  final String? name;
  final String? description;
  final String? startDate;
  final String? endDate;
  final String? customerId;
  final String? quotationId;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final String? contactName;
  final int? quotationRefr;
  final String? quotationName;
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
