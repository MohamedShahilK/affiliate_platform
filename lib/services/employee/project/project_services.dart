// ignore_for_file: lines_longer_than_80_chars, avoid_print, avoid_dynamic_calls

import 'package:affiliate_platform/api/api.dart';
import 'package:affiliate_platform/api/api_contants.dart';
import 'package:affiliate_platform/api/api_errror_handling.dart';
import 'package:affiliate_platform/models/employee/project/get_all_projects.dart';
import 'package:affiliate_platform/models/employee/project/project_form.dart';
import 'package:affiliate_platform/models/employee/project/view_project.dart';
import 'package:affiliate_platform/models/manage_contact/contact_edit_submission_model.dart';
import 'package:affiliate_platform/utils/constants/string_constants.dart';
import 'package:affiliate_platform/utils/custom_tools.dart';
import 'package:affiliate_platform/utils/internal_services/storage_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class ProjectServices {
  factory ProjectServices() {
    return _singleton;
  }

  ProjectServices._internal();
  static final ProjectServices _singleton = ProjectServices._internal();

  final api = Api();

  // Get All Contacts
  Future<GetAllProjects?> getAllProjects({String? statusId, String? keywordSearch}) async {
    try {
      final token = StorageServices.to.getString(StorageServicesKeys.token);
      final haveToken = token.isNotEmpty;
      if (haveToken) {
        final formData = FormData.fromMap({
          'status_search': statusId ?? '1',
          'keyword_search': keywordSearch,
        });
        final response = await api.dio?.post<Map<String, dynamic>>(
          options: Options(
            headers: {
              // 'accept': '*/*',
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ),
          data: formData,
          // queryParameters: {},
          EndPoints.getAllProjects,
        );

        print('adanskjdnasjkdn ');
        final respModel = GetAllProjects.fromJson(response!.data ?? {});

        return respModel;
      }
      return null;
    } catch (e) {
      Loader.hide();
      print('getAllProjects Error :- $e');
      return null;
    }
  }

  // Get Contact Form
  Future<ProjectForm?> getProjectForm() async {
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

          EndPoints.projectForm,
        );

        final respModel = ProjectForm.fromJson(response!.data ?? {});

        return respModel;
      }
      return null;
    } catch (e) {
      Loader.hide();
      print('getProjectForm Error :- $e');
      return null;
    }
  }

  // Get Contact Form
  Future<ProjectView?> viewProject({required String projectId}) async {
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
          // queryParameters: {'id':projectId},
          '${EndPoints.projectView}/$projectId',
        );

        print('55555555555555555555555 ${response!.data}');

        final respModel = ProjectView.fromJson(response!.data ?? {});

        return respModel;
      }
      return null;
    } catch (e) {
      Loader.hide();
      print('viewProject Error :- $e');
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
    required String? status,
    required String? createdByEmployee,
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
          'status': status,
          'created_by': createdByEmployee,
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

      print('submitProjectForm Error :- $e');
      return null;
    } catch (e) {
      Loader.hide();
      print('submitProjectForm Error :- $e');
      return null;
    }
  }

  // Submit Form
  Future<Map<String, dynamic>?> projectEdit({
    required String projectId,
    required String name,
    required String? description,
    required String? startDate,
    required String? endDate,
    required String? customerId,
    required String? quotationId,
    required String? status,
    required String? updatedByEmployee,
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
          'status': status,
          'updated_by': updatedByEmployee,
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
          '${EndPoints.projectEditContactSubmit}/$projectId',
        );

        print('55555555555555555555555 ${response!.data}');

        return response.data;
      }
      return null;
    } catch (e) {
      Loader.hide();
      print('projectEdit Error :- $e');
      return null;
    }
  }

  // Get Contact Form
  Future<Map<String, dynamic>?> deleteProject({required String? projectId}) async {
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
          // queryParameters: {'id':projectId},
          '${EndPoints.projectdelete}/$projectId',
        );

        // print('55555555555555555555555 ${response!.data}');

        final jsonData = response?.data;

        return jsonData;
      }
      return null;
    } catch (e) {
      Loader.hide();
      print('deleteProject Error :- $e');
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
}
