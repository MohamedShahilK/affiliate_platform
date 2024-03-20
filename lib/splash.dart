// ignore_for_file: use_build_context_synchronously, unawaited_futures, avoid_print, inference_failure_on_instance_creation, lines_longer_than_80_chars

import 'dart:ui';

import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/view/common/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // final isLogined = StorageServices.to.getBool(StorageServicesKeys.isLoginKey);

  Future<void> validLogin() async {
    await Future.delayed(const Duration(seconds: 3));

    //
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SideBar()), (route) => false);
  }

  @override
  void initState() {
    super.initState();
    // navigateToHome();
    validLogin();
  }

  // Future<void> navigateToHome() async {
  //   await Future.delayed(const Duration(seconds: 3));
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) =>
  //             // isLogined ? const CustomDrawer() : const LoginPage(),
  //             isLogined ? NavigationPage() : const LoginPage(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.withClampedTextScaling(
      minScaleFactor: 0.85, // set min scale value here
      maxScaleFactor: .95,
      child: Scaffold(
        // backgroundColor: Colors.amber,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg2.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Padding(
                // padding: EdgeInsets.only(top: 150.h),
                padding: EdgeInsets.only(top: 0.h),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(),
                    const Spacer(),
                    // Logo
                    Image.asset(
                      // AppImages.appLogo,
                      'assets/images/logo-dark.png',
                      width: 320.w,
                    ),
                    SizedBox(height: 5.h),

                    SizedBox(height: 10.h),
                    LoadingAnimationWidget.dotsTriangle(
                      color: Colors.purple.shade400,
                      size: 40.sp,
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Powered by ',
                            style: AppStyles.openSans.copyWith(
                              fontSize: 12.w,
                            ),
                          ),
                          Image.asset(
                            'assets/images/logo-dark.png',
                            width: 70.w,
                          ),
                          Text(
                            ' © ${DateTime.now().year}',
                            style: AppStyles.openSans.copyWith(
                              fontSize: 12.w,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
