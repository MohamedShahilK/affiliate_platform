// ignore_for_file: lines_longer_than_80_chars

import 'package:json_annotation/json_annotation.dart';

part 'all_contacts.g.dart';

@JsonSerializable()
class GetAllContactsAndUsers {
  GetAllContactsAndUsers({required this.status, required this.response, required this.data1});

  factory GetAllContactsAndUsers.fromJson(Map<String, dynamic> json) => _$GetAllContactsAndUsersFromJson(json);

  final String? status;
  final String? response;
  final List<Data>? data1;
}

@JsonSerializable()
class Data {
  Data({
    this.tableTitle,
    this.contactTypeSearch,
    this.contactsSearch,
    this.followupDateSearch,
    this.followupDateSearchTo,
    this.createdDateSearch,
    this.createdDateSearchTo,
    this.contactsCompletedPercentageSearch,
    this.createdBySearch,
    this.totalContacts,
    this.contacts,
    this.users,
  });
  final String? tableTitle;
  final String? contactTypeSearch;
  final String? contactsSearch;
  final String? followupDateSearch;
  final String? followupDateSearchTo;
  final String? createdDateSearch;
  final String? createdDateSearchTo;
  final String? contactsCompletedPercentageSearch;
  final String? createdBySearch;
  final int? totalContacts;
  final List<Contacts>? contacts;
  final List<Users>? users;
}

@JsonSerializable()
class Users {
  Users({this.id, this.firstName, this.lastName, this.email});
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
}

@JsonSerializable()
class Contacts {
  Contacts({
    this.id,
    this.name,
    this.contactType,
    this.email,
    this.mobile,
    this.company,
    this.designation,
    this.companyAddress,
    this.companyWebsite,
    this.companyLandline,
    this.companyLocation,
    this.remarks,
    this.status,
    this.nextFollowup,
    this.completedPercentage,
    this.contactSource,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.username,
    this.profilePic,
    this.sourceName,
  });
  final String? id;
  final String? name;
  final String? contactType;
  final String? email;
  final String? mobile;
  final String? company;
  final String? designation;
  final String? companyAddress;
  final String? companyWebsite;
  final String? companyLandline;
  final String? companyLocation;
  final String? remarks;
  final String? status;
  final String? nextFollowup;
  final String? completedPercentage;
  final String? contactSource;
  final String? createdBy;
  final String? createdAt;
  final String? updatedAt;
  final String? username;
  final String? profilePic;
  final String? sourceName;
}
