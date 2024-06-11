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
}
