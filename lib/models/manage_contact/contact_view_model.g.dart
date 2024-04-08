// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars

part of 'contact_view_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactViewModel _$ContactViewModelFromJson(Map<String, dynamic> json) => ContactViewModel(
      status: json['status'] as String?,
      response: json['response'] as String?,
      data: (json['data'] as List<dynamic>?)?.map((e) => _$DataFromJson(e as Map<String, dynamic>)).toList(),
    );

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      title: json['title'] as String?,
      id: json['id'] as String?,
      contact: json['contact'] == null ? null : _$ContactFromJson(json['contact'] as Map<String, dynamic>),
      contactFollowups: (json['contactFollowups'] as List<dynamic>?)?.map((e) => _$ContactFollowupsFromJson(e as Map<String, dynamic>)).toList(),
      affiliateUsers: (json['affiliateUsers'] as List<dynamic>?)?.map((e) => _$AffiliateUsersFromJson(e as Map<String, dynamic>)).toList(),
      userPermissions: (json['userPermissions'] as List<dynamic>?)?.map((e) => _$UserPermissionsFromJson(e as Map<String, dynamic>)).toList(),
      permissionUserIds: (json['permissionUserIds'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Contact _$ContactFromJson(Map<String, dynamic> json) => Contact(
      id: json['id'] as String?,
      name: json['name'] as String?,
      contactType: json['contactType'] as String?,
      email: json['email'] as String?,
      mobile: json['mobile'] as String?,
      company: json['company'] as String?,
      designation: json['designation'] as String?,
      companyAddress: json['companyAddress'] as String?,
      companyWebsite: json['companyWebsite'] as String?,
      companyLandline: json['companyLandline'] as String?,
      companyLocation: json['companyLocation'] as String?,
      remarks: json['remarks'] as String?,
      status: json['status'] as String?,
      nextFollowup: json['nextFollowup'] as String?,
      completedPercentage: json['completedPercentage'] as String?,
      contactSource: json['contactSource'] as String?,
      createdBy: json['createdBy'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      username: json['username'] as String?,
      profilePic: json['profilePic'] as String?,
      sourceName: json['sourceName'] as String?,
    );

ContactFollowups _$ContactFollowupsFromJson(Map<String, dynamic> json) => ContactFollowups(
      id: json['id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      nextFollowupDate: json['nextFollowupDate'] as String?,
      type: json['type'] as String?,
      fKey: json['fKey'] as String?,
      status: json['status'] as String?,
      createdBy: json['createdBy'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      profilePic: json['profilePic'] as String?,
    );

AffiliateUsers _$AffiliateUsersFromJson(Map<String, dynamic> json) => AffiliateUsers(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
    );

UserPermissions _$UserPermissionsFromJson(Map<String, dynamic> json) => UserPermissions(
      contactId: json['contactId'] as String?,
      userId: json['userId'] as String?,
    );
