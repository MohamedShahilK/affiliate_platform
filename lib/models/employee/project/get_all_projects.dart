// ignore_for_file: lines_longer_than_80_chars

import 'package:json_annotation/json_annotation.dart';

part 'get_all_projects.g.dart';

@JsonSerializable()
class GetAllProjects {
  GetAllProjects({
    required this.status,
    required this.response,
    required this.data,
  });

  factory GetAllProjects.fromJson(Map<String, dynamic> json) => _$GetAllProjectsFromJson(json);

  final String? status;
  final String? response;
  final List<Data>? data;
}

@JsonSerializable()
class Data {
  Data({
    required this.tableTitle,
    required this.userDesignation,
    required this.keywordSearch,
    required this.statusSearch,
    required this.userID,
    required this.projectStatus,
    required this.projectList,
  });
  final String? tableTitle;
  final String? userDesignation;
  final String? keywordSearch;
  final int? statusSearch;
  final String? userID;
  final List<String>? projectStatus;
  final List<ProjectList>? projectList;
}

@JsonSerializable()
class ProjectList {
  ProjectList({
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
