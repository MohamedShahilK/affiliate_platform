// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars

part of 'getall_checkins.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllCheckIns _$GetAllCheckInsFromJson(Map<String, dynamic> json) => GetAllCheckIns(
      status: json['status'] as String?,
      response: json['response'] as String?,
      data: (json['data'] as List<dynamic>?)?.map((e) => _$DataFromJson(e as Map<String, dynamic>)).toList(),
    );

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      tableTitle: json['table_title'] as String?,
      userDesignation: json['user_Designation'] as String?,
      employee: json['employee'] as String?,
      userID: json['user_ID'] as String?,
      project: json['project'] as String?,
      fromdate: json['fromdate'] as String?,
      todate: json['todate'] as String?,
      workfrom: json['workfrom'] as String?,
      checkinData: (json['checkinlist'] as List<dynamic>?)?.map((e) => _$CheckinDataFromJson(e as Map<String, dynamic>)).toList(),
      projectList: (json['project_list'] as List<dynamic>?)?.map((e) => _$ProjectListFromJson(e as Map<String, dynamic>)).toList(),
      employeeList: (json['employee_list'] as List<dynamic>?)?.map((e) => _$EmployeeListFromJson(e as Map<String, dynamic>)).toList(),
    );

CheckinData _$CheckinDataFromJson(Map<String, dynamic> json) => CheckinData(
      id: json['id'] as String?,
      employee: json['employee'] as String?,
      datetime: json['datetime'] as String?,
      checkInDatetime: json['checkIn_datetime'] as int?,
      remarks: json['remarks'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      status: json['status'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      checkInId: json['check_In_Id'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      parentId: json['parent_id'] as String?,
      projectId: json['project_id'] as String?,
      workingRemarks: json['working_remarks'] as String?,
      projects: json['Projects'] as String?,
      workFrom: json['WorkFrom'] as String?,
      workFromId: json['work_from'] as String?,
      hours: json['Hours'] as String?,
      checkOutStatus: json['check_Out_Status'] as String?,
      checkOutId: json['check_Out_Id'] as String?,
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
      userId: json['user_id'] as String?,
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
