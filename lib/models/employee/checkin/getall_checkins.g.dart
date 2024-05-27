// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getall_checkins.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllCheckIns _$GetAllCheckInsFromJson(Map<String, dynamic> json) =>
    GetAllCheckIns(
      status: json['status'] as String?,
      response: json['response'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllCheckInsToJson(GetAllCheckIns instance) =>
    <String, dynamic>{
      'status': instance.status,
      'response': instance.response,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      tableTitle: json['tableTitle'] as String?,
      userDesignation: json['userDesignation'] as String?,
      employee: json['employee'] as String?,
      userID: json['userID'] as String?,
      project: json['project'] as String?,
      fromdate: json['fromdate'] as String?,
      todate: json['todate'] as String?,
      workfrom: json['workfrom'] as String?,
      checkinData: (json['checkinData'] as List<dynamic>?)
          ?.map((e) => CheckinData.fromJson(e as Map<String, dynamic>))
          .toList(),
      projectList: (json['projectList'] as List<dynamic>?)
          ?.map((e) => ProjectList.fromJson(e as Map<String, dynamic>))
          .toList(),
      employeeList: (json['employeeList'] as List<dynamic>?)
          ?.map((e) => EmployeeList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'tableTitle': instance.tableTitle,
      'userDesignation': instance.userDesignation,
      'employee': instance.employee,
      'userID': instance.userID,
      'project': instance.project,
      'fromdate': instance.fromdate,
      'todate': instance.todate,
      'workfrom': instance.workfrom,
      'checkinData': instance.checkinData,
      'projectList': instance.projectList,
      'employeeList': instance.employeeList,
    };

CheckinData _$CheckinDataFromJson(Map<String, dynamic> json) => CheckinData(
      id: json['id'] as String?,
      employee: json['employee'] as String?,
      datetime: json['datetime'] as String?,
      remarks: json['remarks'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      status: json['status'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      checkInId: json['checkInId'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      parentId: json['parentId'] as String?,
      projectId: json['projectId'] as String?,
      workingRemarks: json['workingRemarks'] as String?,
      projects: json['projects'] as String?,
      workFrom: json['workFrom'] as String?,
      hours: json['hours'] as String?,
    );

Map<String, dynamic> _$CheckinDataToJson(CheckinData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employee': instance.employee,
      'datetime': instance.datetime,
      'workFrom': instance.workFrom,
      'remarks': instance.remarks,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'status': instance.status,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'checkInId': instance.checkInId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'parentId': instance.parentId,
      'projectId': instance.projectId,
      'workingRemarks': instance.workingRemarks,
      'projects': instance.projects,
      'hours': instance.hours,
    };

ProjectList _$ProjectListFromJson(Map<String, dynamic> json) => ProjectList(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      customerId: json['customerId'] as String?,
      quotationId: json['quotationId'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      contactName: json['contactName'] as String?,
      quotationRefr: json['quotationRefr'] as String?,
      quotationName: json['quotationName'] as String?,
    )..workFrom = json['workFrom'] as String?;

Map<String, dynamic> _$ProjectListToJson(ProjectList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'customerId': instance.customerId,
      'quotationId': instance.quotationId,
      'status': instance.status,
      'workFrom': instance.workFrom,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'contactName': instance.contactName,
      'quotationRefr': instance.quotationRefr,
      'quotationName': instance.quotationName,
    };

EmployeeList _$EmployeeListFromJson(Map<String, dynamic> json) => EmployeeList(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      type: json['type'] as String?,
      joiningDate: json['joiningDate'] as String?,
      permanentAddress: json['permanentAddress'] as String?,
      communicationAddress: json['communicationAddress'] as String?,
      educationDetails: json['educationDetails'] as String?,
      previousExperiences: json['previousExperiences'] as String?,
      maritalStatus: json['maritalStatus'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      userCode: json['userCode'] as String?,
      status: json['status'] as String?,
      dname: json['dname'] as String?,
      did: json['did'] as String?,
      email: json['email'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      salaryCtc: json['salaryCtc'] as String?,
      userType: json['userType'] as String?,
      location: json['location'] as String?,
    );

Map<String, dynamic> _$EmployeeListToJson(EmployeeList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': instance.type,
      'joiningDate': instance.joiningDate,
      'permanentAddress': instance.permanentAddress,
      'communicationAddress': instance.communicationAddress,
      'educationDetails': instance.educationDetails,
      'previousExperiences': instance.previousExperiences,
      'maritalStatus': instance.maritalStatus,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'userCode': instance.userCode,
      'status': instance.status,
      'dname': instance.dname,
      'did': instance.did,
      'email': instance.email,
      'mobileNumber': instance.mobileNumber,
      'salaryCtc': instance.salaryCtc,
      'userType': instance.userType,
      'location': instance.location,
    };
