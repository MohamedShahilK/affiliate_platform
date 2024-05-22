// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars

part of 'get_all_projects.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllProjects _$GetAllProjectsFromJson(Map<String, dynamic> json) => GetAllProjects(
      status: json['status'] as String?,
      response: json['response'] as String?,
      data: (json['data'] as List<dynamic>?)?.map((e) => _$DataFromJson(e as Map<String, dynamic>)).toList(),
    );

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      tableTitle: json['table_title'] as String?,
      userDesignation: json['user_designation'] as String?,
      keywordSearch: json['keyword_search'] as String?,
      statusSearch: json['status_search'] as int?,
      userID: json['user_iD'] as String?,
      projectStatus: (json['project_status'] as List<dynamic>?)?.map((e) => e as String).toList(),
      projectList: (json['project_list'] as List<dynamic>?)?.map((e) => _$ProjectListFromJson(e as Map<String, dynamic>)).toList(),
    );

ProjectList _$ProjectListFromJson(Map<String, dynamic> json) => ProjectList(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      customerId: json['customer_id'] as String?,
      quotationId: json['quotation_id'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      contactName: json['contact_name'] as String?,
      quotationRefr: json['quotation_refr'] as int?,
      quotationName: json['quotation_name'] as String?,
    );
