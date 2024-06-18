// ignore_for_file: lines_longer_than_80_chars

import 'dart:ffi';

import 'package:affiliate_platform/app.dart';
import 'package:affiliate_platform/models/employee/leave/leave_form_model.dart';
import 'package:affiliate_platform/models/employee/leave/leave_model.dart';
import 'package:affiliate_platform/services/employee/leave/leave_services.dart';
import 'package:affiliate_platform/utils/constants/string_constants.dart';
import 'package:affiliate_platform/utils/internal_services/storage_services.dart';
import 'package:rxdart/rxdart.dart';

class LeaveBloc {
  LeaveBloc() {
    initDetails();
  }

  final getAllLeavesStream = BehaviorSubject<GetAllLeaves?>();
  final getLeaveFormStream = BehaviorSubject<GetLeaveForm?>();
  // final getProjectViewStream = BehaviorSubject<ProjectView?>();

  final employeeNameStream = BehaviorSubject<String>.seeded('');
  final leaveApplyDateStream = BehaviorSubject<String>.seeded('');
  final leaveStartDateStream = BehaviorSubject<String>.seeded('');
  final leaveEndDateStream = BehaviorSubject<String>.seeded('');

  final leaveDurationStream = BehaviorSubject<String>.seeded('');

  final noOfHoursStream = BehaviorSubject<String>.seeded('');
  final hourOffStartAndEndDateStream = BehaviorSubject<String>.seeded(''); // Only for hour off

  final leaveTypeStream = BehaviorSubject<String>.seeded('');
  final leaveReasonStream = BehaviorSubject<String>.seeded('');

  final approvalStatusStream = BehaviorSubject<String>.seeded('1');
  final approvalRemarkStream = BehaviorSubject<String>.seeded('');
  final approvedByStream = BehaviorSubject<String>.seeded('');
  final approvedOnStream = BehaviorSubject<String>.seeded('');

  Future<void> initDetails() async {
    await getAllLeaves();
    await getLeaveForm();
    await userDetails();
  }

  Future<void> getAllLeaves() async {
    blocOficialLoaderNotifier.value = true;
    final respModel = await LeavesServices().getAllLeaves();
    getAllLeavesStream.add(respModel);
    blocOficialLoaderNotifier.value = false;
  }

  Future<void> getLeaveForm() async {
    final respModel = await LeavesServices().getLeaveForm();
    getLeaveFormStream.add(respModel);
  }

  Future<void> userDetails() async {
    final respModel = await LeavesServices().userDetails();
    if (respModel != null) {
      final data = respModel['data'];

      if (data is List? && data != null && data.isNotEmpty) {
        final item = data[0] as Map?;
        final userId = item?['user_ID'] as String?;

        if (userId != null) {
          await StorageServices.to.setString(StorageServicesKeys.userId, userId);
        }
      }
    }
  }

  Future<Map<String, dynamic>?> submitLeaveForm({
    required String employeeId,
    required String durationId,
    required String leaveTypeId,
  }) async {
    final respModel = LeavesServices().submitLeaveForm(
      employee: employeeId,
      leaveApplyDate: leaveApplyDateStream.value,
      leaveDuration: durationId,
      leaveType: leaveTypeId,
      leaveStartDate: leaveStartDateStream.value,
      leaveEndDate: leaveEndDateStream.value,
      leaveReason: leaveReasonStream.value,
      leaveDurationIntervals: noOfHoursStream.valueOrNull,
      leavesHouroffText: hourOffStartAndEndDateStream.valueOrNull,
    );

    return respModel;
  }

  Future<Map<String, dynamic>?> submitLeaveEditForm({
    required String leaveId,
    required String employeeId,
    required String durationId,
    required String leaveTypeId,
  }) async {
    final respModel = LeavesServices().submitLeaveEditForm(
      leaveId: leaveId,
      employee: employeeId,
      leaveApplyDate: leaveApplyDateStream.value,
      leaveDuration: durationId,
      leaveType: leaveTypeId,
      leaveStartDate: leaveStartDateStream.value,
      leaveEndDate: leaveEndDateStream.value,
      leaveReason: leaveReasonStream.value,
      leaveDurationIntervals: noOfHoursStream.valueOrNull,
      leavesHouroffText: hourOffStartAndEndDateStream.valueOrNull,
      approvalStatus: approvalStatusStream.valueOrNull,
      approvalStatusRemarks: approvalRemarkStream.valueOrNull,
      approvedBy: approvedByStream.valueOrNull,
      approvedOn: approvedOnStream.valueOrNull,
    );

    return respModel;
  }

  void clearStreams() {
    employeeNameStream.add('');
    leaveApplyDateStream.add('');
    leaveStartDateStream.add('');
    leaveEndDateStream.add('');
    leaveDurationStream.add('');
    noOfHoursStream.add('');
    leaveTypeStream.add('');
    leaveReasonStream.add('');
  }

  void dispose() {
    getAllLeavesStream.close();
    getLeaveFormStream.close();
    //  getProjectViewStream.close();

    employeeNameStream.close();
    leaveApplyDateStream.close();
    leaveStartDateStream.close();
    leaveEndDateStream.close();

    leaveDurationStream.close();

    noOfHoursStream.close();
    hourOffStartAndEndDateStream.close();
    leaveTypeStream.close();
    leaveReasonStream.close();

    approvalStatusStream.close();
    approvalRemarkStream.close();
    approvedByStream.close();
    approvedOnStream.close();
  }
}
