// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewContact extends StatelessWidget {
  const NewContact({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomHeader(isBackButtonNeeded: true,heading: 'Add New Contact'),
          // Padding(
          //   padding: EdgeInsets.only(top: 15.h),
          //   // child: Row(
          //   //   children: [
          //   //     const Expanded(child: Divider(height: 1)),
          //   //     SizedBox(width: 15.w),
          //   //     Text(
          //   //       'Add New Contact',
          //   //       style: TextStyle(fontSize: 16.w),
          //   //     ),
          //   //     SizedBox(width: 15.w),
          //   //     const Expanded(child: Divider(height: 1)),
          //   //   ],
          //   // ),
          //   // child: Padding(
          //   //   padding: EdgeInsets.only(left: 15.w),
          //   //   child: Stack(
          //   //     alignment: Alignment.center,
          //   //     children: [
          //   //       SizedBox(height: 30.h),
          //   //       Positioned(
          //   //         left: 0,
          //   //         right: 0,
          //   //         top: 0,
          //   //         child: Container(
          //   //           height: .6.h,
          //   //           color: Colors.grey[400],
          //   //         ),
          //   //       ),
          //   //       Text(
          //   //         'Add New Contact',
          //   //         style: TextStyle(fontSize: 14.w, fontWeight: FontWeight.w700, color: Colors.grey[600]),
          //   //       ),
          //   //       Positioned(
          //   //         left: 0,
          //   //         right: 0,
          //   //         bottom: 0,
          //   //         child: Container(
          //   //           height: .6.h,
          //   //           color: Colors.grey[400],
          //   //         ),
          //   //       ),
          //   //     ],
          //   //   ),
          //   // ),
          //   child: Padding(
          //     padding: EdgeInsets.only(left: 15.w),
          //     child: Text(
          //       'Add New Contact',
          //       style: AppStyles.openSans.copyWith(fontSize: 13.w, fontWeight: FontWeight.w700, color: Colors.grey[600]),
          //     ),
          //   ),
          // ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Heading

                    // Form Fields

                    Padding(
                      padding: EdgeInsets.only(top: 7.h),
                      child: const Column(
                        children: [
                          NewContactField(heading: 'Contact Name', hint: 'Contact Person Full Name'),
                          NewContactField(heading: 'Contact Type', hint: 'Select Contact Type'), //dropdown
                          NewContactField(heading: 'Mobile Number', hint: 'eg: 9719864631313', textInputType: TextInputType.phone),
                          NewContactField(heading: 'Email Address', hint: 'eg: example@exm.com', textInputType: TextInputType.emailAddress),
                          NewContactField(heading: 'Contact Source', hint: 'Select Contact Source'), //dropdown
                          NewContactField(heading: 'Contact Destination', hint: 'eg: CEO'),
                          NewContactField(heading: 'Company Name', hint: 'eg: Arabinfotec Pvt Ltd'),
                          NewContactField(heading: 'Company Landline Number', hint: 'eg: 97163466578', textInputType: TextInputType.phone),
                          NewContactField(heading: 'Company Website', hint: 'eg: https://arabinfotechllc.com/', textInputType: TextInputType.url),
                          NewContactField(heading: 'Company Location', hint: 'Enter Location'),
                          NewContactField(heading: 'Company Address', hint: 'Enter Adress', isLargeField: true),
                          NewContactField(heading: 'Remarks if any', hint: '-- NOTE --', isLargeField: true),
                        ],
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Text('Reset', style: TextStyle(fontSize: 14.w, color: Colors.white)),
                        ),
                        SizedBox(width: 10.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Text('Submit', style: TextStyle(fontSize: 14.w, color: Colors.white)),
                        ),
                      ],
                    ),

                    SizedBox(height: 15.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NewContactField extends StatelessWidget {
  const NewContactField({
    // required this.controller,
    required this.heading,
    required this.hint,
    this.textInputType = TextInputType.name,
    this.isLargeField = false,
    super.key,
  });

  // final TextEditingController controller;
  final String heading;
  final String hint;
  final bool isLargeField;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(heading, style: TextStyle(fontSize: 12.w, color: Colors.purple)),
          // SizedBox(height: 7.h),
          SizedBox(
            height: isLargeField ? null : 50.h,
            child: TextFormField(
              // controller: controller,
              style: AppStyles.openSans.copyWith(
                color: Colors.purple,
                fontSize: 13.w,
              ),
              keyboardType: !isLargeField ? textInputType : TextInputType.multiline,
              minLines: !isLargeField ? null : 1,
              maxLines: !isLargeField ? null : 20,
              maxLength: !isLargeField ? null : 500,
              // expands: true,
              // maxLines: null,
              decoration: InputDecoration(
                // isDense: true,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: heading,
                labelStyle: TextStyle(fontSize: 12.w, color: Colors.purple),
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
