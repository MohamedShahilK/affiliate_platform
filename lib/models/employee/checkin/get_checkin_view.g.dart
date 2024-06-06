// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars

part of 'get_checkin_view.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCheckInView _$GetCheckInViewFromJson(Map<String, dynamic> json) => GetCheckInView(
      status: json['status'] as String?,
      response: json['response'] as String?,
      data: (json['data'] as List<dynamic>?)?.map((e) => _$DataFromJson(e as Map<String, dynamic>)).toList(),
    );

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      tableTitle: json['table_title'] as String?,
      userDesignation: json['user_Designation'] as String?,
      // outId: json['Out_Id'] as String?,
      checkout: json['checkout'] == null ? null : _$CheckoutFromJson(json['checkout'] as Map<String, dynamic>),
      checkoutDetails: (json['checkout_details'] as List<dynamic>?)?.map((e) => _$CheckoutDetailsFromJson(e as Map<String, dynamic>)).toList(),
      userID: json['user_ID'] as String?,
      checkinData: json['checkin_data'] == null ? null : _$CheckinDataFromJson(json['checkin_data'] as Map<String, dynamic>),
      checkinProjects: (json['checkin_projects'] as List<dynamic>?)?.map((e) => _$CheckinProjectsFromJson(e as Map<String, dynamic>)).toList(),
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

CheckoutDetails _$CheckoutDetailsFromJson(Map<String, dynamic> json) => CheckoutDetails(
      projectname: json['Projectname'] as String?,
      checkInRemarks: json['CheckInRemarks'] as String?,
      checkOutRemarks: json['CheckOutRemarks'] as String?,
      reqHoursMin: json['req_hours_min'] as String?,
      reqFullTime: json['req_full_time'] as String?,
      hoursSpent: json['hours_spent'] as String?,
      hoursSpentFull: json['hours_spent_full'] as String?,
      projectsStatus: json['projects_status'] as String?,
    );

CheckinData _$CheckinDataFromJson(Map<String, dynamic> json) => CheckinData(
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
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      userCode: json['user_code'] as String?,
    );

CheckinProjects _$CheckinProjectsFromJson(Map<String, dynamic> json) => CheckinProjects(
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
