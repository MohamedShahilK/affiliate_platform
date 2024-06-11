// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_checkout_view.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCheckOutView _$GetCheckOutViewFromJson(Map<String, dynamic> json) =>
    GetCheckOutView(
      status: json['status'] as String?,
      response: json['response'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetCheckOutViewToJson(GetCheckOutView instance) =>
    <String, dynamic>{
      'status': instance.status,
      'response': instance.response,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      tableTitle: json['tableTitle'] as String?,
      userDesignation: json['userDesignation'] as String?,
      checkout: json['checkout'] == null
          ? null
          : Checkout.fromJson(json['checkout'] as Map<String, dynamic>),
      checkoutDetails: (json['checkoutDetails'] as List<dynamic>?)
          ?.map((e) => CheckoutDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      userID: json['userID'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'tableTitle': instance.tableTitle,
      'userDesignation': instance.userDesignation,
      'checkout': instance.checkout,
      'checkoutDetails': instance.checkoutDetails,
      'userID': instance.userID,
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
