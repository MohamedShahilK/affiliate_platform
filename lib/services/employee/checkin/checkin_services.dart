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
}
