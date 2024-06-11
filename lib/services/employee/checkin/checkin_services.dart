// ignore_for_file: lines_longer_than_80_chars, avoid_print

import 'package:affiliate_platform/api/api.dart';
import 'package:affiliate_platform/api/api_contants.dart';
import 'package:affiliate_platform/models/employee/checkin/get_checkin_form.dart';
import 'package:affiliate_platform/models/employee/checkin/get_checkin_view.dart';
import 'package:affiliate_platform/models/employee/checkin/getall_checkins.dart';
import 'package:affiliate_platform/models/employee/project/view_project.dart';
import 'package:affiliate_platform/utils/constants/string_constants.dart';
import 'package:affiliate_platform/utils/internal_services/storage_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class CheckInServices {
  factory CheckInServices() {
    return _singleton;
  }

  CheckInServices._internal();
  static final CheckInServices _singleton = CheckInServices._internal();

  final api = Api();

  // Get All Contacts
  Future<GetAllCheckIns?> getAllCheckins() async {
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
          EndPoints.getAllCheckins,
        );

        final respModel = GetAllCheckIns.fromJson(response!.data ?? {});

        return respModel;
      }
      return null;
    } catch (e) {
      Loader.hide();
      print('getAllCheckins Error :- $e');
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
      print('getCheckinForm Error :- $e');
      return null;
    }
  }

  // Get Contact Form
  Future<GetCheckInView?> viewCheckin({required String checkInID}) async {
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
          // queryParameters: {'id':checkInID},
          '${EndPoints.checkInView}/$checkInID',
        );

        print('55555555555555555555555 ${response!.data}');

        final respModel = GetCheckInView.fromJson(response!.data ?? {});

        return respModel;
      }
      return null;
    } catch (e) {
      Loader.hide();
      print('viewCheckin Error :- $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> deleteCheckin({required String checkInID}) async {
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
          // queryParameters: {'id':checkInID},
          '${EndPoints.checkInDelete}/$checkInID',
        );

        print('55555555555555555555555 ${response!.data}');

        // final respModel = GetCheckInView.fromJson(response!.data ?? {});

        return response.data;
      }
      return null;
    } catch (e) {
      Loader.hide();
      print('viewCheckin Error :- $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> formSubmitCheckin({

    required String employee,
    required String dateTime,
    required String workForm,
    required String comments,
    required String? latitude,
    required String? longitude,
    required String projects_1,
    required String remarks_1,
    required String reqHours_1,
    String? projects_2,
    String? remarks_2,
    String? reqHours_2,
    String? projects_3,
    String? remarks_3,
    String? reqHours_3,
    String? projects_4,
    String? remarks_4,
    String? reqHours_4,
    String? projects_5,
    String? remarks_5,
    String? reqHours_5,
    String? projects_6,
    String? remarks_6,
    String? reqHours_6,
  }) async {
    try {
      final token = StorageServices.to.getString(StorageServicesKeys.token);
      final haveToken = token.isNotEmpty;
      if (haveToken) {
        final formData = FormData.fromMap({
          'employee': employee,
          'datetime': dateTime,
          'work_from': workForm,
          'remarks': comments,
          'latitude': latitude,
          'longitude': longitude,
          'projects_1': projects_1,
          'remarks_1': remarks_1,
          'req_hours_1': reqHours_1,
          'projects_2': projects_2,
          'remarks_2': remarks_2,
          'req_hours_2': reqHours_2,
          'projects_3': projects_3,
          'remarks_3': remarks_3,
          'req_hours_3': reqHours_3,
          'projects_4': projects_4,
          'remarks_4': remarks_4,
          'req_hours_4': reqHours_4,
          'projects_5': projects_5,
          'remarks_5': remarks_5,
          'req_hours_5': reqHours_5,
          'projects_6': projects_6,
          'remarks_6': remarks_6,
          'req_hours_6': reqHours_6,
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
          EndPoints.checkInFormSubmit,
        );

        print('55555555555555555555555 ${response!.data}');

        // final respModel = GetCheckInView.fromJson(response!.data ?? {});

        return response.data;
      }
      return null;
    } catch (e) {
      Loader.hide();
      print('viewCheckin Error :- $e');
      return null;
    }
  }
}
