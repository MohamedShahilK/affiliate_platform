// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/api/api.dart';
import 'package:affiliate_platform/api/api_contants.dart';
import 'package:affiliate_platform/models/employee/checkout/get_allcheckout.dart';
import 'package:affiliate_platform/models/employee/checkout/get_checkout_form_model.dart';
import 'package:affiliate_platform/models/employee/checkout/get_checkout_view.dart';
import 'package:affiliate_platform/utils/constants/string_constants.dart';
import 'package:affiliate_platform/utils/internal_services/storage_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class CheckOutServices {
  factory CheckOutServices() {
    return _singleton;
  }

  CheckOutServices._internal();
  static final CheckOutServices _singleton = CheckOutServices._internal();

  final api = Api();

  // Get All Contacts
  Future<GetAllCheckouts?> getAllCheckouts({
    String? employeeSearch,
    String? projectSearch,
    String? checkOutFrom,
    String? checkOutTo,
    String? checkOutStatus,
  }) async {
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
          queryParameters: {
            'employee_search': employeeSearch,
            'project_search': projectSearch,
            'out_date_search': checkOutFrom,
            'out_date_search_2': checkOutTo,
            'out_status': checkOutStatus,
          },
          EndPoints.getAllCheckouts,
        );

        print('adanskjdnasjkdn ');
        final respModel = GetAllCheckouts.fromJson(response!.data ?? {});

        return respModel;
      }
      return null;
    } catch (e) {
      Loader.hide();
      print('getAllCheckouts Error :- $e');
      return null;
    }
  }

  // Get Contact Form
  Future<GetCheckOutFormModel?> getCheckOutForm({required String dateTimeStr}) async {
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
          queryParameters: {'dateIs': dateTimeStr},
          EndPoints.checkOutForm,
        );

        final respModel = GetCheckOutFormModel.fromJson(response!.data ?? {});

        return respModel;
      }
      return null;
    } catch (e) {
      Loader.hide();
      print('getCheckOutForm Error :- $e');
      return null;
    }
  }

  Future<GetCheckOutView?> viewCheckOut({required String checkoutId}) async {
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
          '${EndPoints.checkOutView}/$checkoutId',
        );

        print('55555555555555555555555 ${response!.data}');

        final respModel = GetCheckOutView.fromJson(response!.data ?? {});

        return respModel;
      }
      return null;
    } catch (e) {
      Loader.hide();
      print('viewCheckOut Error :- $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> deleteCheckOut({required String checkOutID}) async {
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
          // queryParameters: {'id':checkOutID},
          '${EndPoints.checkOutDelete}/$checkOutID',
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

  Future<Map<String, dynamic>?> formSubmitCheckOut({
    required String dateTimeIdForCheckOut,
    required String employee,
    required String outTime,
    required String breakHours,
    required String checkInId,
    required String? comments,
    required String? workFrom,
    required String projects_1,
    required String remarks_1,
    required String reqHours_1,
    required String projectStatus_1,
    required String reqMin_1,
    required String refMain1,
    required String refSub1,
    String? breakHoursRemarks,
    String? latitude,
    String? longitude,
    String? projects_2,
    String? remarks_2,
    String? refMain2,
    String? refSub2,
    String? reqHours_2,
    String? reqMin_2,
    String? projectStatus_2,
    String? projects_3,
    String? remarks_3,
    String? reqHours_3,
    String? reqMin_3,
    String? projectStatus_3,
    String? refMain3,
    String? refSub3,
    String? projects_4,
    String? remarks_4,
    String? reqHours_4,
    String? reqMin_4,
    String? projectStatus_4,
    String? refMain4,
    String? refSub4,
    String? projects_5,
    String? remarks_5,
    String? reqHours_5,
    String? reqMin_5,
    String? projectStatus_5,
    String? refMain5,
    String? refSub5,
    String? projects_6,
    String? remarks_6,
    String? reqHours_6,
    String? reqMin_6,
    String? projectStatus_6,
    String? refMain6,
    String? refSub6,
  }) async {
    try {
      final token = StorageServices.to.getString(StorageServicesKeys.token);
      final haveToken = token.isNotEmpty;
      // print('refr_main_1 $refMain1');
      // print('refr_wub_1 $refSub1');
      // print('refr_main_1 $refMain2');
      // print('refr_sub_2 $refSub2');
      // print('refr_main_1 $refMain3');
      // print('refr_sub_3 $refSub3');
      if (haveToken) {
        final formData = FormData.fromMap({
          'employee': employee,
          'out_time': outTime,
          'break_hours': breakHours,
          'break_hours_remarks': breakHoursRemarks,
          'work_from': workFrom,
          'comments': comments,
          'check_in_id': checkInId,
          'latitude': latitude,
          'longitude': longitude,
          'projects_1': projects_1,
          'remarks_1': remarks_1,
          'req_hours_1': reqHours_1,
          'req_hours_min_1': reqMin_1,
          'projects_status_1': projectStatus_1,
          'refr_main_1': refMain1,
          'refr_sub_1': refSub1,
          'projects_2': projects_2,
          'remarks_2': remarks_2,
          'req_hours_2': reqHours_2,
          'req_hours_min_2': reqMin_2,
          'projects_status_2': projectStatus_2,
          'refr_main_2': refMain2,
          'refr_sub_2': refSub2,
          'projects_3': projects_3,
          'remarks_3': remarks_3,
          'req_hours_3': reqHours_3,
          'req_hours_min_3': reqMin_3,
          'projects_status_3': projectStatus_3,
          'refr_main_3': refMain3,
          'refr_sub_3': refSub3,
          'projects_4': projects_4,
          'remarks_4': remarks_4,
          'req_hours_min_4': reqMin_4,
          'projects_status_4': projectStatus_4,
          'req_hours_4': reqHours_4,
          'refr_main_4': refMain4,
          'refr_sub_4': refSub4,
          'projects_5': projects_5,
          'remarks_5': remarks_5,
          'req_hours_5': reqHours_5,
          'req_hours_min_5': reqMin_5,
          'projects_status_5': projectStatus_5,
          'refr_main_5': refMain5,
          'refr_sub_5': refSub5,
          'projects_6': projects_6,
          'remarks_6': remarks_6,
          'req_hours_6': reqHours_6,
          'req_hours_min_6': reqMin_6,
          'projects_status_6': projectStatus_6,
          'refr_main_6': refMain6,
          'refr_sub_6': refSub6,
        });
        final response = await api.dio?.post<Map<String, dynamic>>(
          options: Options(
            headers: {
              // 'accept': '*/*',
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ),
          queryParameters: {'dateIs': dateTimeIdForCheckOut},
          data: formData,
          EndPoints.checkOutFormSubmit,
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
