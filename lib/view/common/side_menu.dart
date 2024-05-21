// ignore_for_file: lines_longer_than_80_chars, cascade_invocations, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:affiliate_platform/config/ripple.dart';
import 'package:affiliate_platform/controllers/sidemenu_controller.dart';
import 'package:affiliate_platform/view/employee/attendance.dart';
import 'package:affiliate_platform/view/manage_contact/manage_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final menu = Provider.of<SideMenuController>(context, listen: false);
    return SizedBox(
      width: 220,
      child: Drawer(
        backgroundColor: Colors.grey[200],
        child: LayoutBuilder(
          builder: (context, constraint) {
            return SingleChildScrollView(
              // it enables scrolling
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 35),
                        // child: Image.asset("assets/images/new_logo-removebg-preview.png", width: 250),
                        child: Image.asset(
                          'assets/images/logo-dark.png',
                          width: 200,
                          height: 50,
                        ),
                      ),
                      DrawerListTile(
                        title: 'Manage Contact',
                        icon: Icons.account_box_outlined,
                        svgHeight: 17,
                        press: () {
                          menu.setMyMenu('Manage Contact');
                          menu.setmyMenuExpand('');
                          _handlePageNavigation(context, route: const ManageContactPage());
                        },
                      ),
                      // DrawerListTile(
                      //   title: 'Customer',
                      //   icon: Icons.account_box_outlined,
                      //   svgHeight: 17,
                      //   press: () {
                      //     menu.setMyMenu('Customer');
                      //     menu.setmyMenuExpand('');
                      //     _handlePageNavigation(context, '/dashboard');
                      //   },
                      // ),
                      Container(
                        // margin: EdgeInsets.symmetric(),
                        // padding: const EdgeInsets.only(top: 5),
                        // margin: EdgeInsets.symmetric(horizontal: 10),

                        // decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!)),
                        child: ExpansionDrawerListTile(
                          title: 'Employee',
                          icon: Icons.person,
                          svgHeight: 18,
                          press: () {
                            menu.setmyMenuExpand('Employee');
                            print('1231231213 ${menu.myMenuExpand}');
                            // _handlePageNavigation(context, '/');
                          },
                          children: [
                            Column(
                              children: [
                                DrawerListTile(
                                  title: 'Attendance',
                                  icon: Icons.accessible_sharp,
                                  removeBorder : true,                                  
                                  svgHeight: 15,
                                  textFont: 13,
                                  press: () {
                                    menu.setMyMenu('Attendance');
                                    menu.setmyMenuExpand('Employee');
                                    _handlePageNavigation(context, route: const AttendancePage());
                                  },
                                ),
                                DrawerListTile(
                                  title: 'Project',
                                  icon: Icons.accessible_sharp,
                                  removeBorder : true,
                                  svgHeight: 15,
                                  textFont: 13,
                                  press: () {
                                    menu.setMyMenu('Project');
                                    menu.setmyMenuExpand('Employee');
                                    // _handlePageNavigation(context, '/masterreport');
                                  },
                                ),
                                DrawerListTile(
                                  title: 'Check In',
                                  icon: Icons.accessible_sharp,
                                  removeBorder : true,
                                  svgHeight: 15,
                                  textFont: 13,
                                  press: () {
                                    menu.setMyMenu('Check In');
                                    menu.setmyMenuExpand('Employee');
                                    // _handlePageNavigation(context, '/masterreport');
                                  },
                                ),
                                DrawerListTile(
                                  title: 'Break',
                                  icon: Icons.accessible_sharp,
                                  removeBorder : true,
                                  svgHeight: 15,
                                  textFont: 13,
                                  press: () {
                                    menu.setMyMenu('Break');
                                    menu.setmyMenuExpand('Employee');
                                    // _handlePageNavigation(context, '/masterreport');
                                  },
                                ),
                                DrawerListTile(
                                  title: 'Check Out',
                                  icon: Icons.accessible_sharp,
                                  removeBorder : true,
                                  svgHeight: 15,
                                  textFont: 13,
                                  press: () {
                                    menu.setMyMenu('Check Out');
                                    menu.setmyMenuExpand('Employee');
                                    // _handlePageNavigation(context, '/masterreport');
                                  },
                                ),
                                DrawerListTile(
                                  title: 'Leave Request',
                                  icon: Icons.accessible_sharp,
                                  removeBorder : true,
                                  svgHeight: 15,
                                  textFont: 13,
                                  press: () {
                                    menu.setMyMenu('Leave Request');
                                    menu.setmyMenuExpand('Employee');
                                    // _handlePageNavigation(context, '/masterreport');
                                  },
                                ),
                                DrawerListTile(
                                  title: 'My Profile',
                                  icon: Icons.accessible_sharp,
                                  removeBorder : true,
                                  svgHeight: 15,
                                  textFont: 13,
                                  press: () {
                                    menu.setMyMenu('My Profile');
                                    menu.setmyMenuExpand('Employee');
                                    // _handlePageNavigation(context, '/masterreport');
                                  },
                                ),
                                DrawerListTile(
                                  title: 'Settings',
                                  icon: Icons.accessible_sharp,
                                  removeBorder : true,
                                  svgHeight: 15,
                                  textFont: 13,
                                  press: () {
                                    menu.setMyMenu('Settings');
                                    menu.setmyMenuExpand('Employee');
                                    // _handlePageNavigation(context, '/masterreport');
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      DrawerListTile(
                        noTopPadding: true,
                        title: 'LogOut',
                        svgHeight: 17,
                        svgSrc: 'assets/icons/logout2.svg',
                        press: () async {},
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _handlePageNavigation(BuildContext context, {required Widget route}) async {
    // ignore: inference_failure_on_instance_creation
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => route));

    // await Navigator.of(context).pushNamed(route);
    // await Navigator.of(context).push(
    //   PageRouteBuilder(
    //     settings: RouteSettings(name: '/'),
    //     pageBuilder: (context, animation, _) => DashboardScreen(),
    //     transitionsBuilder: (context, animation, _, child) {
    //       const begin = Offset(0.0, 1.0);
    //       const end = Offset.zero;
    //       const curve = Curves.ease;

    //       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    //       return SlideTransition(
    //         position: animation.drive(tween),
    //         child: child,
    //       );
    //     },
    //   ),
    // );
  }

  // void openInWindow(String uri, String name) {
  //   html.window.open(uri, name);
  // }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.title,
    required this.press,
    this.noTopPadding = false,
    this.removeBorder = false,
    this.textFont,
    this.pngSrc,
    this.svgSrc,
    this.icon,
    this.svgHeight,
  });
  final String title;
  final double? textFont;
  final String? svgSrc;
  final String? pngSrc;
  final IconData? icon;
  final double? svgHeight;
  final VoidCallback press;
  final bool noTopPadding;
  final bool removeBorder;

  @override
  Widget build(BuildContext context) {
    final menu = Provider.of<SideMenuController>(context);
    final isSelected = menu.myMenu == title;
    // return Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 5.w),
    //   child: ListTile(
    //     tileColor: isSelected ? const Color.fromARGB(220, 75, 2, 93) : Colors.transparent,
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
    //     contentPadding: EdgeInsets.zero,
    //     dense: true,
    //     hoverColor: Colors.purple[100],
    //     onTap: press,
    //     // horizontalTitleGap: 12.0,
    //     leading: pngSrc == null
    //         ? icon == null
    //             ? SvgPicture.asset(
    //                 svgSrc!,
    //                 // color: Colors.white54,
    //                 colorFilter: ColorFilter.mode(
    //                   // isSelected ? primaryColor : Colors.black87,
    //                   isSelected ? Colors.white : Colors.black87,
    //                   BlendMode.srcIn,
    //                 ),
    //                 height: svgHeight ?? 20,
    //               )
    //             : Icon(icon, size: svgHeight ?? 13, color: isSelected ? Colors.white : Colors.black87)
    //         : Image.asset(pngSrc!, height: svgHeight ?? 13),
    //     title: Text(
    //       title,
    //       style: TextStyle(
    //         // color: isSelected ? primaryColor : Colors.black87,
    //         color: isSelected ? Colors.white : Colors.black87,
    //         fontSize: 13,
    //       ),
    //     ),
    //   ),
    // );
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: noTopPadding ? 0 : 15.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color.fromARGB(220, 75, 2, 93) : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color:removeBorder ?Colors.transparent :Colors.grey[300]!),
        ),
        child: Row(
          children: [
            if (pngSrc == null)
              icon == null
                  ? SvgPicture.asset(
                      svgSrc!,
                      // color: Colors.white54,
                      colorFilter: ColorFilter.mode(
                        // isSelected ? primaryColor : Colors.black87,
                        isSelected ? Colors.white : Colors.black87,
                        BlendMode.srcIn,
                      ),
                      height: svgHeight ?? 20,
                    )
                  : Icon(icon, size: svgHeight ?? 13, color: isSelected ? Colors.white : Colors.black87)
            else
              Image.asset(pngSrc!, height: svgHeight ?? 13),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                // color: isSelected ? primaryColor : Colors.black87,
                color: isSelected ? Colors.white : Colors.black87,
                fontSize: textFont ?? 15,
              ),
            ),
          ],
        ),
      ).ripple(context, overlayColor: Colors.transparent, press),
    );
  }
}

