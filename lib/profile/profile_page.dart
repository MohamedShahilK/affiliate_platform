// ignore_for_file: cascade_invocations, lines_longer_than_80_chars

import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Key _refreshKey = UniqueKey();

  void _handleLocaleChanged() => setState(() {
        _refreshKey = UniqueKey();
      });

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      key: _refreshKey,
      haveFloatingButton: false,
      body: GestureDetector(
        onTap: _handleLocaleChanged,
        child: Column(
          children: [
            const CustomHeader(
              heading: 'Profile',
              isBackButtonNeeded: true,
              isTrailingButtonNeeded: true,
            ),

            //
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Column(
                        children: [
                          // DP
                          Stack(
                            children: [
                              Container(
                                height: 90.w,
                                width: 90.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  image: DecorationImage(image: AssetImage('assets/images/avatar.jpg')),
                                ),
                              ),
                              Positioned(
                                bottom: 0.h,
                                right: 5.w,
                                child: Container(
                                  width: 25.w,
                                  height: 25.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    border: Border.all(color: Colors.green[400]!),
                                  ),
                                  child: Icon(Icons.edit, color: Colors.green[900], size: 15.w),
                                ),
                              ),
                            ],
                          ),
                          // DP

                          // const Spacer(),

                          SizedBox(height: 15.h),

                          // Top Section
                          Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SelectableText(
                                'Mohamed Shahil (VST-113)',
                                textAlign: TextAlign.center,
                                style: AppStyles.poppins.copyWith(fontSize: 18.w, color: Colors.grey[800], fontWeight: FontWeight.w800),
                              ),
                              SelectableText(
                                'Mobile App Developer',
                                textAlign: TextAlign.justify,
                                style: AppStyles.poppins.copyWith(fontSize: 14.w, color: Colors.grey[800]),
                              ),
                              SizedBox(height: 5.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.date_range, size: 18.w),
                                        SizedBox(width: 5.w),
                                        SelectableText(
                                          '01/06/2023',
                                          textAlign: TextAlign.justify,
                                          style: AppStyles.poppins.copyWith(fontSize: 14.w, color: Colors.grey[800]),
                                        ),
                                      ],
                                    ),
                                    // SizedBox(width: 5.h),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.phone_android_outlined, size: 18.w),
                                        SizedBox(width: 5.w),
                                        SelectableText(
                                          '+918925555742',
                                          textAlign: TextAlign.justify,
                                          style: AppStyles.poppins.copyWith(fontSize: 14.w, color: Colors.grey[800]),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // Top Section

                          SizedBox(height: 50.h),

                          // Below
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              child: const Column(
                                children: [
                                  _BottomSectionItem(icon: Icons.home_work_outlined, field: 'Permanent Address', value: 'Shree Revabhai Industrial Estate, CTM Sureliya Road, Amraiwadi'),
                                  _BottomSectionItem(
                                    icon: Icons.home_outlined,
                                    field: 'Communication Address',
                                    value: 'Grd Floor Sidhartha Chamber, Gokhale Road, Naupada , Opp. Gaodevi Mandir, Naupada',
                                  ),
                                  _BottomSectionItem(
                                    icon: Icons.school_outlined,
                                    field: 'Education / Qualification Information',
                                    value: "Master's in Computer Science, Stanford University, 2020. Specialization: Artificial Intelligence and Machine Learning",
                                  ),
                                  _BottomSectionItem(
                                    icon: Icons.business_center_outlined,
                                    field: 'Previous Experience Information',
                                    value: 'Software Engineer at Google, 5 years. Specialized in backend development and distributed systems architecture',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Below
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomSectionItem extends StatelessWidget {
  const _BottomSectionItem({required this.field, required this.value, required this.icon});

  final String field;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16.w),
              SizedBox(width: 5.w),
              SelectableText(
                field,
                textAlign: TextAlign.justify,
                style: AppStyles.poppins.copyWith(fontSize: 13.w, color: Colors.grey[800], fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: SelectableText(
              value,
              // textAlign: TextAlign.justify,
              style: AppStyles.poppins.copyWith(fontSize: 13.w, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }
}
