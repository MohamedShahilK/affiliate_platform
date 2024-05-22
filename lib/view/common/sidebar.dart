// ignore_for_file: lines_longer_than_80_chars, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, inference_failure_on_instance_creation

import 'package:affiliate_platform/config/ripple.dart';
import 'package:affiliate_platform/services/auth/auth_services.dart';
import 'package:affiliate_platform/view/auth/login_page.dart';
import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:affiliate_platform/view/employee/attendance/attendance.dart';
import 'package:affiliate_platform/view/manage_contact/manage_contact.dart';
import 'package:affiliate_platform/view/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidebarx/sidebarx.dart';

final menuVisibility = ValueNotifier<bool>(false);
final currentSideBarIndex = ValueNotifier<int>(0);

class SideBar extends StatefulWidget {
  const SideBar({this.onTapFloatingButton, this.haveFloatingButton = true, super.key});

  // final Widget body;
  final VoidCallback? onTapFloatingButton;
  final bool haveFloatingButton;

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    final pages = [
      const ManageContactPage(),
      const AttendancePage(),
      const ProfilePage(),
    ];
    return CustomScaffold(
      haveFloatingButton: false,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            menuVisibility.value = false;
            menuVisibility.notifyListeners();
          },
          child: ValueListenableBuilder(
            valueListenable: currentSideBarIndex,
            builder: (context, currentIndex, _) {
              return Stack(
                children: [
                  // Expanded(
                  //   child: Column(
                  //     children: [
                  //       // const CustomHeader(),

                  //       //
                  //       //
                  //       widget.body,
                  //     ],
                  //   ),
                  // ),
                  // widget.body,

                  IndexedStack(
                    index: currentIndex,
                    children: pages,
                  ),

                  Container(
                    // width: 60.w,
                    child: ValueListenableBuilder(
                      valueListenable: currentSideBarIndex,
                      builder: (context, currentIndex, _) {
                        return ValueListenableBuilder(
                          valueListenable: menuVisibility,
                          builder: (context, visi, _) {
                            return Visibility(
                              visible: menuVisibility.value,
                              child: SidebarX(
                                // showToggleButton: false,
                                // footerItems: [
                                //   SidebarXItem(
                                //     iconWidget: Container(
                                //       height: 25.w,
                                //       width: 25.w,
                                //       decoration: const BoxDecoration(
                                //         color: Colors.white,
                                //         shape: BoxShape.circle,

                                //       ),
                                //       child: Icon(
                                //         Icons.close,
                                //         color: Colors.black,
                                //         size: 12.w,
                                //       ),
                                //     ),
                                //     // icon: Icons.home,
                                //     // label: 'Home',
                                //     onTap: () {
                                //       menuVisibility.value = false;
                                //       menuVisibility.notifyListeners();
                                //     },
                                //   ),
                                // ],

                                // footerDivider: Container(
                                //   height: 25.w,
                                //   width: 25.w,
                                //   decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                //   child: Icon(Icons.close, color: Colors.black,size: 12.w,),
                                // ),
                                animationDuration: Duration.zero,
                                theme: SidebarXTheme(
                                  // selectedItemDecoration: BoxDecoration(
                                  //   color: Colors.white,
                                  //   borderRadius: BorderRadius.circular(20.r),
                                  // ),
                                  selectedItemDecoration: BoxDecoration(
                                    // color: const Color.fromARGB(255, 75, 2, 93),
                                    color: const Color.fromARGB(220, 75, 2, 93),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  itemDecoration: BoxDecoration(
                                    border: Border.all(color: const Color.fromARGB(30, 44, 52, 59)),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  itemTextPadding: EdgeInsets.only(left: 5.w),
                                  selectedItemTextPadding: EdgeInsets.only(left: 5.w),
                                  selectedIconTheme: IconThemeData(color: Colors.white, size: 18.w),
                                  iconTheme: IconThemeData(color: Colors.black, size: 18.w),
                                  selectedTextStyle: const TextStyle(color: Colors.black),
                                  textStyle: const TextStyle(color: Colors.black),
                                  margin: EdgeInsets.only(top: 10.h),
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  decoration: BoxDecoration(
                                    // color: const Color(0xFF2c343b),
                                    color: Colors.white,
                                    border: Border.all(color: const Color.fromARGB(30, 44, 52, 59)),
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(25.r), topRight: Radius.circular(25.r)),
                                  ),
                                  width: 50.w,
                                ),
                                extendedTheme: SidebarXTheme(
                                  selectedItemDecoration: BoxDecoration(
                                    // color: const Color.fromARGB(255, 75, 2, 93),
                                    color: const Color.fromARGB(220, 75, 2, 93),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  itemDecoration: BoxDecoration(
                                    border: Border.all(color: const Color.fromARGB(30, 44, 52, 59)),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  itemTextPadding: EdgeInsets.only(left: 5.w),
                                  selectedItemTextPadding: EdgeInsets.only(left: 5.w),
                                  selectedIconTheme: IconThemeData(color: Colors.white, size: 18.w),
                                  iconTheme: IconThemeData(color: Colors.black, size: 18.w),
                                  selectedTextStyle: const TextStyle(color: Colors.white),
                                  textStyle: const TextStyle(color: Colors.black),
                                  // width: 120.w,
                                  width: MediaQuery.of(context).size.width * (3 / 5),
                                  margin: EdgeInsets.only(top: 10.h),
                                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 3.w),
                                  decoration: BoxDecoration(
                                    // color: const Color(0xFF2c343b),
                                    color: Colors.white,
                                    border: Border.all(color: const Color.fromARGB(30, 44, 52, 59)),
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(25.r), topRight: Radius.circular(25.r)),
                                  ),
                                ),
                                headerBuilder: (context, extended) {
                                  return extended
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 25),
                                          child: Image.asset(
                                            'assets/images/logo-dark.png',
                                            width: 130.w,
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 25),
                                          child: Image.asset(
                                            'assets/images/logo.png',
                                            width: 30.w,
                                          ),
                                        );
                                },
                                footerBuilder: (context, extended) => Align(
                                  alignment: extended ? Alignment.topRight : Alignment.center,
                                  child: Padding(
                                    padding: extended ? EdgeInsets.symmetric(horizontal: 8.w) : EdgeInsets.zero,
                                    child: Container(
                                      // width: double.infinity,
                                      padding: EdgeInsets.symmetric(vertical: extended ? 8.h : 3.h, horizontal: extended ? 11.w : 4.w),
                                      // margin: extended ? EdgeInsets.symmetric(horizontal: 8.w) : null,
                                      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(11.r)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if (extended) Text('Logout', style: TextStyle(fontSize: 14.w, color: Colors.white, fontWeight: FontWeight.w700)),
                                          if (extended) SizedBox(width: 6.w),
                                          Icon(
                                            Icons.power_settings_new_sharp,
                                            size: 22.w,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ).ripple(context, () async {
                                      await AuthServices().logout();

                                      await Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const LoginPage(),
                                        ),
                                      );

                                      currentSideBarIndex.value = 0;
                                      currentSideBarIndex.notifyListeners();
                                    }),
                                  ),
                                ),

                                controller: SidebarXController(selectedIndex: currentSideBarIndex.value, extended: true),
                                // controller: SidebarXController(selectedIndex: currentSideBarIndex.value),
                                items: [
                                  // SidebarXItem(
                                  //   icon: Icons.home,
                                  //   label: 'Home',
                                  //   onTap: () {
                                  //     currentSideBarIndex.value = 0;
                                  //     currentSideBarIndex.notifyListeners();

                                  //     menuVisibility.value = false;
                                  //     menuVisibility.notifyListeners();

                                  //     Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //         builder: (context) => const ManageContactPage(),
                                  //       ),
                                  //     );
                                  //   },
                                  // ),
                                  // SidebarXItem(
                                  //   icon: Icons.subdirectory_arrow_right_sharp,
                                  //   label: 'Check In',
                                  //   onTap: () {
                                  //     currentSideBarIndex.value = 1;
                                  //     currentSideBarIndex.notifyListeners();

                                  //     menuVisibility.value = false;
                                  //     menuVisibility.notifyListeners();

                                  //     Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //         builder: (context) => const CheckInPage(),
                                  //       ),
                                  //     );
                                  //   },
                                  // ),
                                  // SidebarXItem(
                                  //   icon: Icons.subdirectory_arrow_left_rounded,
                                  //   label: 'Check Out',
                                  //   onTap: () {
                                  //     currentSideBarIndex.value = 2;
                                  //     currentSideBarIndex.notifyListeners();

                                  //     menuVisibility.value = false;
                                  //     menuVisibility.notifyListeners();

                                  //     Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //         builder: (context) => const CheckOutPage(),
                                  //       ),
                                  //     );
                                  //   },
                                  // ),
                                  SidebarXItem(
                                    icon: Icons.account_box_outlined,
                                    label: 'Manage Contact',
                                    onTap: () {
                                      currentSideBarIndex.value = 0;
                                      currentSideBarIndex.notifyListeners();

                                      menuVisibility.value = false;
                                      menuVisibility.notifyListeners();

                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => const ManageContactPage(),
                                      //   ),
                                      // );
                                    },
                                  ),

                                  SidebarXItem(
                                    icon: Icons.account_box_outlined,
                                    label: 'Employee',
                                    onTap: () {
                                      currentSideBarIndex.value = 1;
                                      currentSideBarIndex.notifyListeners();

                                      menuVisibility.value = false;
                                      menuVisibility.notifyListeners();

                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => const ManageContactPage(),
                                      //   ),
                                      // );
                                    },
                                  ),
                                  SidebarXItem(
                                    icon: Icons.person,
                                    label: 'Profile',
                                    onTap: () {
                                      currentSideBarIndex.value = 2;
                                      currentSideBarIndex.notifyListeners();

                                      menuVisibility.value = false;
                                      menuVisibility.notifyListeners();

                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => const ProfilePage(),
                                      //   ),
                                      // );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

