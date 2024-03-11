import 'package:affiliate_platform/utils/constants/connectivity_controller.dart';
import 'package:affiliate_platform/utils/internal_services/storage_services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<void> mainInitialization() async {
  // WidgetsFlutterBinding.ensureInitialized();
  Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    ConnectivityController().isInternetConnected(result);
  });

  // lock screen orientation into portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Hide Status bar
  // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);

  // putAsync, because "StorageServices" class returns only after sharedPreferences is initialized, it is a Future function
  await Get.putAsync<StorageServices>(() => StorageServices().init());
}
