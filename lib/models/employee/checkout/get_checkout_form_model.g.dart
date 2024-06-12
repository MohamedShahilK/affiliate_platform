// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars

part of 'get_checkout_form_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCheckOutFormModel _$GetCheckOutFormModelFromJson(Map<String, dynamic> json) => GetCheckOutFormModel(
      status: json['status'] as String?,
      response: json['response'] as String?,
      data: (json['data'] as List<dynamic>?)?.map((e) => _$DataFromJson(e as Map<String, dynamic>)).toList(),
    );

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      tableTitle: json['table_title'] as String?,
      isdate: json['Isdate'] as String?,
      userDesignation: json['user_Designation'] as String?,
      userID: json['user_ID'] as String?,
      projectList: (json['project_list'] as List<dynamic>?)?.map((e) => _$ProjectListFromJson(e as Map<String, dynamic>)).toList(),
      employeeList: (json['employee_list'] as List<dynamic>?)?.map((e) => _$EmployeeListFromJson(e as Map<String, dynamic>)).toList(),
      checkOutProjectData: (json['check_out_project_data'] as List<dynamic>?)?.map((e) => _$CheckOutProjectDataFromJson(e as Map<String, dynamic>)).toList(),
      checkInId: json['check_in_id'] as String?,
      workFrom: json['work_from'] as String?,
      checkIndatetime: json['checkin_datetime'] as String?,
    );

ProjectList _$ProjectListFromJson(Map<String, dynamic> json) => ProjectList(
      id: json['id'] as String?,
      name: json['name'] as String?,
    );

EmployeeList _$EmployeeListFromJson(Map<String, dynamic> json) => EmployeeList(
      id: json['id'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      userCode: json['user_code'] as String?,
    );

CheckOutProjectData _$CheckOutProjectDataFromJson(Map<String, dynamic> json) => CheckOutProjectData(
      id: json['id'] as String?,
      employee: json['employee'] as String?,
      datetime: json['datetime'] as String?,
      workFrom: json['work_from'] as String?,
      remarks: json['remarks'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      status: json['status'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      projectname: json['projectname'] as String?,
      parentId: json['parent_id'] as String?,
      projects: json['projects'] as String?,
      checkinProjects: json['checkin_projects'] as String?,
      reqHoursMin: json['req_hours_min'] as String?,
      reqFullTime: json['req_full_time'] as String?,
      checkInSubId: json['checkIn_SubId'] as String?,
      checkInMainId: json['checkIn_MainId'] as String?,
    );
