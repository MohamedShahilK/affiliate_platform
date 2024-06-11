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
          // queryParameters: {
          //   'out_date_search': '01/06/2024',
          //   'out_date_search_2': '08/06/2024',
          // },
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
    String? projects_3,
    String? remarks_3,
    String? reqHours_3,
    String? refMain3,
    String? refSub3,
    String? projects_4,
    String? remarks_4,
    String? reqHours_4,
    String? refMain4,
    String? refSub4,
    String? projects_5,
    String? remarks_5,
    String? reqHours_5,
    String? refMain5,
    String? refSub5,
    String? projects_6,
    String? remarks_6,
    String? reqHours_6,
    String? refMain6,
    String? refSub6,
  }) async {
    try {
      final token = StorageServices.to.getString(StorageServicesKeys.token);
      final haveToken = token.isNotEmpty;
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
          'refr_main_1': refMain1,
          'refr_sub_1': refSub1,
          'projects_2': projects_2,
          'remarks_2': remarks_2,
          'req_hours_2': reqHours_2,
          'refr_main_2': refMain1,
          'refr_sub_2': refSub1,
          'projects_3': projects_3,
          'remarks_3': remarks_3,
          'req_hours_3': reqHours_3,
          'refr_main_3': refMain1,
          'refr_sub_3': refSub1,
          'projects_4': projects_4,
          'remarks_4': remarks_4,
          'req_hours_4': reqHours_4,
          'refr_main_4': refMain1,
          'refr_sub_4': refSub1,
          'projects_5': projects_5,
          'remarks_5': remarks_5,
          'req_hours_5': reqHours_5,
          'refr_main_5': refMain1,
          'refr_sub_5': refSub1,
          'projects_6': projects_6,
          'remarks_6': remarks_6,
          'req_hours_6': reqHours_6,
          'refr_main_6': refMain1,
          'refr_sub_6': refSub1,
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
