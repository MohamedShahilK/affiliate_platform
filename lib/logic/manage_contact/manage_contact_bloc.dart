// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/models/manage_contact/all_contacts.dart';
import 'package:affiliate_platform/models/manage_contact/contact_edit_submission_model.dart';
import 'package:affiliate_platform/models/manage_contact/contact_form_model.dart';
import 'package:affiliate_platform/models/manage_contact/contact_view_model.dart';
import 'package:affiliate_platform/services/manage_contact/manage_contact_services.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class ManageContactBloc {
  ManageContactBloc() {
    initDetails();
  }

  final getAllContactsStream = BehaviorSubject<GetAllContactsAndUsers?>();
  final getContactFormStream = BehaviorSubject<ContactFormModel?>();
  final getContactViewStream = BehaviorSubject<ContactViewModel?>();

  final nameStream = BehaviorSubject<String>.seeded('');
  final mobileStream = BehaviorSubject<String>.seeded('');
  final emailStream = BehaviorSubject<String>.seeded('');
  // final sourceStream = BehaviorSubject<String>.seeded('');
  final designationStream = BehaviorSubject<String>.seeded('');
  final companyNameStream = BehaviorSubject<String>.seeded('');
  final landlineStream = BehaviorSubject<String>.seeded('');
  final websiteStream = BehaviorSubject<String>.seeded('');
  final companyLocationStream = BehaviorSubject<String>.seeded('');
  final companyAddressStream = BehaviorSubject<String>.seeded('');
  final remarkStream = BehaviorSubject<String>.seeded('');

  final contactTypeStream = BehaviorSubject<String>.seeded('');
  final contactTypeIdStream = BehaviorSubject<String>.seeded('');
  final contactSourceStream = BehaviorSubject<String>.seeded('');
  final contactSourceIdStream = BehaviorSubject<String>.seeded('');

  final permissionStream = BehaviorSubject<List<String>>.seeded([]);

  final followupTitleStream = BehaviorSubject<String>.seeded('');
  final followupDescriptionStream = BehaviorSubject<String>.seeded('');
  final followupDateStream = BehaviorSubject<String>.seeded('');

  Future<void> initDetails() async {
    await getAllContacts();
    await getContactForm();
  }

  Future<void> getAllContacts() async {
    final respModel = await ManageContactSevices().getAllContacts();
    getAllContactsStream.add(respModel);
  }

  Future<void> getContactForm() async {
    final respModel = await ManageContactSevices().getContactForm();
    getContactFormStream.add(respModel);
  }

  Future<void> viewContact({required String contactId}) async {
    getContactViewStream.add(null);
    final respModel = await ManageContactSevices().viewContact(contactId: contactId);
    getContactViewStream.add(respModel);
  }

  Future<bool> deleteContact({required String contactId}) async {
    var isDeleted = false;

    final jsonData = await ManageContactSevices().deleteContact(contactId: contactId);

    if (jsonData != null && jsonData['status'] == 'SUCCESS' && jsonData['response'] == 'OK') {
      isDeleted = true;
    }

    return isDeleted;
  }

  Future<bool> addPermissionForAffUsers({required String contactId, required String affUserId}) async {
    var isPermAdded = false;

    final jsonData = await ManageContactSevices().addPermissionForAffUsers(contactId: contactId, affUserId: affUserId);

    if (jsonData != null && jsonData['status'] == 'SUCCESS' && jsonData['response'] == 'OK') {
      isPermAdded = true;
    }

    return isPermAdded;
  }

  Future<bool> deletePermissionForAffUsers(BuildContext context, {required String contactId, required String affUserId}) async {
    var isPermDeleted = false;

    final jsonData = await ManageContactSevices().deletePermissionForAffUsers(context, contactId: contactId, affUserId: affUserId);

    if (jsonData != null && jsonData['status'] == 'SUCCESS' && jsonData['response'] == 'OK') {
      isPermDeleted = true;
    }

    return isPermDeleted;
  }

  Future<bool> addFollowup({required String contactId}) async {
    var isFollowUpAdded = false;

    final jsonData = await ManageContactSevices().addFollowup(
      contactId: contactId,
      title: followupTitleStream.value,
      description: followupDescriptionStream.value,
    );

    if (jsonData != null && jsonData['status'] == 'SUCCESS' && jsonData['response'] == 'OK') {
      isFollowUpAdded = true;
    }

    return isFollowUpAdded;
  }

  Future<bool> deleteFollowup({required String contactId, required String followupId}) async {
    var isFollowUpDelete = false;

    final jsonData = await ManageContactSevices().deleteFollowup(contactId: contactId, followupId: followupId);

    if (jsonData != null && jsonData['status'] == 'SUCCESS' && jsonData['response'] == 'OK') {
      isFollowUpDelete = true;
    }

    return isFollowUpDelete;
  }

  Future<ContactViewModel?> submitForm() async {
    final respModel = ManageContactSevices().submitForm(
      name: nameStream.value,
      mobile: mobileStream.value,
      email: emailStream.value,
      contactType: contactTypeIdStream.value,
      contactSource: contactSourceIdStream.value,
      designation: designationStream.value,
      companyName: companyNameStream.value,
      landlineNumber: landlineStream.value,
      companyWebsite: websiteStream.value,
      companyLocation: companyLocationStream.value,
      companyAddress: companyAddressStream.value,
      remarks: remarkStream.value,
    );

    return respModel;
  }

  Future<ContactEditSubmissionModel?> contactEdit({required String contactId}) async {
    final respModel = ManageContactSevices().contactEdit(
      contactId: contactId,
      name: nameStream.value,
      mobile: mobileStream.value,
      email: emailStream.value,
      contactType: contactTypeIdStream.value,
      contactSource: contactSourceIdStream.value,
      designation: designationStream.value,
      companyName: companyNameStream.value,
      landlineNumber: landlineStream.value,
      companyWebsite: websiteStream.value,
      companyLocation: companyLocationStream.value,
      companyAddress: companyAddressStream.value,
      remarks: remarkStream.value,
    );

    return respModel;
  }

  void clearStreams() {
    nameStream.add('');
    mobileStream.add('');
    emailStream.add('');
    // sourceStream.add('');
    designationStream.add('');
    companyNameStream.add('');
    landlineStream.add('');
    websiteStream.add('');
    companyLocationStream.add('');
    companyAddressStream.add('');
    remarkStream.add('');

    contactTypeStream.add('');
    contactSourceStream.add('');
  }

  void dispose() {
    getAllContactsStream.close();
  }
}
