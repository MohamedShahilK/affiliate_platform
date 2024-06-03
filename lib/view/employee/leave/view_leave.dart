// ignore_for_file: lines_longer_than_80_chars, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:affiliate_platform/logic/employee/leave/leave_bloc.dart';
import 'package:affiliate_platform/logic/employee/project/project_bloc.dart';
import 'package:affiliate_platform/models/employee/leave/leave_model.dart';
import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/utils/utility_functions.dart';
import 'package:affiliate_platform/view/common/custom_header.dart';
import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

// ValueNotifier<List<List<String?>?>?> affUsersHavePerm = ValueNotifier([]);

class ViewLeave extends StatefulWidget {
  const ViewLeave({
    required this.leaveModel,
    super.key,
  });

  final LeavesList? leaveModel;

  @override
  State<ViewLeave> createState() => _ViewLeaveState();
}

class _ViewLeaveState extends State<ViewLeave> {
  var _refreshKey = UniqueKey();
  LeaveBloc? leaveBloc;

  // bool loading = true;

  @override
  void initState() {
    super.initState();
    // affUsersHavePerm.value = [];
    // affUsersHavePerm.notifyListeners();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // leaveBloc ??= Provider.of<LeaveBloc>(context);
    // leaveBloc!.viewProject(projectId: widget.contactId!).then(
    //       (value) => setState(() {
    //         loading = false;
    //       }),
    //     );

    // setState(() {
    //   loading = false;
    // });
  }

  // To update or hot reload
  void _handleLocaleChanged() => setState(() {
        _refreshKey = UniqueKey();
      });
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<ProjectBloc>(context);
    return CustomScaffold(
      key: _refreshKey,
      haveFloatingButton: false,
      body: SafeArea(
        child: GestureDetector(
          // onTap: _handleLocaleChanged,
          // onTap: _handleLocaleChanged,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomHeader(isBackButtonNeeded: true, heading: 'Project Details'),

              //
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(),
                        SizedBox(height: 10.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text('Company Information', style: AppStyles.poppins.copyWith(fontSize: 13.w, color: Colors.grey[800], fontWeight: FontWeight.w800)),

                            Padding(
                              padding: EdgeInsets.only(top: 10.h),
                              // child: _NewCardItem(model: model),
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 2.h),
                                    decoration: BoxDecoration(
                                      // border: Border.all(color: Colors.grey),
                                      color: const Color(0xFFFEFBFF),
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(12.r), topLeft: Radius.circular(12.r)),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 5.w),
                                    child: Row(
                                      children: [
                                        Icon(Icons.book_outlined, size: 13.w),
                                        SizedBox(width: 5.w),
                                        Text('Employee Name', style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800])),
                                        const Spacer(),
                                        SelectableText(widget.leaveModel?.employee ?? '-',
                                            style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800], fontWeight: FontWeight.w800)),
                                      ],
                                    ),
                                  ),

                                  // _NewCardItem(field: 'Phone Number', value: widget.leaveModel.phoneNumber, icondata: Icons.phone_outlined),
                                  // _NewCardItem(field: 'Name', value: widget.leaveModel?.name ?? '-', icondata: Icons.person_2_outlined),
                                  _NewCardItem(field: 'User Code', value: widget.leaveModel?.userCode ?? '-', icondata: Icons.person_pin_outlined),
                                  _NewCardItem(
                                      field: 'Start Date',
                                      value: UtilityFunctions.convertIntoNormalDateStringFromDateTimeString(widget.leaveModel?.leaveStartDate ?? '2014-05-27'),
                                      icondata: Icons.note_alt_outlined),
                                  _NewCardItem(
                                      field: 'End Date',
                                      value: UtilityFunctions.convertIntoNormalDateStringFromDateTimeString(widget.leaveModel?.leaveEndDate ?? '2014-05-27'),
                                      icondata: Icons.date_range),
                                  _NewCardItem(field: 'Leave Type', value: widget.leaveModel?.leaveType ?? '-', icondata: Icons.date_range),
                                  _NewCardItem(field: 'Leave Reason', value: widget.leaveModel?.leaveReason ?? '-', icondata: Icons.date_range),
                                  // _NewCardItem(field: 'Bridge Leave', value: widget.leaveModel?.bridgeLeave ?? '-', icondata: Icons.date_range),

                                  //
                                  Container(
                                    decoration: BoxDecoration(
                                      // border: Border.all(color: Colors.grey),
                                      color: const Color(0xFFFEFBFF),
                                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(12.r), bottomLeft: Radius.circular(12.r)),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 5.w),
                                    child: Row(
                                      children: [
                                        Icon(Icons.stairs_outlined, size: 13.w),
                                        SizedBox(width: 5.w),
                                        Text('Bridge Leave', style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800])),
                                        const Spacer(),
                                        SelectableText(
                                          (widget.leaveModel?.bridgeLeave == 'N'
                                              ? 'NO'
                                              : widget.leaveModel?.bridgeLeave == 'Y '
                                                  ? 'YES'
                                                  : '-'),
                                          style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800], fontWeight: FontWeight.w800),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Color getRandomColor() {
  //   final random = Random();
  //   var red = random.nextInt(256);
  //   var green = random.nextInt(256);
  //   var blue = random.nextInt(256);

  //   // Ensure the generated color is not white (255, 255, 255)
  //   while (red == 255 && green == 255 && blue == 255) {
  //     red = random.nextInt(256);
  //     green = random.nextInt(256);
  //     blue = random.nextInt(256);
  //   }

  //   return Color.fromARGB(255, red, green, blue);
  // }

  // Color getRandomColor() {
  //   Random random = Random();
  //   Color color;
  //   do {
  //     int red = random.nextInt(128); // Generating a darker shade for red
  //     int green = random.nextInt(128); // Generating a darker shade for green
  //     int blue = random.nextInt(128); // Generating a darker shade for blue
  //     color = Color.fromARGB(255, red, green, blue);
  //   } while (color == Colors.white);
  //   return color;
  // }
}

