// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/api/api.dart';
import 'package:affiliate_platform/api/api_contants.dart';
import 'package:affiliate_platform/models/manage_contact/all_contacts.dart';
import 'package:affiliate_platform/utils/constants/string_constants.dart';
import 'package:affiliate_platform/utils/internal_services/storage_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class SettingsSevices {
  factory SettingsSevices() {
    return _singleton;
  }

  SettingsSevices._internal();
  static final SettingsSevices _singleton = SettingsSevices._internal();

  final api = Api();

  // Get All Contacts
  Future<Map<String, dynamic>?> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    try {
      final token = StorageServices.to.getString(StorageServicesKeys.token);
      final haveToken = token.isNotEmpty;
      if (haveToken) {
        final formData = FormData.fromMap({
          'current_password': currentPassword,
          'new_password': newPassword,
          'confirm_new_password': confirmNewPassword,
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
          EndPoints.changePassword,
        );

        // print('4444444444444444444444444444444444 ${response!.data}');

        return response?.data ?? {};
      }
      return null;
    } catch (e) {
      Loader.hide();
      print('changePassword Error :- $e');
      return null;
    }
  }
}
