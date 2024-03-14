import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewContact extends StatelessWidget {
  const ViewContact({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      onTapFloatingButton: () {},
      body: Column(
        children: [
          const CustomHeader(isBackButtonNeeded: true, heading: 'Contact Details'),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
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
