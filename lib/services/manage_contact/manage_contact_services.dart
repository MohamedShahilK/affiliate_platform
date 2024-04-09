// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/api/api.dart';
import 'package:affiliate_platform/api/api_contants.dart';
import 'package:affiliate_platform/models/manage_contact/all_contacts.dart';
import 'package:affiliate_platform/models/manage_contact/contact_edit_submission_model.dart';
import 'package:affiliate_platform/models/manage_contact/contact_form_model.dart';
import 'package:affiliate_platform/models/manage_contact/contact_view_model.dart';
import 'package:affiliate_platform/utils/constants/string_constants.dart';
import 'package:affiliate_platform/utils/internal_services/storage_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class ManageContactSevices {
  factory ManageContactSevices() {
    return _singleton;
  }

  ManageContactSevices._internal();
  static final ManageContactSevices _singleton = ManageContactSevices._internal();

  final api = Api();

  // Get All Contacts
  Future<GetAllContactsAndUsers?> getAllContacts() async {
    try {
      final token = StorageServices.to.getString(StorageServicesKeys.token);
      final haveToken = token.isNotEmpty;
      if (haveToken) {
        final response = await api.dio?.get<Map<String, dynamic>>(
          options: Options(
            headers: {
              // 'accept': '*/*',
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ),
          // queryParameters: {},
          EndPoints.getAllContacts,
        );

        final respModel = GetAllContactsAndUsers.fromJson(response!.data ?? {});

        return respModel;
      }
      return null;
    } catch (e) {
      Loader.hide();
      print('getAllContacts Error :- $e');
      return null;
    }
  }

  // Get Contact Form
  Future<ContactFormModel?> getContactForm() async {
    try {
      final token = StorageServices.to.getString(StorageServicesKeys.token);
      final haveToken = token.isNotEmpty;
      if (haveToken) {
        final response = await api.dio?.get<Map<String, dynamic>>(
          options: Options(
            headers: {
              // 'accept': '*/*',
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ),
          // queryParameters: {},
          EndPoints.contactForm,
        );

        final respModel = ContactFormModel.fromJson(response!.data ?? {});

        return respModel;
      }
      return null;
    } catch (e) {
      Loader.hide();
      print('getContactForm Error :- $e');
      return null;
    }
  }

  // Get Contact Form
  Future<ContactViewModel?> viewContact({required String contactId}) async {
    try {
      final token = StorageServices.to.getString(StorageServicesKeys.token);
      final haveToken = token.isNotEmpty;
      if (haveToken) {
        final response = await api.dio?.get<Map<String, dynamic>>(
          options: Options(
            headers: {
              // 'accept': '*/*',
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ),
          // queryParameters: {'id':contactId},
          '${EndPoints.contactView}/$contactId',
        );

        print('55555555555555555555555 ${response!.data}');

        final respModel = ContactViewModel.fromJson(response!.data ?? {});

        return respModel;
      }
      return null;
    } catch (e) {
      Loader.hide();
      print('viewContact Error :- $e');
      return null;
    }
  }

  // Submit Form
  Future<ContactViewModel?> submitForm({    
    required String name,
    required String mobile,
    required String email,
    required String contactType,
    required String contactSource,
    required String designation,
    required String companyName,
    required String landlineNumber,
    required String companyWebsite,
    required String companyLocation,
    required String companyAddress,
    required String remarks,
  }) async {
    try {
      final token = StorageServices.to.getString(StorageServicesKeys.token);
      final haveToken = token.isNotEmpty;
      if (haveToken) {
        final formData = FormData.fromMap({
          'name': name,
          'contact_type': contactType,
          'email': email,
          'mobile': mobile,
          'company': companyName,
          'designation': designation,
          'company_address': companyAddress,
          'company_website': companyWebsite,
          'company_landline': landlineNumber,
          'company_location': companyLocation,
          'remarks': remarks,
          'contact_source': contactSource,
        });

        final response = await api.dio?.post<Map<String, dynamic>>(
          options: Options(
            headers: {
              // 'accept': '*/*',
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ),
          // queryParameters: {'id':contactId},
          data: formData,
          EndPoints.submitContactForm,
        );

        print('55555555555555555555555 ${response!.data}');

        final respModel = ContactViewModel.fromJson(response!.data ?? {});

        return respModel;
      }
      return null;
    } catch (e) {
      Loader.hide();
      print('submitForm Error :- $e');
      return null;
    }
  }

  // Submit Form
  Future<ContactEditSubmissionModel?> contactEdit({    
    required String contactId,
    required String name,
    required String mobile,
    required String email,
    required String contactType,
    required String contactSource,
    required String designation,
    required String companyName,
    required String landlineNumber,
    required String companyWebsite,
    required String companyLocation,
    required String companyAddress,
    required String remarks,
  }) async {
    try {
      final token = StorageServices.to.getString(StorageServicesKeys.token);
      final haveToken = token.isNotEmpty;
      if (haveToken) {
        final formData = FormData.fromMap({
          'name': name,
          'contact_type': contactType,
          'email': email,
          'mobile': mobile,
          'company': companyName,
          'designation': designation,
          'company_address': companyAddress,
          'company_website': companyWebsite,
          'company_landline': landlineNumber,
          'company_location': companyLocation,
          'remarks': remarks,
          'contact_source': contactSource,
        });

        final response = await api.dio?.post<Map<String, dynamic>>(
          options: Options(
            headers: {
              // 'accept': '*/*',
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ),
          // queryParameters: {'id':contactId},
          data: formData,
            '${EndPoints.submitEditContactSubmit}/$contactId',
        );

        print('55555555555555555555555 ${response!.data}');

        final respModel = ContactEditSubmissionModel.fromJson(response!.data ?? {});

        return respModel;
      }
      return null;
    } catch (e) {
      Loader.hide();
      print('submitForm Error :- $e');
      return null;
    }
  }
}
