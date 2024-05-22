import 'package:affiliate_platform/view/common/custom_header.dart';
import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:affiliate_platform/view/common/sidebar.dart';
import 'package:flutter/material.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  var _refreshKey = UniqueKey();

  // To update or hot reload
  void _handleLocaleChanged() => setState(() {
        _refreshKey = UniqueKey();
      });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        Navigator.pop(context);
      },
      child: CustomScaffold(
        key: _refreshKey,
        // floatingActionButtonIcon: FontAwesomeIcons.userPen,
        // onTapFloatingButton: () {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => const EditProfile(),
        //     ),
        //   );
        // },
        body: SafeArea(
          child: GestureDetector(
            // onTap: _handleLocaleChanged,
            onTap: () {
              // _handleLocaleChanged();
              menuVisibility.value = false;
              menuVisibility.notifyListeners();
            },
            child: const Column(
              children: [
                // const CustomHeader(
                //   heading: 'Profile',
                //   isBackButtonNeeded: true,
                //   isTrailingButtonNeeded: true,
                // ),
          
                CustomHeader(),
          
                //
                // _body(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
