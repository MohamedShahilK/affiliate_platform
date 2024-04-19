// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/config/ripple.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// import 'package:elegant_notification/elegant_notification.dart';

Future<void> successMotionToastInfo(
  BuildContext context, {
  required String msg,
  // AnimationType animationType = AnimationType.fromLeft,
  Duration animationDuration = const Duration(milliseconds: 1300),
  double? width,
  double? height,
}) async {
  DelightToastBar(
    autoDismiss: true,
    builder: (context) => ToastCard(
      color: Colors.green[100],
      leading: Icon(Icons.check_circle_outline_rounded, size: 25, color: Colors.green[800]),
      title: Text(
        msg,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.green[800],
          fontSize: 13,
        ),
      ),
    ),
  ).show(context);
}

Future<void> erroMotionToastInfo(
  BuildContext context, {
  required String msg,
  // AnimationType animationType = AnimationType.fromLeft,
  Duration animationDuration = const Duration(milliseconds: 1300),
  double? width,
  double? height,
}) async {
  DelightToastBar(
    autoDismiss: true,
    builder: (context) => ToastCard(
      color: Colors.red[100],
      leading: Icon(Icons.error_outline_sharp, size: 25, color: Colors.red[800]),
      title: Text(
        msg,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.red[800],
          fontSize: 13,
        ),
      ),
    ),
  ).show(context);
}

Future<void> warningMotionToastInfo(
  BuildContext context, {
  required String msg,
  // AnimationType animationType = AnimationType.fromLeft,
  Duration animationDuration = const Duration(milliseconds: 1300),
  double? width,
  double? height,
}) async {
  DelightToastBar(
    autoDismiss: true,
    builder: (context) => ToastCard(
      color: Colors.yellow[100],
      leading: Icon(Icons.warning_amber, size: 25, color: Colors.yellow[800]),
      title: Text(
        msg,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.yellow[800],
          fontSize: 13,
        ),
      ),
    ),
  ).show(context);
}

void customLoader(BuildContext context) {
  return Loader.show(
    context,
    progressIndicator: LoadingAnimationWidget.horizontalRotatingDots(
      color: Colors.purple[400]!,
      size: 40.sp,
    ),
  );
}

void customLoaderForPdf(BuildContext context) {
  return Loader.show(
    context,
    progressIndicator: SafeArea(
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingAnimationWidget.beat(
                    color: Colors.purple,
                    size: 8.sp,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Generating Pdf...',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.purple,
                      fontSize: 10.w,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 20.h,
            right: 20.w,
            child: Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.purple[300]),
              child: Icon(Icons.close, size: 15.w, color: Colors.white),
            ).ripple(context, Loader.hide),
          ),
        ],
      ),
    ),
  );
}

void customInternetLoader(BuildContext context) {
  return Loader.show(
    context,
    progressIndicator: LoadingAnimationWidget.beat(
      color: Colors.purple[400]!,
      size: 40.sp,
    ),
  );
}

Future<bool?> showWarningDialog(
  BuildContext context, {
  required String title,
  required String description,
  required String yes,
  required String no,
  Color yesColor = Colors.green,
}) async {
  final isTrue = await showDialog<bool>(
    // barrierDismissible: false,
    context: context,
    builder: (BuildContext ctx) {
      return MediaQuery.withClampedTextScaling(
        minScaleFactor: 0.85, // set min scale value here
        maxScaleFactor: .95,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.purple),
            borderRadius: BorderRadius.circular(15.r),
          ),
          actionsPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 15.h,
          ),
          iconPadding: EdgeInsets.symmetric(horizontal: 12.w),
          buttonPadding: EdgeInsets.symmetric(horizontal: 12.w),
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
          titlePadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 10.h,
          ),
          title: Text(
           title,
            style: TextStyle(
              fontSize: 13.w,
              color: const Color.fromARGB(255, 104, 0, 239),
            ),
          ),
          content: Text(
            description,
            style: TextStyle(fontSize: 14.w),
          ),
          actions: <Widget>[
            SizedBox(
              height: 24.h,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    // color: Color.fromARGB(255, 209, 174, 226),
                    color: Colors.transparent,
                  ),
                  // foregroundColor: const Color.fromARGB(255, 146, 80, 177),
                  backgroundColor: yesColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  Navigator.pop(context, true);
                },
                child: Text(
                  yes,
                  style: TextStyle(fontSize: 12.w),
                ),
              ),
            ),
            SizedBox(
              height: 24.h,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 209, 174, 226),
                  ),
                  // backgroundColor:
                  //     Color.fromARGB(255, 146, 80, 177),
                  foregroundColor: const Color.fromARGB(255, 146, 80, 177),
                ),
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text(
                  no,
                  style: TextStyle(fontSize: 12.w),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
  return isTrue;
}
