// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:affiliate_platform/view/common/sidebar.dart';
import 'package:affiliate_platform/view/manage_contact/new_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      haveFloatingButton: false,
      body: SafeArea(
        child: Column(
          children: [
            const CustomHeader(heading: 'Edit Profile', isBackButtonNeeded: true),

            //
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
                  child: Column(
                    children: [
                      Container(),
                      const NewProfileField(heading: 'First Name', hint: 'First Name'),
                      const NewProfileField(heading: 'Last Name', hint: 'Last Name'),
                      const NewProfileField(heading: 'Joining Date', hint: 'Joining Date'),
                      const NewProfileField(heading: 'Phone Number', hint: 'Phone Number'),
                      const NewProfileField(heading: 'Designation', hint: 'Designation'),
                      // const NewProfileField(heading: 'Permanent Address', hint: 'Permanent Address'),
                      const NewProfileLargeField(heading: 'Permanent Address', hint: 'Permanent Address'),
                      const NewProfileLargeField(heading: 'Communication Address', hint: 'Communication Address'),
                      const NewProfileLargeField(heading: 'Education / Qualification Information', hint: 'Education / Qualification Information'),
                      const NewProfileLargeField(heading: 'Previous Experience Information', hint: 'Previous Experience Information'),

                      SizedBox(height: 15.h),

                      // Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Text('Reset', style: AppStyles.poppins.copyWith(fontSize: 14.w, color: Colors.white)),
                          ),
                          SizedBox(width: 10.w),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Text('Submit', style: AppStyles.poppins.copyWith(fontSize: 14.w, color: Colors.white)),
                          ),
                        ],
                      ),

                      SizedBox(height: 160.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewProfileField extends StatelessWidget {
  const NewProfileField({
    // required this.controller,
    required this.heading,
    required this.hint,
    this.initialValue = '',
    this.textInputType = TextInputType.name,
    this.isLargeField = false,
    super.key,
  });

  // final TextEditingController controller;
  final String heading;
  final String hint;
  final String initialValue;
  final bool isLargeField;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(heading, style: AppStyles.poppins.copyWith(fontSize: 12.w, color: Colors.purple)),
          // SizedBox(height: 7.h),
          SizedBox(
            height: isLargeField ? null : 50.h,
            child: TextFormField(
              initialValue: initialValue,
              scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 15.w * 6, // Adjust the value as needed
              ),
              // controller: controller,
              style: AppStyles.poppins.copyWith(
                color: Colors.purple,
                fontSize: 13.w,
              ),
              keyboardType: !isLargeField ? textInputType : TextInputType.multiline,
              // minLines: !isLargeField ? null : 1,
              // maxLines: !isLargeField ? null : 20,
              // maxLength: !isLargeField ? null : 500,
              // expands:isLargeField ,
              // maxLines: null,
              decoration: InputDecoration(
                // isDense: true,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: heading,
                labelStyle: AppStyles.poppins.copyWith(fontSize: 12.w, color: Colors.purple),
                hintText: hint,
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
          ),
        ],
      ),
    );
  }
}

class NewProfileLargeField extends StatelessWidget {
  const NewProfileLargeField({
    // required this.controller,
    required this.heading,
    required this.hint,
    this.initialValue = '',
    this.textInputType = TextInputType.name,
    this.isLargeField = false,
    super.key,
  });

  // final TextEditingController controller;
  final String heading;
  final String hint;
  final String initialValue;
  final bool isLargeField;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(heading, style: AppStyles.poppins.copyWith(fontSize: 12.w, color: Colors.purple)),
          // SizedBox(height: 7.h),
          SizedBox(
            height: 100.h,
            child: TextFormField(
              initialValue: initialValue,
              scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 15.w * 6, // Adjust the value as needed
              ),
              // controller: controller,
              style: AppStyles.poppins.copyWith(
                color: Colors.purple,
                fontSize: 13.w,
              ),
              keyboardType: !isLargeField ? textInputType : TextInputType.multiline,
              // minLines: !isLargeField ? null : 1,
              // maxLines: !isLargeField ? null : 20,
              maxLength: 500,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              expands: true,
              maxLines: null,
              decoration: InputDecoration(
                // isDense: true,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: heading,
                labelStyle: AppStyles.poppins.copyWith(fontSize: 12.w, color: Colors.purple),
                hintText: hint,
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
          ),
        ],
      ),
    );
  }
}
