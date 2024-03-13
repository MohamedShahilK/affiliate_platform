// ignore_for_file: lines_longer_than_80_chars, inference_failure_on_instance_creation

import 'package:affiliate_platform/config/ripple.dart';
import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:affiliate_platform/view/manage_contact/new_contact.dart';
import 'package:affiliate_platform/view/manage_contact/view_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ManageContactPage extends StatelessWidget {
  const ManageContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          const CustomHeader(),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(right: 15.w, top: 3.h, bottom: 3.h),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewContact(),
                    ),
                  );
                },
                child: Text(
                  'Create New Contact',
                  style: AppStyles.openSans.copyWith(fontSize: 10.w, fontWeight: FontWeight.w700, color: Colors.purple[800]),
                ),
              ),
            ),
          ),

          //
          //
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: const Column(
                  children: [
                    _ContactItem(),
                    _ContactItem(),
                    _ContactItem(),
                    _ContactItem(),
                    _ContactItem(),
                    _ContactItem(),
                    _ContactItem(),
                    _ContactItem(),
                    _ContactItem(),
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

class _ContactItem extends StatelessWidget {
  const _ContactItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 25.w),
        // margin: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          // border: Border.all(color:  Colors.grey[300]!),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 0.h),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Text(
                      //   'Name: ',
                      //   style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey[800], fontSize: 12.w),
                      // ),
                      Icon(Icons.person_2_outlined,size: 17.w),
                      SizedBox(width: 3.w),
                      Text(
                        'Mr. Lallit Potter',
                        style: TextStyle(color: Colors.grey[800], fontSize: 12.w),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      // Text(
                      //   'Company Name: ',
                      //   style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey[800], fontSize: 12.w),
                      // ),
                      Icon(Icons.business ,size: 17.w),
                      SizedBox(width: 3.w),
                      Text(
                        'R.K.I.F',
                        style: TextStyle(color: Colors.grey[800], fontSize: 12.w),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'User/Type: ',
                        style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey[800], fontSize: 12.w),
                      ),
                      Text(
                        'Giridhar',
                        style: TextStyle(color: Colors.grey[800], fontSize: 12.w),
                      ),
                      SizedBox(width: 2.w),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                        decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(15.r)),
                        child: Text('Qtn2015', style: TextStyle(fontSize: 10.w, color: Colors.white)),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    'Mar 12th 2024',
                    style: TextStyle(color: Colors.grey[800], fontSize: 12.w),
                  ),
                ],
              ),

              SizedBox(height: 10.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'info@sgtf.ae',
                    style: TextStyle(color: Colors.grey[800], fontSize: 12.w),
                  ),
                  const Spacer(),
                  Text(
                    '971522627165',
                    style: TextStyle(color: Colors.grey[800], fontSize: 12.w),
                  ),
                ],
              ),

              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: Colors.green[300],
                      borderRadius: BorderRadius.circular(15.r),
                      // shape: BoxShape.circle,
                    ),
                    child: Text(
                      'Follow Up',
                      style: AppStyles.openSans.copyWith(color: Colors.white, fontSize: 12.w),
                    ),
                  ),
                  // SizedBox(width: 5.w),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 7.h),
                    decoration: BoxDecoration(
                      color: Colors.blue[300],
                      // borderRadius: BorderRadius.only(topRight: Radius.circular(15.r), bottomLeft: Radius.circular(15.r)),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.remove_red_eye_outlined,
                      size: 18.w,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 7.h),
                    decoration: BoxDecoration(
                      color: Colors.red[300],
                      // borderRadius: BorderRadius.only(topRight: Radius.circular(15.r), bottomLeft: Radius.circular(15.r)),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.delete_outline_outlined,
                      size: 18.w,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              // SizedBox(height: 10.h),

              // const Spacer(),
              // Divider(indent: 15.w, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
