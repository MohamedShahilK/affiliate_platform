// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_checkin_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCheckinForm _$GetCheckinFormFromJson(Map<String, dynamic> json) =>
    GetCheckinForm(
      status: json['status'] as String?,
      response: json['response'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetCheckinFormToJson(GetCheckinForm instance) =>
    <String, dynamic>{
      'status': instance.status,
      'response': instance.response,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      tableTitle: json['tableTitle'] as String?,
      userDesignation: json['userDesignation'] as String?,
      userID: json['userID'] as String?,
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
      'userID': instance.userID,
      'projectList': instance.projectList,
      'employeeList': instance.employeeList,
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
    );

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
