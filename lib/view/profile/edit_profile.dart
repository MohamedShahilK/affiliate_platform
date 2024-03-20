// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:affiliate_platform/view/common/sidebar.dart';
import 'package:affiliate_platform/view/manage_contact/new_contact.dart';
import 'package:flutter/material.dart';
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
                      const NewContactField(heading: 'First Name', hint: 'First Name'),
                      const NewContactField(heading: 'Last Name', hint: 'Last Name'),
                      const NewContactField(heading: 'Joining Date', hint: 'Joining Date'),
                      const NewContactField(heading: 'Phone Number', hint: 'Phone Number'),
                      const NewContactField(heading: 'Designation', hint: 'Designation'),
                      // const NewContactField(heading: 'Permanent Address', hint: 'Permanent Address'),
                      const NewContactLargeField(heading: 'Permanent Address', hint: 'Permanent Address'),
                      const NewContactLargeField(heading: 'Communication Address', hint: 'Communication Address'),
                      const NewContactLargeField(heading: 'Education / Qualification Information', hint: 'Education / Qualification Information'),
                      const NewContactLargeField(heading: 'Previous Experience Information', hint: 'Previous Experience Information'),
              
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
