// ignore_for_file: lines_longer_than_80_chars, use_build_context_synchronously, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:affiliate_platform/config/ripple.dart';
import 'package:affiliate_platform/logic/settings/settings_bloc.dart';
import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/utils/custom_tools.dart';
import 'package:affiliate_platform/view/common/custom_header.dart';
import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

// final isPasswordObscure = ValueNotifier(true);

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  SettingsBloc? settingsBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    settingsBloc ??= Provider.of<SettingsBloc>(context);
    // settingsBloc!.clearStreams();

    super.didChangeDependencies();
  }

  final formKeyForLogin = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print('Build Method Called');
    final bloc = Provider.of<SettingsBloc>(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        await appExitDialog(context);
      },
      child: CustomScaffold(
        haveFloatingButton: false,
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              Scaffold.of(context).closeDrawer();
            },
            child: Column(
              children: [
                // const CustomHeader(heading: 'Change Password', isBackButtonNeeded: true),
                const CustomHeader(),

                //
                Padding(
                  padding: EdgeInsets.only(top: 30.h, bottom: 5.h, left: 35.w, right: 35.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Change Password', style: TextStyle(fontSize: 12.w, fontWeight: FontWeight.w600, color: const Color.fromARGB(220, 75, 2, 93))),
                      Container(width: 35.w, height: .5.h, color: const Color.fromARGB(220, 75, 2, 93)),
                      SizedBox(height: 15.h),
                      Form(
                        key: formKeyForLogin,
                        child: Column(
                          children: [
                            NewPasswordField(
                              heading: 'Current Password',
                              textStream: bloc.currentPasswordStream,
                              onChanged: bloc.currentPasswordStream.add,
                              // isObscure: isPasswordObscure.value,
                              hintText: 'Current Password',
                            ),
                            NewPasswordField(
                              heading: 'New Password',
                              textStream: bloc.newPasswordStream,
                              onChanged: bloc.newPasswordStream.add,
                              // isObscure: isPasswordObscure.value,
                              hintText: 'New Password',
                            ),
                            NewPasswordField(
                              heading: 'Confirm New Password',
                              textStream: bloc.confirmNewPasswordStream,
                              onChanged: bloc.confirmNewPasswordStream.add,
                              // isObscure: isPasswordObscure.value,
                              hintText: 'Confirm New Password',
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 15.h),

                      // Submit Button
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Text('Submit', style: AppStyles.poppins.copyWith(fontSize: 14.w, color: Colors.white)),
                        ).ripple(context, () async {
                          customLoader(context);
                          FocusScope.of(context).unfocus();
                          if (bloc.newPasswordStream.value != bloc.confirmNewPasswordStream.value) {
                            await erroMotionToastInfo(context, msg: 'New Password and Confirm Password are not matching');
                            Loader.hide();
                            return;
                          }
                          final resp = await bloc.changePassword();

                          if (resp != null && resp['status'] == 'SUCCESS' && resp['response'] == 'OK') {
                            // Navigator.pop(context);
                            await successMotionToastInfo(context, msg: resp['message'] as String);
                            Loader.hide();
                          } else if (resp != null && resp['status'] == 'ERROR' && resp['response'] == 'OK') {
                            // Navigator.pop(context);
                            await erroMotionToastInfo(context, msg: resp['message'] as String);
                            Loader.hide();
                          } else {
                            await erroMotionToastInfo(context, msg: 'Submission Failed !!');
                            Loader.hide();
                          }
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewPasswordField extends StatefulWidget {
  const NewPasswordField({
    // required this.controller,
    required this.heading,
    required this.textStream,
    // required this.controller,
    required this.hintText,
    this.icon,
    this.suffixIcon,
    this.isObscure = false,
    this.enabled = true,
    this.validator,
    this.keyboardType,
    this.onTap,
    this.onChanged,
    // this.initialValue = '',
    this.textInputType = TextInputType.name,
    this.isLargeField = false,
    this.isForDateField = false,
    this.isNewLeave = false,
    super.key,
  });

  final bool isForDateField;
  final bool isNewLeave;
  // final TextEditingController controller;
  final String heading;
  // final String initialValue;
  final bool isLargeField;
  final TextInputType textInputType;
  final BehaviorSubject<String> textStream;
  // final TextEditingController controller;
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
  State<NewPasswordField> createState() => _NewPasswordFieldState();
}

class _NewPasswordFieldState extends State<NewPasswordField> {
  final _controller = TextEditingController();

  final isPasswordObscure = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    widget.textStream.listen((value) {
      // print('15145646513514351436416546584 $value');
      if (value.isEmpty) {
        _controller.clear();
      } else if (_controller.text != value) {
        _controller.text = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: StreamBuilder<Object>(
        stream: widget.textStream,
        builder: (context, snapshot) {
          return InkWell(
            onTap: widget.onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(heading, style: AppStyles.poppins.copyWith(fontSize: 12.w, color: Colors.purple)),
                // SizedBox(height: 7.h),
                ValueListenableBuilder(
                  valueListenable: isPasswordObscure,
                  builder: (context, isObscure, _) {
                    return SizedBox(
                      // height: widget.isLargeField ? null : 50.h,
                      child: TextFormField(
                        maxLength: 30,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        // initialValue: widget.initialValue,
                        scrollPadding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom + 15.w * 6, // Adjust the value as needed
                        ),
                        // controller: controller,
                        style: AppStyles.poppins.copyWith(
                          color: Colors.purple,
                          fontSize: 13.w,
                        ),
                        keyboardType: !widget.isLargeField ? widget.textInputType : TextInputType.multiline,
                        // minLines: !isLargeField ? null : 1,
                        // maxLines: !isLargeField ? null : 20,
                        // maxLength: !isLargeField ? null : 500,
                        // expands:isLargeField ,
                        // maxLines: null,
                        controller: _controller,
                        validator: widget.validator,
                        onChanged: widget.onChanged,
                        // onTap: widget.onTap,
                        obscuringCharacter: '*',
                        // obscureText: widget.isObscure,
                        obscureText: isPasswordObscure.value,
                        enabled: widget.enabled,
                        decoration: InputDecoration(
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
                          // isDense: true,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: widget.heading,
                          labelStyle: AppStyles.poppins.copyWith(fontSize: 12.w, color: Colors.purple),
                          hintText: widget.hintText,
                          hintStyle: AppStyles.openSans.copyWith(
                            color: Colors.purple[100],
                            fontSize: 13.w,
                          ),
                          contentPadding: EdgeInsets.only(left: 15.w),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color.fromARGB(139, 103, 51, 137)),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color.fromARGB(139, 103, 51, 137)),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color.fromARGB(255, 152, 102, 185)),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
