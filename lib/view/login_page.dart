// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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

      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 35.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(),
            Center(child: Image.asset('logo-dark.png', width: 160.w)),

            //
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.h),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('SignIn', style: TextStyle(fontSize: 14.w, fontWeight: FontWeight.w600, color: Colors.grey[700])),
                    Text('Login to your existing account', style: TextStyle(fontSize: 8.w, fontWeight: FontWeight.w200, color: Colors.grey[700])),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30.h),

            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email', style: TextStyle(fontSize: 10.w)),
                  SizedBox(height: 5.h),
                  SizedBox(
                    height: 40.h,                  
                    child: TextFormField(
                      // expands: true,
                      // maxLines: null,
                      // cursorHeight: 18.h,
                      decoration: InputDecoration(
                        // isDense: true,
                        hintText: 'Enter your email',
                        hintStyle: AppStyles.openSans.copyWith(
                          color: Colors.grey,
                          fontSize: 10.w,
                        ),
                        contentPadding: EdgeInsets.only(left: 15.w),
                        
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color.fromARGB(255, 146, 69, 197)),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color.fromARGB(255, 80, 19, 121)),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Text('Password', style: TextStyle(fontSize: 10.w)),
                  SizedBox(height: 5.h),
                  SizedBox(
                    height: 40.h,
                    child: TextFormField(
                      // expands: true,
                      // maxLines: null,
                      decoration: InputDecoration(
                        // isDense: true,
                        hintText: 'Enter password',
                        hintStyle: AppStyles.openSans.copyWith(
                          color: Colors.grey,
                          fontSize: 10.w,
                        ),
                        contentPadding: EdgeInsets.only(left: 15.w),
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color.fromARGB(255, 146, 69, 197)),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color.fromARGB(255, 80, 19, 121)),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                    ),
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
                    color: Colors.grey[600],
                    fontSize: 9.w,
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
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
