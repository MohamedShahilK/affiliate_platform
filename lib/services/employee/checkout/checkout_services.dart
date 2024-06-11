// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/api/api.dart';
import 'package:affiliate_platform/api/api_contants.dart';
import 'package:affiliate_platform/api/api_errror_handling.dart';
import 'package:affiliate_platform/models/employee/checkin/get_checkin_form.dart';
import 'package:affiliate_platform/models/employee/checkin/getall_checkins.dart';
import 'package:affiliate_platform/models/employee/checkout/get_allcheckout.dart';
import 'package:affiliate_platform/models/employee/checkout/get_checkout_form_model.dart';
import 'package:affiliate_platform/models/employee/project/view_project.dart';
import 'package:affiliate_platform/models/manage_contact/contact_edit_submission_model.dart';
import 'package:affiliate_platform/utils/constants/string_constants.dart';
import 'package:affiliate_platform/utils/custom_tools.dart';
import 'package:affiliate_platform/utils/internal_services/storage_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
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
          // queryParameters: {},
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

  
  Future<ProjectView?> viewCheckOut({required String contactId}) async {
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
          '${EndPoints.projectView}/$contactId',
        );

        print('55555555555555555555555 ${response!.data}');

        final respModel = ProjectView.fromJson(response!.data ?? {});

        return respModel;
      }
      return null;
    } catch (e) {
      Loader.hide();
      print('viewCheckOut Error :- $e');
      return null;
    }
  }

}
