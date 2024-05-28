// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/api/api.dart';
import 'package:affiliate_platform/api/api_contants.dart';
import 'package:affiliate_platform/api/api_errror_handling.dart';
import 'package:affiliate_platform/models/employee/checkin/get_checkin_form.dart';
import 'package:affiliate_platform/models/employee/checkin/getall_checkins.dart';
import 'package:affiliate_platform/models/employee/checkout/get_allcheckout.dart';
import 'package:affiliate_platform/models/employee/project/view_project.dart';
import 'package:affiliate_platform/models/manage_contact/contact_edit_submission_model.dart';
import 'package:affiliate_platform/utils/constants/string_constants.dart';
import 'package:affiliate_platform/utils/custom_tools.dart';
import 'package:affiliate_platform/utils/internal_services/storage_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class CheckOutServices {
  factory CheckOutServices() {
    return _singleton;
  }

  CheckOutServices._internal();
  static final CheckOutServices _singleton = CheckOutServices._internal();

  final api = Api();

  // Get All Contacts
  Future<GetAllCheckouts?> getAllCheckouts() async {
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
          EndPoints.getAllCheckouts,
        );

        print('adanskjdnasjkdn ');
        final respModel = GetAllCheckouts.fromJson(response!.data ?? {});

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
  Future<GetCheckinForm?> getCheckinForm() async {
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
          EndPoints.checkinForm,
        );

        final respModel = GetCheckinForm.fromJson(response!.data ?? {});

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
  Future<ProjectView?> viewCheckin({required String contactId}) async {
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
          '${EndPoints.projectView}/$contactId',
        );

        print('55555555555555555555555 ${response!.data}');

        final respModel = ProjectView.fromJson(response!.data ?? {});

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
  Future<Map<String, dynamic>?> submitProjectForm(
    BuildContext context, {
    required String name,
    required String? description,
    required String? startDate,
    required String? endDate,
    required String? customerId,
    required String? quotationId,
  }) async {
    try {
      final token = StorageServices.to.getString(StorageServicesKeys.token);
      final haveToken = token.isNotEmpty;
      if (haveToken) {
        final formData = FormData.fromMap({
          'name': name,
          'description': description,
          'start_date': startDate,
          'end_date': endDate,
          'customer_id': customerId,
          'quotation_id': quotationId,
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
          EndPoints.submitProjectForm,
        );

        print('55555555555555555555555 ${response!.data}');

        // final respModel = ContactViewModel.fromJson(response!.data ?? {});

        return response.data;
      }
      return null;
    } on BadRequestException catch (e) {
      Loader.hide();
      final errorResponse = e.response;
      final errorMsg = errorResponse!.data['errors']['name'];

      // final mobileNumberError = errorMsg['mobile_number'];
      // final plateNumberError = errorMsg['guest_name'];
      try {
        await erroMotionToastInfo(context, msg: errorMsg as String);
      } catch (e) {
        //
      }
      
      print('submitForm Error :- $e');
      return null;
    } catch (e) {
      Loader.hide();
      print('submitForm Error :- $e');
      return null;
    }
  }

  // Get Contact Form
  Future<Map<String, dynamic>?> deleteContact({required String contactId}) async {
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
          '${EndPoints.contactdelete}/$contactId',
        );

        // print('55555555555555555555555 ${response!.data}');

        final jsonData = response?.data;

        return jsonData;
      }
      return null;
    } catch (e) {
      Loader.hide();
      print('deleteContact Error :- $e');
      return null;
    }
  }

  // Add Permssion for aff users
  Future<Map<String, dynamic>?> addPermissionForAffUsers({required String contactId, required String affUserId}) async {
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
          '${EndPoints.addPermForAffUsers}/$contactId/$affUserId',
        );

        // print('55555555555555555555555 ${response!.data}');

        final jsonData = response?.data;

        return jsonData;
      }
      return null;
    } catch (e) {
      Loader.hide();
      print('addPermissionForAffUsers Error :- $e');
      return null;
    }
  }

  // Delete Permssion for aff users
  Future<Map<String, dynamic>?> deletePermissionForAffUsers(BuildContext context, {required String contactId, required String affUserId}) async {
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
          '${EndPoints.deletePermForAffUsers}/$contactId/$affUserId',
        );

        // print('55555555555555555555555 ${response!.data}');

        final jsonData = response?.data;

        return jsonData;
      }
      return null;
    } on BadRequestException catch (e) {
      Loader.hide();
      final errorResponse = e.response;
      final errorMsg = errorResponse!.data['message'];
      await erroMotionToastInfo(context, msg: errorMsg as String);
      print('deletePermissionForAffUsers Error :- $e');
      return null;
    } catch (e) {
      Loader.hide();
      print('deletePermissionForAffUsers Error :- $e');
      return null;
    }
  }

  // Add Followup
  Future<Map<String, dynamic>?> addFollowup({
    required String contactId,
    required String title,
    required String description,
    required String date,
  }) async {
    try {
      final token = StorageServices.to.getString(StorageServicesKeys.token);
      final haveToken = token.isNotEmpty;
      if (haveToken) {
        final formData = FormData.fromMap({
          'title': title,
          'description': description,
          'next_followup_date': '30-04-2024',
          'status': '1',
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
          '${EndPoints.addFollowup}/$contactId',
        );

        // print('55555555555555555555555 ${response!.data}');

        final jsonData = response?.data;

        return jsonData;
      }
      return null;
    } catch (e) {
      Loader.hide();
      print('addFollowup Error :- $e');
      return null;
    }
  }

  // Delete Followup
  Future<Map<String, dynamic>?> deleteFollowup({required String contactId, required String followupId}) async {
    try {
      final token = StorageServices.to.getString(StorageServicesKeys.token);
      final haveToken = token.isNotEmpty;
      if (haveToken) {
        final response = await api.dio?.post<Map<String, dynamic>>(
          options: Options(
            headers: {
              // 'accept': '*/*',
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ),
          // queryParameters: {'id':contactId},
          '${EndPoints.deleteFollowup}/$contactId/$followupId',
        );

        // print('55555555555555555555555 ${response!.data}');

        final jsonData = response?.data;

        return jsonData;
      }
      return null;
    } catch (e) {
      Loader.hide();
      print('deleteFollowup Error :- $e');
      return null;
    }
  }

  // Add Followup
  Future<Map<String, dynamic>?> editFollowup({
    required String contactId,
    required String followupId,
    required String title,
    required String description,
    required String date,
  }) async {
    try {
      final token = StorageServices.to.getString(StorageServicesKeys.token);
      final haveToken = token.isNotEmpty;
      if (haveToken) {
        final formData = FormData.fromMap({
          'title': title,
          'description': description,
          'next_followup_date': date,
          'status': '1',
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
          '${EndPoints.editFollowup}/$contactId/$followupId',
        );

        // print('55555555555555555555555 ${response!.data}');

        final jsonData = response?.data;

        return jsonData;
      }
      return null;
    } catch (e) {
      Loader.hide();
      print('addFollowup Error :- $e');
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
