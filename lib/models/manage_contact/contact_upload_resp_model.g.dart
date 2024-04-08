// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars

part of 'contact_upload_resp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactFormUploadRespModel _$ContactFormUploadRespModelFromJson(Map<String, dynamic> json) => ContactFormUploadRespModel(
      status: json['status'] as String?,
      response: json['response'] as String?,
      data: (json['data'] as List<dynamic>?)?.map((e) => _$DataFromJson(e as Map<String, dynamic>)).toList(),
    );

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      title: json['title'] as String?,
      contactSources: (json['contact_sources'] as List<dynamic>?)?.map((e) => _$ContactSourcesFromJson(e as Map<String, dynamic>)).toList(),
      contactType: json['contact_type'] as Map<String, dynamic>?,
      contact: json['contact'] == null ? null : _$Contact2FromJson(json['contact'] as Map<String, dynamic>),
    );

ContactSources _$ContactSourcesFromJson(Map<String, dynamic> json) => ContactSources(
      id: json['id'] as String?,
      sourceName: json['source_name'] as String?,
      status: json['status'] as String?,
    );

Contact2 _$Contact2FromJson(Map<String, dynamic> json) => Contact2(
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
