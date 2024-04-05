// ignore_for_file: lines_longer_than_80_chars

import 'dart:io';
import 'dart:ui';

import 'package:affiliate_platform/config/ripple.dart';
import 'package:affiliate_platform/logic/auth/auth_bloc.dart';
import 'package:affiliate_platform/utils/constants/string_constants.dart';
import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/utils/custom_tools.dart';
import 'package:affiliate_platform/utils/internal_services/storage_services.dart';
import 'package:affiliate_platform/view/auth/widgets/login_textfield.dart';
import 'package:affiliate_platform/view/common/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';

final isPasswordObscure = ValueNotifier(true);

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthBloc? authBloc;

  bool isLoading = false;
  String isValidString = '';

  // final emailController = TextEditingController();
  // final passController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authBloc ??= Provider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<AuthBloc>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.red,
      // body: Container(
      //   decoration: const BoxDecoration(
      //     image: DecorationImage(
      //       image: AssetImage('assets/abstract-digital-grid-black-background.jpg'),
      //       fit: BoxFit.fill,
      //     ),
      //   ),
      //   // child: Column(
      //   //   mainAxisAlignment: MainAxisAlignment.center,
      //   //   children: [
      //   //     Container(
      //   //       padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
      //   //       color: Colors.white,
      //   //     ),
      //   //   ],
      //   // ),

      //   //
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Container(),
      //       Text('Log in',style: TextStyle(color: Colors.white,fontSize: 16.w))
      //     ],
      //   ),
      // ),

      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/images/bg1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 35.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(),
                  Center(child: Image.asset('assets/images/logo-dark.png', width: 160.w)),

                  //
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.h),
                    child: Center(
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('SignIn', style: TextStyle(fontSize: 14.w, fontWeight: FontWeight.w600, color: Colors.grey[700])),
                          Text('Login to your existing account', style: TextStyle(fontSize: 10.w, fontWeight: FontWeight.w400, color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 30.h),

                  Form(
                    key: formKeyForLogin,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LoginCustomTextField(
                          hintText: 'Enter your email',
                          heading: 'Email',
                          keyboardType: TextInputType.visiblePassword,
                          textStream: bloc.emailStream,
                          onChanged: bloc.emailStream.add,
                          enabled: !isLoading,
                          validator: (input) {
                            if (input == null || input.isEmpty) {
                              return 'Username is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.h),
                        ValueListenableBuilder(
                          valueListenable: isPasswordObscure,
                          builder: (context, isObscure, _) {
                            return LoginCustomTextField(
                              hintText: 'Enter password',
                              heading: 'Password',
                              textStream: bloc.passwordStream,
                              onChanged: bloc.passwordStream.add,
                              enabled: !isLoading,
                              isObscure: isPasswordObscure.value,
                              suffixIcon: Container(
                                alignment: Alignment.center,
                                height: 50.h,
                                width: 40.w,
                                child: Icon(
                                  isPasswordObscure.value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                  size: 18,
                                  // color: AppColors.loginPrefixIconColor,
                                  color: Colors.blue[900],
                                ),
                              ).ripple(context, () {
                                isPasswordObscure.value = !isPasswordObscure.value;
                                isPasswordObscure.notifyListeners();
                              }),
                              validator: (input) {
                                if (input == null || input.isEmpty) {
                                  return 'Password is required';
                                }
                                return null;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 15.h),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot Password?',
                        style: AppStyles.openSans.copyWith(
                          color: Colors.white70,
                          fontSize: 11.w,
                        ),
                      ),
                    ),
                  ),

                  // Button
                  Padding(
                    padding: EdgeInsets.only(top: 15.h),
                    child: Align(
                      // child: Container(
                      //   // width: double.infinity,
                      //   padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 30.w),
                      //   decoration: BoxDecoration(
                      //     color: Colors.purple,
                      //     borderRadius: BorderRadius.circular(50.r),
                      //   ),
                      //   // alignment: Alignment.center,
                      //   child: Text(
                      //     'Login',
                      //     style: AppStyles.openSans.copyWith(
                      //       color: Colors.white,
                      //       fontSize: 13.w,
                      //     ),
                      //   ),
                      // )

                      child: Container(
                        height: 35.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: isLoading ? Colors.grey : Colors.purple,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[600]!,
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (isLoading)
                              Container(
                                width: 24.w,
                                height: 24.h,
                                padding: EdgeInsets.all(2.h),
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              )
                            else
                              Icon(
                                Icons.lock,
                                size: 20.sp,
                                color: Colors.white70,
                              ),
                            SizedBox(width: 5.w),
                            const Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ).ripple(context, () {
                        // if (emailController.value.text == 'test' && passController.value.text == 'test') {
                        //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ManageContactPage(),));
                        //   successMotionToastInfo(context, msg: 'Login is successful');
                        // } else {
                        //   erroMotionToastInfo(context, msg: 'Login is failed');
                        // }

                        //
                        FocusScope.of(context).requestFocus(FocusNode());

                        if (isLoading) return;

                        final authBloc = Provider.of<AuthBloc>(context, listen: false);

                        InternetConnectionChecker().hasConnection.then((isOnline) async {
                          if (!isOnline) {
                            await erroMotionToastInfo(context, msg: 'No Internet Connection');
                          } else {
                            if (formKeyForLogin.currentState == null) {
                              print('44444444444444444444444444444444444');
                              return;
                            }

                            final isValid = formKeyForLogin.currentState!.validate();
                            setState(() {
                              isValidString = 'valid';
                            });

                            if (isValid) {
                              setState(() {
                                isValidString = '';
                              });

                              setState(() {
                                isLoading = true;
                              });

                              Future.delayed(Duration.zero, () async {
                                final email = authBloc.emailStream.value;
                                final pass = authBloc.passwordStream.value;

                                final authResp = await authBloc.login(
                                  context,
                                  email: email,
                                  password: pass,
                                );

                                if (authResp != null && authResp.status == 'SUCCESS' && authResp.response == 'login success') {
                                  final token = authResp.accessToken;

                                  // Saving token in to SharedPreference
                                  await StorageServices.to.setString(
                                    StorageServicesKeys.token,
                                    token!,
                                  );
                                  // Saving token in to SharedPreference

                                  // await authBloc.validateToken(token: token);

                                  await Navigator.pushAndRemoveUntil(
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
                                    (route) => false,
                                  );
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              });
                            }
                          }
                        });
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
