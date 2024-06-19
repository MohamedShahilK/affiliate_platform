// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/api/api.dart';
import 'package:affiliate_platform/api/api_contants.dart';
import 'package:affiliate_platform/models/attendance/attendance_model.dart';
import 'package:affiliate_platform/utils/constants/string_constants.dart';
import 'package:affiliate_platform/utils/internal_services/storage_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class AttendanceServices {
  factory AttendanceServices() {
    return _singleton;
  }

  AttendanceServices._internal();
  static final AttendanceServices _singleton = AttendanceServices._internal();

  final api = Api();

  // Get All Contacts
  Future<GetAttendanceModel?> getAttendaceDetails({String? filterDate}) async {
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
          queryParameters: {'filter_date': filterDate},
          EndPoints.getAttendance,
        );

        print('4444444444444444444444444444444444 ${response!.data}');

        final respModel = GetAttendanceModel.fromJson(response.data ?? {});

        return respModel;
      }
      return null;
    } catch (e) {
      Loader.hide();
      print('getAttendaceDetails Error :- $e');
      return null;
    }
  }
}
