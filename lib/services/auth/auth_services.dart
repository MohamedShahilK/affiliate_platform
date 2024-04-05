import 'package:affiliate_platform/api/api.dart';
import 'package:affiliate_platform/api/api_contants.dart';
import 'package:affiliate_platform/api/api_errror_handling.dart';
import 'package:affiliate_platform/models/auth/auth_model.dart';
import 'package:affiliate_platform/utils/constants/string_constants.dart';
import 'package:affiliate_platform/utils/custom_tools.dart';
import 'package:affiliate_platform/utils/internal_services/storage_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class AuthServices {
  factory AuthServices() {
    return _singleton;
  }

  AuthServices._internal();
  static final AuthServices _singleton = AuthServices._internal();

  final api = Api();

  // Get Token
  Future<AuthModel?> validateToken({required String token}) async {
    try {
      final token = StorageServices.to.getString(StorageServicesKeys.token);
      final haveToken = token.isNotEmpty;
      if (haveToken) {
        final response = await api.dio?.get<Map<String, dynamic>>(
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              // 'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ),
          EndPoints.validateToken,
        );

        return AuthModel.fromJson(response!.data ?? {});
      }
      return null;
    } catch (e) {
      Loader.hide();
      print('getToken function $e');
      // rethrow;
      return null;
    }
  }

  // Regenerate Token
  Future<AuthModel?> regenerateToken({required String token}) async {
    try {
      final token = StorageServices.to.getString(StorageServicesKeys.token);
      final haveToken = token.isNotEmpty;
      if (haveToken) {
        final response = await api.dio!.get<Map<String, dynamic>>(
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ),
          EndPoints.regenerateToken,
        );

        return AuthModel.fromJson(response.data ?? {});
      }
      return null;
    } on Exception catch (e) {
      Loader.hide();
      // log(e.toString());
      print('regenerateToken Error $e');
      rethrow;
    }
  }

  // Logout
  Future<void> logout() async {
    await StorageServices.to.remove(StorageServicesKeys.token);
  }

  // Auth
  Future<AuthModel?> login(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    try {
      final formData = FormData.fromMap({
        'email': email,
        'password': password,
      });

      final response = await api.dio!.post<Map<String, dynamic>>(
        EndPoints.login,
        data: formData,
      );

      return AuthModel.fromJson(response.data ?? {});
    } on UnauthorizedException catch (e) {
      Loader.hide();
      final errorResponse = e.response;
      final errorMsg = (errorResponse?.data?['errors'] as Map<String, dynamic>)['error'];

      await erroMotionToastInfo(context, msg: errorMsg as String);
      // print('login function Error1 : ${(errorResponse?.data?['errors'] as Map<String,dynamic>)['error']}');
      return null;
      // rethrow;
    } on Exception catch (e) {
      Loader.hide();
      print('login function Error2 : $e');
      // await toastInfo(
      //   msg: 'Invalid Username or Password',
      // );
      return null;
      // rethrow;
    }
  }
}
