// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_view_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactViewModel _$ContactViewModelFromJson(Map<String, dynamic> json) =>
    ContactViewModel(
      status: json['status'] as String?,
      response: json['response'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContactViewModelToJson(ContactViewModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'response': instance.response,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      title: json['title'] as String?,
      id: json['id'] as String?,
      contact: json['contact'] == null
          ? null
          : Contact.fromJson(json['contact'] as Map<String, dynamic>),
      contactFollowups: (json['contactFollowups'] as List<dynamic>?)
          ?.map((e) => ContactFollowups.fromJson(e as Map<String, dynamic>))
          .toList(),
      affiliateUsers: (json['affiliateUsers'] as List<dynamic>?)
          ?.map((e) => AffiliateUsers.fromJson(e as Map<String, dynamic>))
          .toList(),
      userPermissions: (json['userPermissions'] as List<dynamic>?)
          ?.map((e) => UserPermissions.fromJson(e as Map<String, dynamic>))
          .toList(),
      permissionUserIds: (json['permissionUserIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'contact': instance.contact,
      'contactFollowups': instance.contactFollowups,
      'affiliateUsers': instance.affiliateUsers,
      'userPermissions': instance.userPermissions,
      'permissionUserIds': instance.permissionUserIds,
    };

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

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'contactType': instance.contactType,
      'email': instance.email,
      'mobile': instance.mobile,
      'company': instance.company,
      'designation': instance.designation,
      'companyAddress': instance.companyAddress,
      'companyWebsite': instance.companyWebsite,
      'companyLandline': instance.companyLandline,
      'companyLocation': instance.companyLocation,
      'remarks': instance.remarks,
      'status': instance.status,
      'nextFollowup': instance.nextFollowup,
      'completedPercentage': instance.completedPercentage,
      'contactSource': instance.contactSource,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'username': instance.username,
      'profilePic': instance.profilePic,
      'sourceName': instance.sourceName,
    };

ContactFollowups _$ContactFollowupsFromJson(Map<String, dynamic> json) =>
    ContactFollowups(
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

Map<String, dynamic> _$ContactFollowupsToJson(ContactFollowups instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'nextFollowupDate': instance.nextFollowupDate,
      'type': instance.type,
      'fKey': instance.fKey,
      'status': instance.status,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'profilePic': instance.profilePic,
    };

AffiliateUsers _$AffiliateUsersFromJson(Map<String, dynamic> json) =>
    AffiliateUsers(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$AffiliateUsersToJson(AffiliateUsers instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
    };

UserPermissions _$UserPermissionsFromJson(Map<String, dynamic> json) =>
    UserPermissions(
      contactId: json['contactId'] as String?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$UserPermissionsToJson(UserPermissions instance) =>
    <String, dynamic>{
      'contactId': instance.contactId,
      'userId': instance.userId,
    };
