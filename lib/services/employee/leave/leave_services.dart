// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/api/api.dart';
import 'package:affiliate_platform/api/api_contants.dart';
import 'package:affiliate_platform/api/api_errror_handling.dart';
import 'package:affiliate_platform/models/employee/leave/leave_form_model.dart';
import 'package:affiliate_platform/models/employee/leave/leave_model.dart';
import 'package:affiliate_platform/models/employee/project/view_project.dart';
import 'package:affiliate_platform/utils/constants/string_constants.dart';
import 'package:affiliate_platform/utils/internal_services/storage_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class LeavesServices {
  factory LeavesServices() {
    return _singleton;
  }

  LeavesServices._internal();
  static final LeavesServices _singleton = LeavesServices._internal();

  final api = Api();

  // Get All Contacts
  Future<GetAllLeaves?> getAllLeaves({
    String? leaveFromDate,
    String? leaveToDate,
    String? leaveApprovalStatus,
    String? leaveType,
  }) async {
    try {
      final token = StorageServices.to.getString(StorageServicesKeys.token);
      final haveToken = token.isNotEmpty;
      if (haveToken) {
        // print('55555555555555555555555555555555555555 $leaveType');
        final formData = FormData.fromMap({
          // 'employee': employee,
          'leave_date': leaveFromDate,
          'leave_date_2': leaveToDate,
          'approval_status': leaveApprovalStatus,
          'leave_type': leaveType,
        });
        final response = await api.dio?.post<Map<String, dynamic>>(
          options: Options(
            headers: {
              // 'accept': '*/*',
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ),
          // queryParameters: {},
          data: formData,
          EndPoints.getAllLeaves,
        );

        final respModel = GetAllLeaves.fromJson(response!.data ?? {});

        print('111111111111111111 ${respModel.data?[0].totalLeaves}');

        return respModel;
      }
      return null;
    } catch (e) {
      Loader.hide();
      print('getAllLeaves Error :- $e');
      return null;
    }
  }

  // Get Contact Form
  Future<GetLeaveForm?> getLeaveForm() async {
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
          EndPoints.leaveForm,
        );

        print(response!.data);
        final respModel = GetLeaveForm.fromJson(response!.data ?? {});

        return respModel;
      }
      return null;
    } catch (e) {
      Loader.hide();
      print('getLeaveForm Error :- $e');
      return null;
    }
  }

  // Submit Form
  Future<Map<String, dynamic>?> submitLeaveForm({
    required String employee,
    required String leaveApplyDate,
    required String leaveDuration,
    required String leaveType,
    required String leaveStartDate,
    required String leaveEndDate,
    required String leaveReason,
    String? leaveDurationIntervals,
    String? leavesHouroffText,
  }) async {
    try {
      final token = StorageServices.to.getString(StorageServicesKeys.token);
      final userId = StorageServices.to.getString(StorageServicesKeys.userId);
      final haveToken = token.isNotEmpty;
      if (haveToken) {
        final formData = FormData.fromMap({
          'approval_status': '1',
          'employee': employee,
          'leave_date': leaveApplyDate,
          'leave_duration': leaveDuration,
          'leave_type': leaveType,
          'leave_start_date': leaveStartDate,
          'leave_end_date': leaveEndDate,
          'leave_reason': leaveReason,
          'created_by': userId,
          'leave_duration_intervals': leaveDurationIntervals,
          'leaves_houroff_text': leavesHouroffText,
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
          EndPoints.submitLeaveForm,
        );

        print('55555555555555555555555 ${response!.data}');

        // final respModel = ContactViewModel.fromJson(response!.data ?? {});

        return response.data;
      }
      return null;
    } on DioException catch (e) {
      Loader.hide();
      // final errorResponse = e.response;
      // final errorMsg = errorResponse!.data['errors']['name'];

      // final mobileNumberError = errorMsg['mobile_number'];
      // final plateNumberError = errorMsg['guest_name'];
      // try {
      //   await erroMotionToastInfo(context, msg: errorMsg as String);
      // } catch (e) {
      //   //
      // }

      // print('submitProjectForm Error :- ${e.response?.statusCode}');
      print('submitLeaveForm Error :- $e');
      return null;
    } catch (e) {
      Loader.hide();
      print('submitLeaveForm Error :- $e');
      return null;
    }
  }

  // Submit Edit Form
  Future<Map<String, dynamic>?> submitLeaveEditForm({
    required String leaveId,
    required String employee,
    required String leaveApplyDate,
    required String leaveDuration,
    required String leaveType,
    required String leaveStartDate,
    required String leaveEndDate,
    required String leaveReason,
    String? leaveDurationIntervals,
    String? leavesHouroffText,
    String? approvalStatus,
    String? approvalStatusRemarks,
    String? approvedBy,
    String? approvedOn,
  }) async {
    try {
      final token = StorageServices.to.getString(StorageServicesKeys.token);
      final userId = StorageServices.to.getString(StorageServicesKeys.userId);
      final haveToken = token.isNotEmpty;
      if (haveToken) {
        final formData = FormData.fromMap({
          'approval_status': approvalStatus, // Only admin or main user can change the approval status
          'employee': employee,
          'leave_date': leaveApplyDate,
          'leave_duration': leaveDuration,
          'leave_type': leaveType,
          'leave_start_date': leaveStartDate,
          'leave_end_date': leaveEndDate,
          'leave_reason': leaveReason,
          'created_by': userId,
          'leave_duration_intervals': leaveDurationIntervals,
          'leaves_houroff_text': leavesHouroffText,

          'approval_status_remarks': approvalStatusRemarks,
          'approval_by': approvedBy,
          'approval_on': approvedOn,
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
          '${EndPoints.submitLeaveEditForm}/$leaveId',
        );

        print('55555555555555555555555 ${response!.data}');

        // final respModel = ContactViewModel.fromJson(response!.data ?? {});

        return response.data;
      }
      return null;
    } on DioException catch (e) {
      Loader.hide();
      // final errorResponse = e.response;
      // final errorMsg = errorResponse!.data['errors']['name'];

      // final mobileNumberError = errorMsg['mobile_number'];
      // final plateNumberError = errorMsg['guest_name'];
      // try {
      //   await erroMotionToastInfo(context, msg: errorMsg as String);
      // } catch (e) {
      //   //
      // }

      // print('submitProjectForm Error :- ${e.response?.statusCode}');
      print('submitLeaveEditForm Error :- $e');
      return null;
    } catch (e) {
      Loader.hide();
      print('submitLeaveEditForm Error :- $e');
      return null;
    }
  }

  // Get All Contacts
  Future<Map<String, dynamic>?> userDetails() async {
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
          EndPoints.userDetails,
        );

        // final respModel = GetAllLeaves.fromJson(response!.data ?? {});

        return response?.data;
      }
      return null;
    } catch (e) {
      Loader.hide();
      print('userDetails Error :- $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> deleteLeave({required String leaveId}) async {
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
          // queryParameters: {'id':leaveId},
          '${EndPoints.leaveDelete}/$leaveId',
        );

        print('55555555555555555555555 ${response!.data}');

        // final respModel = GetCheckInView.fromJson(response!.data ?? {});

        return response.data;
      }
      return null;
    } catch (e) {
      Loader.hide();
      print('deleteCheckin Error :- $e');
      return null;
    }
  }
}
