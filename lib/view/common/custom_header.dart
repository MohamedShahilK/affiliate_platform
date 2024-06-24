// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/config/ripple.dart';
import 'package:affiliate_platform/utils/constants/string_constants.dart';
import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/utils/internal_services/storage_services.dart';
import 'package:affiliate_platform/view/profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({
    this.isBackButtonNeeded = false,
    this.isTrailingButtonNeeded = false,
    this.heading = '',
    super.key,
  });

  final bool isBackButtonNeeded;
  final bool isTrailingButtonNeeded;
  final String heading;

  @override
  Widget build(BuildContext context) {
    return isBackButtonNeeded
        ? Container(
            margin: EdgeInsets.only(top: 10.h, bottom: 15.h),
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 11.w),
            child: Row(
              children: [
                const Icon(Icons.arrow_back_ios_new_rounded).ripple(context, () => Navigator.pop(context)),
                const Spacer(),
                Text(
                  heading,
                  style: AppStyles.openSans.copyWith(fontSize: 16.w, fontWeight: FontWeight.w700, color: Colors.grey[600]),
                ),
                if (!isTrailingButtonNeeded) SizedBox(width: 25.w),
                const Spacer(),
                if (isTrailingButtonNeeded)
                  const Icon(FontAwesomeIcons.userPen).ripple(context, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfile(),
                      ),
                    );
                  }),
              ],
            ),
          )
        : Container(
            //  margin: EdgeInsets.only(left: 10.w, right: 10.w),r
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              // border: Border.all(color: Colors.grey[50]!)
            ),
            child: Container(
              margin: EdgeInsets.only(top: 10.h, left: 4.w, right: 4.w, bottom: 15.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(-1, 0),
                    blurRadius: 6,
                    spreadRadius: -1,
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 11.w),
              child: Row(
                children: [
                  if (isBackButtonNeeded)
                    const Icon(Icons.arrow_back_ios_new_rounded).ripple(context, () => Navigator.pop(context))
                  else
                    Image.asset('assets/images/logo-dark.png', width: 90.w),

                  const Spacer(),

                  if (isBackButtonNeeded) ...[
                    // SizedBox(width: 15.w),
                    Text(
                      heading,
                      style: AppStyles.openSans.copyWith(fontSize: 16.w, fontWeight: FontWeight.w700, color: Colors.grey[600]),
                    ),
                  ],

                  const Spacer(),
                  if (!isBackButtonNeeded)
                    Builder(
                      builder: (context) {
                        final role =   StorageServices.to.getString(StorageServicesKeys.role);
                        final firstName =   StorageServices.to.getString(StorageServicesKeys.firstName);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Welcome, $firstName', style: AppStyles.openSans.copyWith(fontSize: 12.w, color: Colors.black)),
                            // Text('EMPLOYEE', style: AppStyles.openSans.copyWith(fontSize: 12.w, color: Colors.black)),
                            Text(role, style: AppStyles.openSans.copyWith(fontSize: 12.w, color: Colors.black)),
                          ],
                        );
                      },
                    ),
                  // Text('EMPLOYEE', style: TextStyle(fontSize: 12.w)),

                  if (!isBackButtonNeeded) SizedBox(width: 10.w),

                  Stack(
                    children: [
                      Container(
                        height: 40.w,
                        width: 40.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          image: DecorationImage(image: AssetImage('assets/images/avatar2.png')),
                        ),
                      ),
                      Positioned(
                        bottom: 5.w,
                        right: 0,
                        child: Container(
                          width: 10.w,
                          height: 10.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ).ripple(
                    borderRadius: BorderRadius.circular(30.r),
                    context,
                    () {
                      // menuVisibility.value = !menuVisibility.value;
                      // menuVisibility.notifyListeners();
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ],
              ),
            ),
          );
  }
}
