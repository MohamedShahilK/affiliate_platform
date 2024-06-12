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
          ?.map((e) => _$DataFromJson(e as Map<String, dynamic>))
          .toList(),
    );



Data _$DataFromJson(Map<String, dynamic> json) => Data(
      tableTitle: json['table_title'] as String?,
      userDesignation: json['user_Designation'] as String?,
      checkout: json['checkout'] == null
          ? null
          : _$CheckoutFromJson(json['checkout'] as Map<String, dynamic>),
      checkoutDetails: (json['checkout_details'] as List<dynamic>?)
          ?.map((e) =>  _$CheckoutDetailsFromJson(e as Map<String, dynamic>))
          .toList(),
      userID: json['user_ID'] as String?,
    );


Checkout _$CheckoutFromJson(Map<String, dynamic> json) => Checkout(
      id: json['id'] as String?,
      parentId: json['parent_id'] as String?,
      userCode: json['user_code'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      datetime: json['datetime'] as String?,
      outTime: json['out_time'] as String?,
      breakHours: json['break_hours'] as String?,
      breakHoursRemarks: json['break_hours_remarks'] as String?,
      remarks: json['remarks'] as String?,
      comments: json['comments'] as String?,
      hours: json['Hours'] as String?,
      checkoutWorkFrom: json['checkout_work_from'] as String?,
    );



CheckoutDetails _$CheckoutDetailsFromJson(Map<String, dynamic> json) =>
    CheckoutDetails(
      projectname: json['Projectname'] as String?,
      checkInRemarks: json['CheckInRemarks'] as String?,
      checkOutRemarks: json['CheckOutRemarks'] as String?,
      reqHoursMin: json['req_hours_min'] as String?,
      reqFullTime: json['req_full_time'] as String?,
      hoursSpent: json['hours_spent'] as String?,
      hoursSpentFull: json['hours_spent_full'] as String?,
      projectsStatus: json['projects_status'] as String?,
    );