class ExpansionDrawerListTile extends StatelessWidget {
  ExpansionDrawerListTile({
    required this.title,
    required this.children,
    required this.press,
    this.svgSrc,
    this.svgHeight,
    this.pngSrc,
    this.icon,
    super.key,
  });
  final String title;
  final String? svgSrc;
  final double? svgHeight;
  final VoidCallback press;
  final List<Widget> children;
  final String? pngSrc;
  final IconData? icon;

  final isExpanded = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final menu = Provider.of<SideMenuController>(context);
    final isSelected = menu.myMenuExpand == title && menu.myMenuExpand != '';
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        // iconTheme: IconThemeData(color: Colors.red)
      ),
      // child: Container(
      //   decoration: BoxDecoration(border: Border.all()),
      //   child: ExpansionTile(
      //     tilePadding: EdgeInsets.zero,
      //     childrenPadding: EdgeInsets.zero,
      //     onExpansionChanged: (expa) => press(),
      //     trailing: const SizedBox.shrink(),
      //     initiallyExpanded: isSelected,
      //     // shape: RoundedRectangleBorder(side: BorderSide(color: Colors.red)),
      //     // onTap: press,
      //     // horizontalTitleGap: 12.0,
      //     leading: Padding(
      //       padding: EdgeInsets.only(left: 20.w),
      //       child: pngSrc == null
      //           ? icon == null
      //               ? SvgPicture.asset(
      //                   svgSrc!,
      //                   // color: Colors.white54,
      //                   colorFilter: const ColorFilter.mode(Colors.black87, BlendMode.srcIn),
      //                   height: svgHeight ?? 20,
      //                 )
      //               : Icon(icon, size: svgHeight ?? 13, color: Colors.black87)
      //           : Image.asset(pngSrc!, height: svgHeight ?? 13),
      //     ),
      //     title: Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 0.w),
      //       child: Text(
      //         title,
      //         style: TextStyle(color: isSelected ? Colors.purple : Colors.black87, fontSize: 15),
      //       ),
      //     ),
      //     children: children,
      //   ),
      // ),

      child: ValueListenableBuilder(
        valueListenable: isExpanded,
        builder: (context, expand, _) {
          return Container(
            padding: const EdgeInsets.only(top: 5),
            margin: EdgeInsets.symmetric(horizontal: isExpanded.value ? 10 : 0),
            decoration: BoxDecoration(border: isExpanded.value ? Border.all(color: Colors.grey[300]!) : null, borderRadius: BorderRadius.circular(15)),
            child: CustomExpansionTile(
              isExpanded: isExpanded,
              header: Container(
                // padding: const EdgeInsets.all(16),
                margin: EdgeInsets.only(bottom: 10.h),
                padding: EdgeInsets.symmetric(horizontal: isExpanded.value ? 0 : 10.w, vertical: 10.h),
                // padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  // color: isSelected ? const Color.fromARGB(220, 75, 2, 93) : Colors.transparent,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: isExpanded.value ? Colors.transparent : Colors.grey[300]!),
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (pngSrc == null)
                      icon == null
                          ? SvgPicture.asset(
                              svgSrc!,
                              // color: Colors.white54,
                              colorFilter: const ColorFilter.mode(Colors.black87, BlendMode.srcIn),
                              height: svgHeight ?? 20,
                            )
                          : Icon(icon, size: svgHeight ?? 13, color: Colors.black87)
                    else
                      Image.asset(pngSrc!, height: svgHeight ?? 13),
                    const SizedBox(width: 10),
                    const Text(
                      'Employee',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    // Icon(
                    //   Icons.expand_more,
                    //   color: Colors.black,
                    // ),
                  ],
                ),
              ),
              content: Column(
                children: children,
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile({super.key, required this.header, required this.content, required this.isExpanded});
  final Widget header;
  final Widget content;
  final ValueNotifier<bool> isExpanded;

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  // bool _isExpanded = false;

  void _toggleExpand() {
    // setState(() {
    //   _isExpanded = !_isExpanded;
    // });
    widget.isExpanded.value = !widget.isExpanded.value;
    widget.isExpanded.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          GestureDetector(
            onTap: _toggleExpand,
            child: widget.header,
          ),
          if (widget.isExpanded.value) widget.content else const SizedBox.shrink(),
        ],
      ),
    );
  }
}
