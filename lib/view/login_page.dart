// ignore_for_file: lines_longer_than_80_chars

import 'dart:ui';

import 'package:affiliate_platform/config/ripple.dart';
import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/utils/custom_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LoginCustomTextField(controller: emailController, hint: 'Enter your email', heading: 'Email'),
                        SizedBox(height: 20.h),
                        LoginCustomTextField(controller: passController, hint: 'Enter password', heading: 'Password'),
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
                      child: Container(
                        // width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 30.w),
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        // alignment: Alignment.center,
                        child: Text(
                          'Login',
                          style: AppStyles.openSans.copyWith(
                            color: Colors.white,
                            fontSize: 13.w,
                          ),
                        ),
                      ).ripple(context, () {
                        if (emailController.value.text == 'test' && passController.value.text == 'test') {
                          successMotionToastInfo(context, msg: 'Login is successful');
                        } else {
                          erroMotionToastInfo(context, msg: 'Login is failed');
                        }
                      }),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginCustomTextField extends StatelessWidget {
  const LoginCustomTextField({
    required this.controller,
    required this.heading,
    required this.hint,
    super.key,
  });

  final TextEditingController controller;
  final String heading;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(heading, style: TextStyle(fontSize: 12.w, color: Colors.white60)),
        SizedBox(height: 7.h),
        SizedBox(
          height: 50.h,
          child: TextFormField(
            controller: controller,
            style: AppStyles.openSans.copyWith(
              color: Colors.white,
              fontSize: 15.w,
            ),
            // expands: true,
            // maxLines: null,
            decoration: InputDecoration(
              // isDense: true,
              hintText: hint,
              hintStyle: AppStyles.openSans.copyWith(
                color: Colors.white24,
                fontSize: 15.w,
              ),
              contentPadding: EdgeInsets.only(left: 15.w),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Color.fromARGB(255, 103, 51, 137)),
                borderRadius: BorderRadius.circular(12.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color.fromARGB(255, 103, 51, 137)),
                borderRadius: BorderRadius.circular(12.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color.fromARGB(255, 152, 102, 185)),
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
