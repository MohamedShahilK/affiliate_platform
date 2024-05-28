// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/api/api.dart';
import 'package:affiliate_platform/api/api_contants.dart';
import 'package:affiliate_platform/models/leave/leave_model.dart';
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
  Future<GetAllLeaves?> getAllLeaves() async {
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
          EndPoints.getAllLeaves,
        );

        final respModel = GetAllLeaves.fromJson(response!.data ?? {});

        return respModel;
      }
      return null;
    } catch (e) {
      Loader.hide();
      print('getAllContacts Error :- $e');
      return null;
    }
  }
}
