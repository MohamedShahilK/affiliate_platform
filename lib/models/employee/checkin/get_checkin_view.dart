// ignore_for_file: lines_longer_than_80_chars

import 'package:json_annotation/json_annotation.dart';

part 'get_checkin_view.g.dart';

@JsonSerializable()
class GetCheckInView {
  GetCheckInView({required this.status, required this.response, required this.data});
  final String? status;
  final String? response;
  final List<Data>? data;
}

@JsonSerializable()
class Data {
  Data({
    required this.tableTitle,
    required this.userDesignation,
    required this.outId,
    required this.checkout,
    required this.checkoutDetails,
    required this.userID,
    required this.checkinData,
    required this.checkinProjects,
  });
  final String? tableTitle;
  final String? userDesignation;
  final String? outId;
  final Checkout? checkout;
  final List<CheckoutDetails>? checkoutDetails;
  final String? userID;
  final CheckinData? checkinData;
  final List<CheckinProjects>? checkinProjects;
}

@JsonSerializable()
class Checkout {
  Checkout({
    required this.id,
    required this.parentId,
    required this.userCode,
    required this.firstName,
    required this.lastName,
    required this.datetime,
    required this.outTime,
    required this.breakHours,
    required this.breakHoursRemarks,
    required this.remarks,
    required this.comments,
    required this.hours,
    required this.checkoutWorkFrom,
  });
  final String? id;
  final String? parentId;
  final String? userCode;
  final String? firstName;
  final String? lastName;
  final String? datetime;
  final String? outTime;
  final String? breakHours;
  final String? breakHoursRemarks;
  final String? remarks;
  final String? comments;
  final String? hours;
  final String? checkoutWorkFrom;
}

@JsonSerializable()
class CheckoutDetails {
  CheckoutDetails({
    required this.projectname,
    required this.checkInRemarks,
    required this.checkOutRemarks,
    required this.reqHoursMin,
    required this.reqFullTime,
    required this.hoursSpent,
    required this.hoursSpentFull,
    required this.projectsStatus,
  });
  final String? projectname;
  final String? checkInRemarks;
  final String? checkOutRemarks;
  final String? reqHoursMin;
  final String? reqFullTime;
  final String? hoursSpent;
  final String? hoursSpentFull;
  final String? projectsStatus;
}

@JsonSerializable()
class CheckinData {
  CheckinData({
    required this.id,
    required this.employee,
    required this.datetime,
    required this.workFrom,
    required this.remarks,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.latitude,
    required this.longitude,
    required this.firstName,
    required this.lastName,
    required this.userCode,
  });
  final String? id;
  final String? employee;
  final String? datetime;
  final String? workFrom;
  final String? remarks;
  final String? createdAt;
  final String? updatedAt;
  final String? status;
  final String? latitude;
  final String? longitude;
  final String? firstName;
  final String? lastName;
  final String? userCode;
}

@JsonSerializable()
class CheckinProjects {
  CheckinProjects({
    required this.id,
    required this.employee,
    required this.datetime,
    required this.workFrom,
    required this.remarks,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.latitude,
    required this.longitude,
    required this.projectname,
    required this.parentId,
    required this.projects,
    required this.checkinProjects,
    required this.reqHoursMin,
    required this.reqFullTime,
    required this.checkInSubId,
    required this.checkInMainId,
  });
  final String? id;
  final String? employee;
  final String? datetime;
  final String? workFrom;
  final String? remarks;
  final String? createdAt;
  final String? updatedAt;
  final String? status;
  final String? latitude;
  final String? longitude;
  final String? projectname;
  final String? parentId;
  final String? projects;
  final String? checkinProjects;
  final String? reqHoursMin;
  final String? reqFullTime;
  final String? checkInSubId;
  final String? checkInMainId;
}
