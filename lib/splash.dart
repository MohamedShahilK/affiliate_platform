// ignore_for_file: use_build_context_synchronously, unawaited_futures, avoid_print, inference_failure_on_instance_creation, lines_longer_than_80_chars

import 'dart:io';
import 'dart:ui';

import 'package:affiliate_platform/logic/auth/auth_bloc.dart';
import 'package:affiliate_platform/utils/constants/string_constants.dart';
import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/utils/internal_services/storage_services.dart';
import 'package:affiliate_platform/view/auth/login_page.dart';
import 'package:affiliate_platform/view/common/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  AuthBloc? bloc;

  @override
  void initState() {
    super.initState();
    // navigateToHome();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      validLogin();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc ??= Provider.of<AuthBloc>(context);
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

  Future<void> validLogin() async {
    // print('111111111111111111111111111111111111111');
    final authBloc = Provider.of<AuthBloc>(context, listen: false);
    // final authServices = AuthServices();
    final token = StorageServices.to.getString(StorageServicesKeys.token);

    final haveToken = token.isNotEmpty;

    if (haveToken) {
      final authResp = await authBloc.validateToken(token: token);

      if (authResp != null && authResp.status == 'SUCCESS' && authResp.response == 'Valid token') {
        final regenerateAuthResp = await authBloc.regenerateToken(token: token);

        if (regenerateAuthResp != null && regenerateAuthResp.status == 'SUCCESS' && regenerateAuthResp.response == 'Token regeneration success') {
          await StorageServices.to.setString(
            StorageServicesKeys.token,
            regenerateAuthResp.accessToken ?? token,
          );

          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => UpgradeAlert(
                dialogStyle: Platform.isIOS ? UpgradeDialogStyle.cupertino : UpgradeDialogStyle.material,
                showIgnore: false,
                upgrader: Upgrader(durationUntilAlertAgain: const Duration(seconds: 2)),
                child: const SideBar(),
              ),
              transitionDuration: const Duration(milliseconds: 400),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
          return;
        } else {
          // erroMotionToastInfo(context, msg: 'Token Regenration has issues. Contact administrator');
          Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => UpgradeAlert(
                dialogStyle: Platform.isIOS ? UpgradeDialogStyle.cupertino : UpgradeDialogStyle.material,
                showIgnore: false,
                upgrader: Upgrader(durationUntilAlertAgain: const Duration(seconds: 2)),
                child: const LoginPage(),
              ),
              transitionDuration: const Duration(seconds: 1),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
            (route) => false,
          );
          return;
        }
      } else if (authResp == null) {
        //print('Invalid Token $token');
        // erroMotionToastInfo(context, msg: 'Token Regenration has issues. Contact administrator');
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => UpgradeAlert(
              dialogStyle: Platform.isIOS ? UpgradeDialogStyle.cupertino : UpgradeDialogStyle.material,
              showIgnore: false,
              upgrader: Upgrader(durationUntilAlertAgain: const Duration(seconds: 2)),
              child: const LoginPage(),
            ),
            transitionDuration: const Duration(seconds: 1),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
          (route) => false,
        );
        return;
      }
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => UpgradeAlert(
            dialogStyle: Platform.isIOS ? UpgradeDialogStyle.cupertino : UpgradeDialogStyle.material,
            showIgnore: false,
            upgrader: Upgrader(durationUntilAlertAgain: const Duration(seconds: 2)),
            child: const LoginPage(),
          ),
          transitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
        (route) => false,
      );

      return;
    }
  }
}
