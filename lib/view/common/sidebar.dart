// ignore_for_file: lines_longer_than_80_chars, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, inference_failure_on_instance_creation

import 'package:affiliate_platform/config/ripple.dart';
import 'package:affiliate_platform/profile/edit_profile.dart';
import 'package:affiliate_platform/profile/profile_page.dart';
import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/view/checkIn/checkin.dart';
import 'package:affiliate_platform/view/checkout/checkin.dart';
import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:affiliate_platform/view/manage_contact/manage_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    final pages = [const ManageContactPage(), const ProfilePage()];
    return CustomScaffold(     
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

                  IndexedStack(children: pages,index: currentIndex,),

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
                                  selectedItemDecoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  itemTextPadding: EdgeInsets.only(left: 5.w),
                                  selectedItemTextPadding: EdgeInsets.only(left: 5.w),
                                  selectedIconTheme: IconThemeData(color: const Color(0xFF2c343b), size: 18.w),
                                  iconTheme: IconThemeData(color: Colors.white, size: 18.w),
                                  selectedTextStyle: const TextStyle(color: Color(0xFF2c343b)),
                                  textStyle: const TextStyle(color: Colors.white),
                                  margin: EdgeInsets.only(top: 10.h),
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  decoration: BoxDecoration(
                                    // border: Border.all(),
                                    // borderRadius: BorderRadius.circular(20.r),
                                    // color: const Color(0xFF2c343b),
                                    color: const Color(0xFF2c343b),
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(25.r), topRight: Radius.circular(25.r)),
                                  ),
                                  width: 50.w,
                                ),
                                extendedTheme: SidebarXTheme(
                                  itemTextPadding: EdgeInsets.only(left: 5.w),
                                  selectedItemTextPadding: EdgeInsets.only(left: 5.w),
                                  selectedIconTheme: IconThemeData(color: const Color(0xFF2c343b), size: 18.w),
                                  iconTheme: IconThemeData(color: Colors.white, size: 18.w),
                                  selectedTextStyle: const TextStyle(color: Color(0xFF2c343b)),
                                  textStyle: const TextStyle(color: Colors.white),
                                  // width: 120.w,
                                  width: MediaQuery.of(context).size.width * (3 / 5),
                                  margin: EdgeInsets.only(top: 10.h),
                                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 3.w),
                                  decoration: BoxDecoration(
                                    // border: Border.all(),
                                    // color: const Color(0xFF2c343b),
                                    color: const Color(0xFF2c343b),
                                    // borderRadius: BorderRadius.circular(20.r),
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
                                controller: SidebarXController(selectedIndex: currentSideBarIndex.value, extended: true),
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
                                    icon: Icons.person,
                                    label: 'Profile',
                                    onTap: () {
                                      currentSideBarIndex.value = 1;
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Welcome, Mohamed', style: AppStyles.openSans.copyWith(fontSize: 12.w, color: Colors.black)),
                        Text('EMPLOYEE', style: AppStyles.openSans.copyWith(fontSize: 12.w, color: Colors.black)),
                      ],
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
                  ).ripple(
                    borderRadius: BorderRadius.circular(30.r),
                    context,
                    () {
                      menuVisibility.value = !menuVisibility.value;
                      menuVisibility.notifyListeners();
                    },
                  ),
                ],
              ),
            ),
          );
  }
}