class _NewCardItem extends StatelessWidget {
  const _NewCardItem({
    required this.field,
    required this.value,
    required this.icondata,
    // this.bottomPadReq = false,
  });

  // final bool bottomPadReq;
  final String field;
  final String value;
  final IconData icondata;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      decoration: const BoxDecoration(
        // border: Border.all(color: Colors.grey),
        color: Color(0xFFFEFBFF),
        // borderRadius: BorderRadius.only(topRight: Radius.circular(12.r), topLeft: Radius.circular(12.r)),
      ),
      padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 5.w),
      child: Row(
        children: [
          Icon(icondata, size: 13.w),
          SizedBox(width: 5.w),
          Text(field, style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800])),
          const Spacer(),
          SizedBox(
            width: 150.w,
            child: Align(
              alignment: Alignment.bottomRight,
              child: SelectableText(value, textAlign: TextAlign.justify, style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800], fontWeight: FontWeight.w800)),
            ),
          ),
        ],
      ),
    );
  }
}

class _CardItem extends StatelessWidget {
  const _CardItem({
    required this.field,
    required this.value,
  });

  final String field;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 15.h),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.person, size: 12.w),
                SizedBox(width: 5.w),
                Text(field, style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800])),
                const Spacer(),
                SizedBox(
                  width: 150.w,
                  child: Align(alignment: Alignment.bottomRight, child: Text(value, style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800], fontWeight: FontWeight.w900))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EachValue extends StatelessWidget {
  const _EachValue({
    required this.field,
    required this.value,
  });

  final String field;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // Positioned(
              //   left: 0,
              //   right: 0,
              //   top: 0,
              //   child: Container(
              //     height: .3,
              //     color: Colors.grey[300],
              //   ),
              // ),
              Text(field, style: AppStyles.poppins.copyWith(fontSize: 13.w, color: Colors.grey[800], fontWeight: FontWeight.w800)),
              // Positioned(
              //   left: 0,
              //   right: 0,
              //   bottom: 0,
              //   child: Container(
              //     height: .3,
              //     color: Colors.grey[300],
              //   ),
              // ),
            ],
          ),
          SizedBox(height: 3.h),
          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Text(value, style: AppStyles.poppins.copyWith(fontSize: 13.w, color: Colors.grey[600])),
          ),
        ],
      ),
    );
  }
}
