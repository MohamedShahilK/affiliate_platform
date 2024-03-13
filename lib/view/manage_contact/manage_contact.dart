// ignore_for_file: lines_longer_than_80_chars, inference_failure_on_instance_creation

import 'package:affiliate_platform/config/ripple.dart';
import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:affiliate_platform/view/manage_contact/new_contact.dart';
import 'package:affiliate_platform/view/manage_contact/view_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                  Text(
                    'Contact # 1',
                    style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey[800], fontSize: 12.w),
                  ),
                  const Spacer(),
                  Text(
                    'Mar 12th, 2024',
                    style: TextStyle(color: Colors.grey[800], fontSize: 12.w),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Giridhar',
                    style: TextStyle(color: Colors.grey[800], fontSize: 12.w),
                  ),
                  const Spacer(),
                  Text(
                    '08:30:00',
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
      
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
                    decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(15.r)),
                    child: Row(
                      children: [
                        // Icon(
                        //   Icons.subdirectory_arrow_right_sharp,
                        //   size: 14.w,
                        //   color: Colors.white,
                        // ),
                        // SizedBox(width: 4.w),
                        Text('Qtn2015', style: TextStyle(fontSize: 13.w, color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
      
              SizedBox(height: 10.h),
      
              // const Spacer(),
              // Divider(indent: 15.w, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
