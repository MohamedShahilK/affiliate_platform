// ignore_for_file: lines_longer_than_80_chars

import 'package:json_annotation/json_annotation.dart';

part 'contact_view_model.g.dart';

@JsonSerializable()
class ContactViewModel {
  ContactViewModel({this.status, this.response, this.data});

  factory ContactViewModel.fromJson(Map<String, dynamic> json) => _$ContactViewModelFromJson(json);

  final String? status;
  final String? response;
  final List<Data>? data;
}

@JsonSerializable()
class Data {
  Data({this.title, this.id, this.contact, this.contactFollowups, this.affiliateUsers, this.userPermissions, this.permissionUserIds});

  final String? title;
  final String? id;
  final Contact? contact;
  final List<ContactFollowups>? contactFollowups;
  final List<AffiliateUsers>? affiliateUsers;
  final List<UserPermissions>? userPermissions;
  final List<String>? permissionUserIds;
}

@JsonSerializable()
class Contact {
  Contact({
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

@JsonSerializable()
class ContactFollowups {
  ContactFollowups({
    this.id,
    this.title,
    this.description,
    this.nextFollowupDate,
    this.type,
    this.fKey,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.firstName,
    this.lastName,
    this.profilePic,
  });
  final String? id;
  final String? title;
  final String? description;
  final String? nextFollowupDate;
  final String? type;
  final String? fKey;
  final String? status;
  final String? createdBy;
  final String? createdAt;
  final String? updatedAt;
  final String? firstName;
  final String? lastName;
  final String? profilePic;
}

@JsonSerializable()
class AffiliateUsers {
  AffiliateUsers({this.id, this.firstName, this.lastName, this.email});
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
}

@JsonSerializable()
class UserPermissions {
  UserPermissions({this.contactId, this.userId});
  final String? contactId;
  final String? userId;
}
