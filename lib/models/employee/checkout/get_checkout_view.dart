// ignore_for_file: lines_longer_than_80_chars

import 'package:json_annotation/json_annotation.dart';

part 'get_checkout_view.g.dart';

@JsonSerializable()
class GetCheckOutView {
  GetCheckOutView({required this.status, required this.response, required this.data});
  final String? status;
  final String? response;
  final List<Data>? data;
}

@JsonSerializable()
class Data {
  Data({required this.tableTitle, required this.userDesignation, required this.checkout, required this.checkoutDetails, required this.userID});
  final String? tableTitle;
  final String? userDesignation;
  final Checkout? checkout;
  final List<CheckoutDetails>? checkoutDetails;
  final String? userID;
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
