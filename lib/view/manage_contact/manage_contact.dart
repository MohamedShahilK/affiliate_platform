// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/config/ripple.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sidebarx/sidebarx.dart';

final menuVisibility = ValueNotifier<bool>(true);

class ManageContact extends StatefulWidget {
  const ManageContact({super.key});

  @override
  State<ManageContact> createState() => _ManageContactState();
}

class _ManageContactState extends State<ManageContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const Expanded(
              child: Column(
                children: [                  
                  CustomHeader(),
                ],
              ),
            ),
            Container(
              // width: 60.w,
              child: ValueListenableBuilder(
                valueListenable: menuVisibility,
                builder: (context, visi, _) {
                  return Visibility(
                    visible: menuVisibility.value,
                    child: SidebarX(
                      // showToggleButton: false,
                      footerItems: [
                        SidebarXItem(
                          iconWidget: Container(
                            height: 25.w,
                            width: 25.w,
                            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                            child: Icon(
                              Icons.close,
                              color: Colors.black,
                              size: 12.w,
                            ),
                          ),
                          // icon: Icons.home,
                          // label: 'Home',
                          onTap: () {
                            menuVisibility.value = false;
                            menuVisibility.notifyListeners();
                          },
                        ),
                      ],

                      // footerDivider: Container(
                      //   height: 25.w,
                      //   width: 25.w,
                      //   decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      //   child: Icon(Icons.close, color: Colors.black,size: 12.w,),
                      // ),
                      theme: SidebarXTheme(
                        itemTextPadding: EdgeInsets.only(left: 5.w),
                        selectedItemTextPadding: EdgeInsets.only(left: 5.w),
                        selectedIconTheme: IconThemeData(color: Colors.white, size: 18.w),
                        iconTheme: IconThemeData(color: Colors.white, size: 18.w),
                        selectedTextStyle: const TextStyle(color: Colors.white),
                        textStyle: const TextStyle(color: Colors.white),
                        // margin: EdgeInsets.symmetric(vertical: 30.h, horizontal: 6.w),
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        decoration: const BoxDecoration(
                          // border: Border.all(),
                          color: Color(0xFF2c343b),
                          // borderRadius: BorderRadius.circular(20.r),
                        ),
                        width: 50.w,
                      ),
                      extendedTheme: SidebarXTheme(
                        itemTextPadding: EdgeInsets.only(left: 5.w),
                        selectedItemTextPadding: EdgeInsets.only(left: 5.w),
                        selectedIconTheme: IconThemeData(color: Colors.white, size: 18.w),
                        iconTheme: IconThemeData(color: Colors.white, size: 18.w),
                        selectedTextStyle: const TextStyle(color: Colors.white),
                        textStyle: const TextStyle(color: Colors.white),
                        width: 120.w,
                        // margin: EdgeInsets.symmetric(vertical: 30.h, horizontal: 6.w),
                        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 3.w),
                        decoration: const BoxDecoration(
                          // border: Border.all(),
                          color: Color(0xFF2c343b),
                          // borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                      headerBuilder: (context, extended) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.w),
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 30.w,
                          ),
                        );
                      },
                      controller: SidebarXController(selectedIndex: 0),
                      items: [
                        SidebarXItem(
                          icon: Icons.home,
                          label: 'Home',
                          onTap: () {
                            menuVisibility.value = false;
                            menuVisibility.notifyListeners();
                          },
                        ),
                        SidebarXItem(
                          icon: Icons.search,
                          label: 'Search',
                          onTap: () {
                            menuVisibility.value = false;
                            menuVisibility.notifyListeners();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomHeader extends StatelessWidget {
  const CustomHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 11.w),
      child: Row(
        children: [
          SvgPicture.asset('assets/icons/menu.svg', width: 20.w).ripple(
            context,
            () {
              menuVisibility.value = !menuVisibility.value;
              menuVisibility.notifyListeners();
            },
          ),

          SizedBox(width: 10.w),

          Text('Welcome, Mohamed', style: TextStyle(fontSize: 12.w)),
          // Text('EMPLOYEE', style: TextStyle(fontSize: 12.w)),

          const Spacer(),

          Stack(
            children: [
              Container(
                height: 40.w,
                width: 40.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(image: AssetImage('assets/images/avatar.jpg')),
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
          ),
        ],
      ),
    );
  }
}
