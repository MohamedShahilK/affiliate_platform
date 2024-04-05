// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/models/auth/auth_model.dart';
import 'package:affiliate_platform/services/auth/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc {
  AuthBloc() {
    initDetails();
  }

  final emailStream = BehaviorSubject<String>.seeded('');
  final passwordStream = BehaviorSubject<String>.seeded('');

  Future<void> initDetails() async {}

  Future<AuthModel?> validateToken({required String token}) async {
    return AuthServices().validateToken(token: token);
  }

  Future<AuthModel?> regenerateToken({required String token}) async {
    return AuthServices().regenerateToken(token: token);
  }

  Future<AuthModel?> login(BuildContext context, {required String email, required String password}) async {
    return AuthServices().login(context, email: email, password: password);
  }

  void dispose() {}
}
