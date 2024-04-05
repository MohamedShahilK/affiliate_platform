// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';

final formKeyForLogin = GlobalKey<FormState>();

class LoginCustomTextField extends StatefulWidget {
  const LoginCustomTextField({
    required this.textStream,
    // required this.controller,
    required this.heading,
    required this.hintText,
    this.icon,
    this.suffixIcon,
    super.key,
    this.isObscure = false,
    this.enabled = true,
    this.validator,
    this.keyboardType,
    this.onTap,
    this.onChanged,
  });

  final BehaviorSubject<String> textStream;
  // final TextEditingController controller;
  final String heading;
  final String hintText;
  final IconData? icon;
  final bool isObscure;
  final bool enabled;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final void Function()? onTap;
  final void Function(String)? onChanged;

  @override
  State<LoginCustomTextField> createState() => _LoginCustomTextFieldState();
}

class _LoginCustomTextFieldState extends State<LoginCustomTextField> {
  final _controller = TextEditingController();
  @override
  void initState() {
    widget.textStream.listen((value) {
      if (value.isEmpty) {
        _controller.clear();
      } else if (_controller.text != value) {
        _controller.text = value;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: widget.textStream,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.heading, style: TextStyle(fontSize: 12.w, color: Colors.white60)),
            SizedBox(height: 7.h),
            SizedBox(
              height: 50.h,
              child: TextFormField(
                // controller: controller,
                style: AppStyles.openSans.copyWith(
                  color: Colors.white,
                  fontSize: 15.w,
                ),
                // expands: true,
                // maxLines: null,
                controller: _controller,
                validator: widget.validator,
                onChanged: widget.onChanged,
                onTap: widget.onTap,
                obscuringCharacter: '*',
                obscureText: widget.isObscure,
                enabled: widget.enabled,
                keyboardType: widget.keyboardType,
                decoration: InputDecoration(
                  // isDense: true,
                  hintText: widget.hintText,
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
                  // prefixIcon: Column(
                  //   mainAxisSize: MainAxisSize.min,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Container(
                  //       height: 40.h,
                  //       width: 30.w,
                  //       alignment: Alignment.center,
                  //       decoration: BoxDecoration(
                  //         // color: Colors.grey[100],
                  //         // border: Border.all(color: Colors.grey[400]!),
                  //         borderRadius: BorderRadius.only(
                  //           topLeft: Radius.circular(5.r),
                  //           bottomLeft: Radius.circular(5.r),
                  //         ),
                  //       ),
                  //       child: Icon(
                  //         widget.icon,
                  //         size: 18.w,
                  //         // color: AppColors.loginPrefixIconColor,
                  //         color: Colors.purple.withOpacity(.7),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  suffixIcon: widget.suffixIcon,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
