// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars

part of 'all_contacts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllContactsAndUsers _$GetAllContactsAndUsersFromJson(Map<String, dynamic> json) => GetAllContactsAndUsers(
      status: json['status'] as String?,
      response: json['response'] as String?,
      data1: (json['data'] as List<dynamic>?)?.map((e) => _$DataFromJson(e as Map<String, dynamic>)).toList(),
    );

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      tableTitle: json['table_title'] as String?,
      contactTypeSearch: json['contact_type_search'] as String?,
      contactsSearch: json['contacts_search'] as String?,
      followupDateSearch: json['followup_date_search'] as String?,
      followupDateSearchTo: json['followup_date_search_to'] as String?,
      createdDateSearch: json['created_date_search'] as String?,
      createdDateSearchTo: json['created_date_search_to'] as String?,
      contactsCompletedPercentageSearch: json['contacts_completed_percentage_search'] as String?,
      createdBySearch: json['created_by_search'] as String?,
      totalContacts: json['total_contacts'] as int?,
      contacts: (json['contacts'] as List<dynamic>?)?.map((e) => _$ContactsFromJson(e as Map<String, dynamic>)).toList(), 
      users: (json['users'] as List<dynamic>?)?.map((e) => _$UsersFromJson(e as Map<String, dynamic>)).toList(),
    );

Users _$UsersFromJson(Map<String, dynamic> json) => Users(
      id: json['id'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
    );

Contacts _$ContactsFromJson(Map<String, dynamic> json) => Contacts(
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
