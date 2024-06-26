// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/app.dart';
import 'package:affiliate_platform/models/employee/project/get_all_projects.dart';
import 'package:affiliate_platform/models/employee/project/project_form.dart';
import 'package:affiliate_platform/models/employee/project/view_project.dart';
import 'package:affiliate_platform/services/employee/project/project_services.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ProjectBloc {
  ProjectBloc() {
    initDetails();
  }

  final getAllProjectsStream = BehaviorSubject<GetAllProjects?>();
  final getProjectFormStream = BehaviorSubject<ProjectForm?>();
  final getProjectViewStream = BehaviorSubject<ProjectView?>();

  final projectNameStream = BehaviorSubject<String>.seeded('');

  final clientStream = BehaviorSubject<String>.seeded('');
  final clientIdStream = BehaviorSubject<String>.seeded('');

  final quotationRefereneceStream = BehaviorSubject<String>.seeded('');
  final quotationPersonNameStream = BehaviorSubject<String>.seeded(''); // Pending to implement by praveen
  final quotationIdStream = BehaviorSubject<String>.seeded('');

  final statusStream = BehaviorSubject<String>.seeded('');
  final statusIdStream = BehaviorSubject<String>.seeded('');

  final startDateStream = BehaviorSubject<String>.seeded('');
  final endDateStream = BehaviorSubject<String>.seeded('');
  final descriptionStream = BehaviorSubject<String>.seeded('');

  final projectSearchStream = BehaviorSubject<String>.seeded('');
  final projectStatusStream = BehaviorSubject<String>.seeded('');

  Future<void> initDetails() async {
    await getAllProjects();
    // await getContactForm();
  }

  Future<void> getAllProjects({String? statusId}) async {
    blocOficialLoaderNotifier.value = true;
    final respModel = await ProjectServices().getAllProjects(statusId: statusId, keywordSearch: projectSearchStream.valueOrNull);
    getAllProjectsStream.add(respModel);
    blocOficialLoaderNotifier.value = false;
  }

  Future<void> getContactForm() async {
    final respModel = await ProjectServices().getProjectForm();
    getProjectFormStream.add(respModel);
  }

  Future<void> viewProject({required String projectId}) async {
    getProjectViewStream.add(null);
    final respModel = await ProjectServices().viewProject(projectId: projectId);
    getProjectViewStream.add(respModel);
  }

  Future<Map<String, dynamic>?> submitProjectForm(
    BuildContext context, {
    required String? customerId,
    required String? quotationId,
    required String? status,
    required String? createdByEmployee,
  }) async {
    final respModel = ProjectServices().submitProjectForm(
      context,
      name: projectNameStream.value,
      description: descriptionStream.valueOrNull,
      startDate: startDateStream.valueOrNull,
      endDate: endDateStream.valueOrNull,
      customerId: customerId,
      quotationId: quotationId,
      status: status,
      createdByEmployee: createdByEmployee,
    );

    return respModel;
  }

  Future<Map<String, dynamic>?> projectEdit({
    required String projectId,
    required String? customerId,
    required String? quotationId,
    required String? status,
    required String? updatedByEmployee,
  }) async {
    final respModel = ProjectServices().projectEdit(
      projectId: projectId,
      name: projectNameStream.value,
      description: descriptionStream.valueOrNull,
      startDate: startDateStream.valueOrNull,
      endDate: endDateStream.valueOrNull,
      customerId: customerId,
      quotationId: quotationId,
      status: status,
      updatedByEmployee: updatedByEmployee,
    );

    return respModel;
  }

  Future<Map<String, dynamic>?> deleteProject({required String? projectId}) async {
    var isDeleted = false;

    final jsonData = await ProjectServices().deleteProject(projectId: projectId);

    // if (jsonData != null && jsonData['status'] == 'SUCCESS' && jsonData['response'] == 'OK') {
    //   isDeleted = true;
    // }

    return jsonData;
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
    // nameStream.add('');
    // mobileStream.add('');
    // emailStream.add('');
    // // sourceStream.add('');
    // designationStream.add('');
    // companyNameStream.add('');
    // landlineStream.add('');
    // websiteStream.add('');
    // companyLocationStream.add('');
    // companyAddressStream.add('');
    // remarkStream.add('');

    // contactTypeStream.add('');
    // contactSourceStream.add('');

    projectNameStream.add('');
    clientStream.add('');
    clientIdStream.add('');
    quotationRefereneceStream.add('');
    quotationPersonNameStream.add('');
    quotationIdStream.add('');
    statusStream.add('');
    statusIdStream.add('');
    startDateStream.add('');
    endDateStream.add('');
    descriptionStream.add('');
  }

  void dispose() {
    getAllProjectsStream.close();
  }
}
