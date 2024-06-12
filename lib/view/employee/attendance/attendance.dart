// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/view/common/custom_header.dart';
import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:affiliate_platform/view/common/sidebar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            child: Column(
              children: [
                // const CustomHeader(
                //   heading: 'Profile',
                //   isBackButtonNeeded: true,
                //   isTrailingButtonNeeded: true,
                // ),

                const CustomHeader(),

                //

                SizedBox(height: 10.h),
                // _body(),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    border: TableBorder.all(color: Colors.purple[100]!),
                    columnSpacing: 10,
                    dividerThickness: .4,
                    // dataRowColor: MaterialStateProperty.all(Colors.red),
                    // Datatable widget that have the property columns and rows.
                    columns: [
                      // Set the name of the column
                      DataColumn(label: Flexible(child: Center(child: Text('Name', style: TextStyle(fontSize: 10.w))))),
                      DataColumn(label: Flexible(child: Center(child: Text('No. Of\nPresent', style: TextStyle(fontSize: 10.w))))),
                      DataColumn(label: Flexible(child: Center(child: Text('No. Of\nFullday Leave', style: TextStyle(fontSize: 10.w))))),
                      DataColumn(label: Flexible(child: Center(child: Text('No. Of\nHalfday Morning', style: TextStyle(fontSize: 10.w))))),
                      DataColumn(label: Flexible(child: Center(child: Text('No. Of\nHalfday Afternoon', style: TextStyle(fontSize: 10.w))))),
                      DataColumn(label: Flexible(child: Center(child: Text('Total\nLeaves Taken', style: TextStyle(fontSize: 10.w))))),
                      DataColumn(label: Flexible(child: Center(child: Text('No. Of\nHours Off', style: TextStyle(fontSize: 10.w))))),
                      DataColumn(label: Flexible(child: Center(child: Text('No. Of\nHoliday', style: TextStyle(fontSize: 10.w))))),
                    ],
                    rows: [
                      // Set the values to the columns
                      DataRow(
                        cells: [
                          DataCell(Center(child: Text('Mohammed Shahil', style: TextStyle(fontSize: 10.w)))),
                          DataCell(Center(child: Text('7', style: TextStyle(fontSize: 10.w)))),
                          DataCell(Center(child: Text('0', style: TextStyle(fontSize: 10.w)))),
                          DataCell(Center(child: Text('0', style: TextStyle(fontSize: 10.w)))),
                          DataCell(Center(child: Text('0', style: TextStyle(fontSize: 10.w)))),
                          DataCell(Center(child: Text('0', style: TextStyle(fontSize: 10.w)))),
                          DataCell(Center(child: Text('0', style: TextStyle(fontSize: 10.w)))),
                          DataCell(Center(child: Text('7', style: TextStyle(fontSize: 10.w)))),
                        ],
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    dividerThickness: .4,
                    // dataRowColor: MaterialStateProperty.all(Colors.red),
                    // Datatable widget that have the property columns and rows.
                    columns: [
                      // Set the name of the column
                      DataColumn(label: Flexible(child: Center(child: Text('Date', style: TextStyle(fontSize: 10.w))))),
                      DataColumn(label: Flexible(child: Center(child: Text('Day', style: TextStyle(fontSize: 10.w))))),
                      DataColumn(label: Flexible(child: Center(child: Text('Shahil', style: TextStyle(fontSize: 10.w))))),
                    ],
                    rows: [
                      // Set the values to the columns
                      DataRow(
                        cells: [
                          DataCell(Text('1', style: TextStyle(fontSize: 10.w))),
                          DataCell(Text('Monday', style: TextStyle(fontSize: 10.w))),
                          DataCell(
                            Container(
                              alignment: Alignment.center,
                              width: 100.w,
                              color: Colors.green,
                              child:  Text('P', style: TextStyle(color: Colors.white, fontSize: 11.w, fontWeight: FontWeight.w900)),
                            ),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text('2', style: TextStyle(fontSize: 10.w))),
                          DataCell(Text('Saturday', style: TextStyle(fontSize: 10.w))),
                          DataCell(
                            Container(
                              alignment: Alignment.center,
                              width: 100.w,
                              color: Colors.green,
                              child: Text('P', style: TextStyle(color: Colors.white, fontSize: 11.w, fontWeight: FontWeight.w900)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
