// ignore_for_file: lines_longer_than_80_chars

import 'package:json_annotation/json_annotation.dart';

part 'contact_upload_resp_model.g.dart';

@JsonSerializable()
class ContactFormUploadRespModel {
  ContactFormUploadRespModel({this.status, this.response, this.data});

  factory ContactFormUploadRespModel.fromJson(Map<String, dynamic> json) => _$ContactFormUploadRespModelFromJson(json);

  final String? status;
  final String? response;
  final List<Data>? data;
}

@JsonSerializable()
class Data {
  Data({this.title, this.contactSources, this.contactType, this.contact});

  final String? title;
  final List<ContactSources>? contactSources;
  final Map<String, dynamic>? contactType;
  final Contact2? contact;
}

@JsonSerializable()
class ContactSources {
  ContactSources({this.id, this.sourceName, this.status});

  final String? id;
  final String? sourceName;
  final String? status;
}

@JsonSerializable()
class Contact2 {
  Contact2({
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
