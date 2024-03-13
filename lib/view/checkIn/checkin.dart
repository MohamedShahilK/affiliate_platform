// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckInPage extends StatelessWidget {
  const CheckInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
                // child: _CustomExpansionTile(),

                // child: ListView.builder(
                //   itemCount: 10,
                //   shrinkWrap: true,
                //   // physics: const NeverScrollableScrollPhysics(),
                //   itemBuilder: (context, index) {
                //     return _CheckInItem();
                //   },
                // ),
                child: const Column(
                  children: [
                    // _CustomExpansionTile(),

                    _CheckInItem(),
                    _CheckInItem(),
                    _CheckInItem(),
                    _CheckInItem(),
                    _CheckInItem(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CheckInItem extends StatelessWidget {
  const _CheckInItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 25.w),
            // margin: EdgeInsets.symmetric(horizontal: 5.w),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              // border: Border.all(color:  Colors.grey[300]!),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 45.h),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CheckIn # 1',
                        style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey[800], fontSize: 12.w),
                      ),
                      const Spacer(),
                      Text(
                        '12-03-2024 09:54 AM',
                        style: TextStyle(color: Colors.grey[800], fontSize: 12.w),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shahil',
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
                        'Work From Home',
                        style: TextStyle(color: Colors.grey[800], fontSize: 12.w),
                      ),
                      const Spacer(),
                      Text(
                        'Projects : 1',
                        style: TextStyle(color: Colors.grey[800], fontSize: 12.w),
                      ),
                    ],
                  ),

                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
                        decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(15.r)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.subdirectory_arrow_right_sharp,
                              size: 14.w,
                              color: Colors.white,
                            ),
                            SizedBox(width: 4.w),
                            Text('CheckIn', style: TextStyle(fontSize: 13.w, color: Colors.white)),
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

          //
          Positioned(
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Icon(
                Icons.edit,
                size: 18.w,
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(topRight: Radius.circular(15.r), bottomLeft: Radius.circular(15.r)),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _CustomExpansionTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: ExpansionTile(
          trailing: Icon(Icons.abc, size: 0.w),
          // iconColor: Colors.grey[100],
          tilePadding: EdgeInsets.zero,
          collapsedIconColor: Colors.grey[100],
          title: SizedBox(
            height: 150.h,
            child: Padding(
              padding: EdgeInsets.only(top: 15.h),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15.w),
                        child: Text(
                          'CheckIn # 1',
                          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey[800], fontSize: 12.w),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '12-03-2024 09:54 AM',
                        style: TextStyle(color: Colors.grey[800], fontSize: 12.w),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15.w),
                        child: Text(
                          'Shahil',
                          style: TextStyle(color: Colors.grey[800], fontSize: 12.w),
                        ),
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
                      Padding(
                        padding: EdgeInsets.only(left: 15.w),
                        child: Text(
                          'Work From Home',
                          style: TextStyle(color: Colors.grey[800], fontSize: 12.w),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Projects : 1',
                        style: TextStyle(color: Colors.grey[800], fontSize: 12.w),
                      ),
                    ],
                  ),

                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
                        decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(15.r)),
                        child: Row(
                          children: [
                            Icon(Icons.subdirectory_arrow_right_sharp, size: 14.w),
                            SizedBox(width: 4.w),
                            Text('CheckIn', style: TextStyle(fontSize: 13.w, color: Colors.white)),
                          ],
                        ),
                      )
                    ],
                  ),

                  // const Spacer(),
                  // Divider(indent: 15.w, color: Colors.grey),
                ],
              ),
            ),
          ),
          children: [
            Container(height: 60),
          ],
        ),
      ),
    );
  }
}
