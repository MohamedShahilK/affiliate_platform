// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars

part of 'get_checkin_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCheckinForm _$GetCheckinFormFromJson(Map<String, dynamic> json) => GetCheckinForm(
      status: json['status'] as String?,
      response: json['response'] as String?,
      data: (json['data'] as List<dynamic>?)?.map((e) => _$DataFromJson(e as Map<String, dynamic>)).toList(),
    );

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      tableTitle: json['table_title'] as String?,
      userDesignation: json['user_Designation'] as String?,
      userID: json['user_ID'] as String?,
      projectList: (json['project_list'] as List<dynamic>?)?.map((e) => _$ProjectListFromJson(e as Map<String, dynamic>)).toList(),
      employeeList: (json['employee_list'] as List<dynamic>?)?.map((e) => _$EmployeeListFromJson(e as Map<String, dynamic>)).toList(),
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
      quotationRefr: json['quotation_refr'] as String?,
      quotationName: json['quotation_name'] as String?,
    );

EmployeeList _$EmployeeListFromJson(Map<String, dynamic> json) => EmployeeList(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      type: json['type'] as String?,
      joiningDate: json['joining_date'] as String?,
      permanentAddress: json['permanent_address'] as String?,
      communicationAddress: json['communication_address'] as String?,
      educationDetails: json['education_details'] as String?,
      previousExperiences: json['previous_experiences'] as String?,
      maritalStatus: json['marital_status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      userCode: json['user_code'] as String?,
      status: json['status'] as String?,
      dname: json['dname'] as String?,
      did: json['did'] as String?,
      email: json['email'] as String?,
      mobileNumber: json['mobile_number'] as String?,
      salaryCtc: json['salary_ctc'] as String?,
      userType: json['user_type'] as String?,
      location: json['location'] as String?,
    );
