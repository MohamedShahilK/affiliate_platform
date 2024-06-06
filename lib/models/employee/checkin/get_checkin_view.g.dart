// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_checkin_view.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCheckInView _$GetCheckInViewFromJson(Map<String, dynamic> json) =>
    GetCheckInView(
      status: json['status'] as String?,
      response: json['response'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetCheckInViewToJson(GetCheckInView instance) =>
    <String, dynamic>{
      'status': instance.status,
      'response': instance.response,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      tableTitle: json['tableTitle'] as String?,
      userDesignation: json['userDesignation'] as String?,
      outId: json['outId'] as String?,
      checkout: json['checkout'] == null
          ? null
          : Checkout.fromJson(json['checkout'] as Map<String, dynamic>),
      checkoutDetails: (json['checkoutDetails'] as List<dynamic>?)
          ?.map((e) => CheckoutDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      userID: json['userID'] as String?,
      checkinData: json['checkinData'] == null
          ? null
          : CheckinData.fromJson(json['checkinData'] as Map<String, dynamic>),
      checkinProjects: (json['checkinProjects'] as List<dynamic>?)
          ?.map((e) => CheckinProjects.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'tableTitle': instance.tableTitle,
      'userDesignation': instance.userDesignation,
      'outId': instance.outId,
      'checkout': instance.checkout,
      'checkoutDetails': instance.checkoutDetails,
      'userID': instance.userID,
      'checkinData': instance.checkinData,
      'checkinProjects': instance.checkinProjects,
    };

Checkout _$CheckoutFromJson(Map<String, dynamic> json) => Checkout(
      id: json['id'] as String?,
      parentId: json['parentId'] as String?,
      userCode: json['userCode'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      datetime: json['datetime'] as String?,
      outTime: json['outTime'] as String?,
      breakHours: json['breakHours'] as String?,
      breakHoursRemarks: json['breakHoursRemarks'] as String?,
      remarks: json['remarks'] as String?,
      comments: json['comments'] as String?,
      hours: json['hours'] as String?,
      checkoutWorkFrom: json['checkoutWorkFrom'] as String?,
    );

Map<String, dynamic> _$CheckoutToJson(Checkout instance) => <String, dynamic>{
      'id': instance.id,
      'parentId': instance.parentId,
      'userCode': instance.userCode,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'datetime': instance.datetime,
      'outTime': instance.outTime,
      'breakHours': instance.breakHours,
      'breakHoursRemarks': instance.breakHoursRemarks,
      'remarks': instance.remarks,
      'comments': instance.comments,
      'hours': instance.hours,
      'checkoutWorkFrom': instance.checkoutWorkFrom,
    };

CheckoutDetails _$CheckoutDetailsFromJson(Map<String, dynamic> json) =>
    CheckoutDetails(
      projectname: json['projectname'] as String?,
      checkInRemarks: json['checkInRemarks'] as String?,
      checkOutRemarks: json['checkOutRemarks'] as String?,
      reqHoursMin: json['reqHoursMin'] as String?,
      reqFullTime: json['reqFullTime'] as String?,
      hoursSpent: json['hoursSpent'] as String?,
      hoursSpentFull: json['hoursSpentFull'] as String?,
      projectsStatus: json['projectsStatus'] as String?,
    );

Map<String, dynamic> _$CheckoutDetailsToJson(CheckoutDetails instance) =>
    <String, dynamic>{
      'projectname': instance.projectname,
      'checkInRemarks': instance.checkInRemarks,
      'checkOutRemarks': instance.checkOutRemarks,
      'reqHoursMin': instance.reqHoursMin,
      'reqFullTime': instance.reqFullTime,
      'hoursSpent': instance.hoursSpent,
      'hoursSpentFull': instance.hoursSpentFull,
      'projectsStatus': instance.projectsStatus,
    };

CheckinData _$CheckinDataFromJson(Map<String, dynamic> json) => CheckinData(
      id: json['id'] as String?,
      employee: json['employee'] as String?,
      datetime: json['datetime'] as String?,
      workFrom: json['workFrom'] as String?,
      remarks: json['remarks'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      status: json['status'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      userCode: json['userCode'] as String?,
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
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'userCode': instance.userCode,
    };

CheckinProjects _$CheckinProjectsFromJson(Map<String, dynamic> json) =>
    CheckinProjects(
      id: json['id'] as String?,
      employee: json['employee'] as String?,
      datetime: json['datetime'] as String?,
      workFrom: json['workFrom'] as String?,
      remarks: json['remarks'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      status: json['status'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      projectname: json['projectname'] as String?,
      parentId: json['parentId'] as String?,
      projects: json['projects'] as String?,
      checkinProjects: json['checkinProjects'] as String?,
      reqHoursMin: json['reqHoursMin'] as String?,
      reqFullTime: json['reqFullTime'] as String?,
      checkInSubId: json['checkInSubId'] as String?,
      checkInMainId: json['checkInMainId'] as String?,
    );

Map<String, dynamic> _$CheckinProjectsToJson(CheckinProjects instance) =>
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
      'projectname': instance.projectname,
      'parentId': instance.parentId,
      'projects': instance.projects,
      'checkinProjects': instance.checkinProjects,
      'reqHoursMin': instance.reqHoursMin,
      'reqFullTime': instance.reqFullTime,
      'checkInSubId': instance.checkInSubId,
      'checkInMainId': instance.checkInMainId,
    };
