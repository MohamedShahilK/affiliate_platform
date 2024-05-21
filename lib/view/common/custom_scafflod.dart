// ignore_for_file: lines_longer_than_80_chars, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, inference_failure_on_instance_creation

import 'package:affiliate_platform/config/ripple.dart';
import 'package:affiliate_platform/view/common/side_menu.dart';
import 'package:affiliate_platform/view/profile/profile_page.dart';
import 'package:affiliate_platform/view/manage_contact/manage_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomScaffold extends StatefulWidget {
  const CustomScaffold({required this.body,  this.floatingActionButtonIcon, this.onTapFloatingButton, this.haveFloatingButton = true, this.floatingActionButtonColor, super.key});

  final Widget body;
  final VoidCallback? onTapFloatingButton;
  final bool haveFloatingButton;
  final Color? floatingActionButtonColor;
  final IconData? floatingActionButtonIcon;

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    final pages = [const ManageContactPage(), const ProfilePage()];
    return Scaffold(
      drawer: SideMenu(),
      resizeToAvoidBottomInset: false,
      floatingActionButton: !widget.haveFloatingButton
          ? null
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.w),
              decoration: BoxDecoration(color: widget.floatingActionButtonColor ?? Colors.purple[900], shape: BoxShape.circle),
              child: Icon(widget.floatingActionButtonIcon ?? Icons.add, color: Colors.white, size: 22.w),
            ).ripple(context, () {
              if (widget.haveFloatingButton && widget.onTapFloatingButton != null) {
                widget.onTapFloatingButton!();
              }
            }),
      backgroundColor: Colors.white,
      body: widget.body,
    );
  }
}
