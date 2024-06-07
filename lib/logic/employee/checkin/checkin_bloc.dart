// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/models/employee/checkin/get_checkin_form.dart';
import 'package:affiliate_platform/models/employee/checkin/get_checkin_view.dart';
import 'package:affiliate_platform/models/employee/checkin/getall_checkins.dart';
import 'package:affiliate_platform/models/employee/project/view_project.dart';
import 'package:affiliate_platform/services/employee/checkin/checkin_services.dart';
import 'package:affiliate_platform/services/employee/project/project_services.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CheckInBloc {
  CheckInBloc() {
    initDetails();
  }

  final getAllCheckInsStream = BehaviorSubject<GetAllCheckIns?>();
  final getCheckInFormStream = BehaviorSubject<GetCheckinForm?>();
  final getCheckinViewStream = BehaviorSubject<GetCheckInView?>();

  final employeeStream = BehaviorSubject<String>.seeded('');
  final employeeIdStream = BehaviorSubject<String>.seeded('');

  final checkinTimeStream = BehaviorSubject<String>.seeded('');

  final projectStream = BehaviorSubject<String>.seeded('');
  final projectIdStream = BehaviorSubject<String>.seeded('');

  final descriptionStream = BehaviorSubject<String>.seeded('');

  Future<void> initDetails() async {
    await getAllCheckins();
    await getCheckinForm();
  }

  Future<void> getAllCheckins() async {
    final respModel = await CheckInServices().getAllCheckins();
    getAllCheckInsStream.add(respModel);
  }

  Future<void> getCheckinForm() async {
    final respModel = await CheckInServices().getCheckinForm();
    getCheckInFormStream.add(respModel);
  }

  Future<void> viewCheckin({required String checkInID}) async {
    getCheckinViewStream.add(null);
    final respModel = await CheckInServices().viewCheckin(checkInID: checkInID);
    getCheckinViewStream.add(respModel);
  }

  Future<bool> deleteContact({required String checkInID}) async {
    var isDeleted = false;

    final jsonData = await CheckInServices().deleteCheckin(checkInID: checkInID);

    if (jsonData != null && jsonData['status'] == 'SUCCESS' && jsonData['response'] == 'OK') {
      isDeleted = true;
    }

    return isDeleted;
  }

  // Future<bool> addPermissionForAffUsers({required String contactId, required String affUserId}) async {
  //   var isPermAdded = false;

  //   final jsonData = await ManageContactSevices().addPermissionForAffUsers(contactId: contactId, affUserId: affUserId);

  //   if (jsonData != null && jsonData['status'] == 'SUCCESS' && jsonData['response'] == 'OK') {
  //     isPermAdded = true;
  //   }

  //   return isPermAdded;
  // }

  // Future<bool> deletePermissionForAffUsers(BuildContext context, {required String contactId, required String affUserId}) async {
  //   var isPermDeleted = false;

  //   final jsonData = await ManageContactSevices().deletePermissionForAffUsers(context, contactId: contactId, affUserId: affUserId);

  //   if (jsonData != null && jsonData['status'] == 'SUCCESS' && jsonData['response'] == 'OK') {
  //     isPermDeleted = true;
  //   }

  //   return isPermDeleted;
  // }

  // Future<bool> addFollowup({required String contactId}) async {
  //   var isFollowUpAdded = false;

  //   final jsonData = await ManageContactSevices().addFollowup(
  //     contactId: contactId,
  //     title: followupTitleStream.value,
  //     description: followupDescriptionStream.value,
  //     date: followupDateStream.value,
  //   );

  //   if (jsonData != null && jsonData['status'] == 'SUCCESS' && jsonData['response'] == 'OK') {
  //     isFollowUpAdded = true;
  //   }

  //   return isFollowUpAdded;
  // }

  // Future<bool> deleteFollowup({required String contactId, required String followupId}) async {
  //   var isFollowUpDelete = false;

  //   final jsonData = await ManageContactSevices().deleteFollowup(contactId: contactId, followupId: followupId);

  //   if (jsonData != null && jsonData['status'] == 'SUCCESS' && jsonData['response'] == 'OK') {
  //     isFollowUpDelete = true;
  //   }

  //   return isFollowUpDelete;
  // }

  // Future<bool> editFollowup({required String contactId, required String followupId}) async {
  //   var isFollowUpAdded = false;

  //   final jsonData = await ManageContactSevices().editFollowup(
  //     contactId: contactId,
  //     followupId: followupId,
  //     title: followupTitleStream.value,
  //     description: followupDescriptionStream.value,
  //     date: followupDateStream.value,
  //   );

  //   if (jsonData != null && jsonData['status'] == 'SUCCESS' && jsonData['response'] == 'OK') {
  //     isFollowUpAdded = true;
  //   }

  //   return isFollowUpAdded;
  // }

  // Future<ContactEditSubmissionModel?> contactEdit({required String contactId}) async {
  //   final respModel = ManageContactSevices().contactEdit(
  //     contactId: contactId,
  //     name: nameStream.value,
  //     mobile: mobileStream.value,
  //     email: emailStream.value,
  //     contactType: contactTypeIdStream.value,
  //     contactSource: contactSourceIdStream.value,
  //     designation: designationStream.value,
  //     companyName: companyNameStream.value,
  //     landlineNumber: landlineStream.value,
  //     companyWebsite: websiteStream.value,
  //     companyLocation: companyLocationStream.value,
  //     companyAddress: companyAddressStream.value,
  //     remarks: remarkStream.value,
  //   );

  //   return respModel;
  // }

  void clearStreams() {
    employeeStream.add('');
    employeeIdStream.add('');
    checkinTimeStream.add('');
  }

  void dispose() {
    getAllCheckInsStream.close();
  }
}
