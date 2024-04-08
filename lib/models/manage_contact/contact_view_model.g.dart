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
      contactFollowups: (json['contact_followups'] as List<dynamic>?)?.map((e) => _$ContactFollowupsFromJson(e as Map<String, dynamic>)).toList(),
      affiliateUsers: (json['affiliate_users'] as List<dynamic>?)?.map((e) => _$AffiliateUsersFromJson(e as Map<String, dynamic>)).toList(),
      userPermissions: (json['user_permissions'] as List<dynamic>?)?.map((e) => _$UserPermissionsFromJson(e as Map<String, dynamic>)).toList(),
      permissionUserIds: (json['permission_user_ids'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Contact _$ContactFromJson(Map<String, dynamic> json) => Contact(
      id: json['id'] as String?,
      name: json['name'] as String?,
      contactType: json['contact_type'] as String?,
      email: json['email'] as String?,
      mobile: json['mobile'] as String?,
      company: json['company'] as String?,
      designation: json['designation'] as String?,
      companyAddress: json['company_address'] as String?,
      companyWebsite: json['company_website'] as String?,
      companyLandline: json['company_landline'] as String?,
      companyLocation: json['company_location'] as String?,
      remarks: json['remarks'] as String?,
      status: json['status'] as String?,
      nextFollowup: json['next_followup'] as String?,
      completedPercentage: json['completed_percentage'] as String?,
      contactSource: json['contact_source'] as String?,
      createdBy: json['created_by'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      username: json['username'] as String?,
      profilePic: json['profile_pic'] as String?,
      sourceName: json['source_name'] as String?,
    );

ContactFollowups _$ContactFollowupsFromJson(Map<String, dynamic> json) => ContactFollowups(
      id: json['id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      nextFollowupDate: json['next_followup_date'] as String?,
      type: json['type'] as String?,
      fKey: json['f_key'] as String?,
      status: json['status'] as String?,
      createdBy: json['created_by'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      profilePic: json['profile_pic'] as String?,
    );

AffiliateUsers _$AffiliateUsersFromJson(Map<String, dynamic> json) => AffiliateUsers(
      id: json['id'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
    );

UserPermissions _$UserPermissionsFromJson(Map<String, dynamic> json) => UserPermissions(
      contactId: json['contact_id'] as String?,
      userId: json['user_id'] as String?,
    );
