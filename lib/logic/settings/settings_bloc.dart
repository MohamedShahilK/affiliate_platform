// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/services/settings/settings_services.dart';
import 'package:rxdart/rxdart.dart';

class SettingsBloc {
  SettingsBloc() {
    initDetails();
  }

  final currentPasswordStream = BehaviorSubject<String>.seeded('');
  final newPasswordStream = BehaviorSubject<String>.seeded('');
  final confirmNewPasswordStream = BehaviorSubject<String>.seeded('');

  Future<void> initDetails() async {}

  Future<Map<String, dynamic>?> changePassword() async {
    final respJson = await SettingsSevices().changePassword(
      currentPassword: currentPasswordStream.value,
      newPassword: newPasswordStream.value,
      confirmNewPassword: confirmNewPasswordStream.value,
    );
    return respJson;
  }

  void clearStreams() {
    currentPasswordStream.add('');
    newPasswordStream.add('');
    confirmNewPasswordStream.add('');
  }

  void dispose() {
    currentPasswordStream.close();
    newPasswordStream.close();
    confirmNewPasswordStream.close();
  }
}
