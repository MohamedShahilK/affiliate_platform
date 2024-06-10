// ignore_for_file: lines_longer_than_80_chars, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:affiliate_platform/config/ripple.dart';
import 'package:affiliate_platform/logic/employee/checkin/checkin_bloc.dart';
import 'package:affiliate_platform/logic/employee/project/project_bloc.dart';
import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/utils/utility_functions.dart';
import 'package:affiliate_platform/view/common/custom_header.dart';
import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ViewCheckIn extends StatefulWidget {
  const ViewCheckIn({
    this.checkInId,
    super.key,
  });

  final String? checkInId;

  @override
  State<ViewCheckIn> createState() => _ViewCheckInState();
}

class _ViewCheckInState extends State<ViewCheckIn> {
  var _refreshKey = UniqueKey();
  CheckInBloc? checkinBloc;

  bool loading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checkinBloc ??= Provider.of<CheckInBloc>(context);
    checkinBloc!.viewCheckin(checkInID: widget.checkInId!).then(
          (value) => setState(() {
            loading = false;
          }),
        );

    // setState(() {
    //   loading = false;
    // });
  }

  // To update or hot reload
  void _handleLocaleChanged() => setState(() {
        _refreshKey = UniqueKey();
      });
  final project_status = ['Inactive', 'Active', 'Completed', 'On Hold'];
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<CheckInBloc>(context);
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
              const CustomHeader(isBackButtonNeeded: true, heading: 'Check In & Check Out Information'),

              //
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 16.h),
                    child: StreamBuilder(
                      stream: bloc.getCheckinViewStream,
                      builder: (context, getContactViewStreamsnapshot) {
                        if (!getContactViewStreamsnapshot.hasData && !loading) {
                          Loader.hide();
                          return Expanded(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Something went wrong',
                                    style: TextStyle(fontSize: 16.w),
                                  ),
                                  SizedBox(height: 30.h),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 8.h),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.purple[100]!),
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.refresh, size: 17.w),
                                        SizedBox(width: 5.w),
                                        Text('Refreshee', style: TextStyle(fontSize: 15.w)),
                                      ],
                                    ),
                                  ).ripple(
                                    context,
                                    () async {
                                      if (widget.checkInId != null) {
                                        await bloc.viewCheckin(checkInID: widget.checkInId!);
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(15.r),
                                    overlayColor: Colors.purple.withOpacity(.15),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        final data = getContactViewStreamsnapshot.data?.data?[0];
                        final model = getContactViewStreamsnapshot.data?.data?[0].checkinData;
                        final checkindataprojects = getContactViewStreamsnapshot.data?.data?[0].checkinProjects ?? [];
                        final checkout = getContactViewStreamsnapshot.data?.data?[0].checkout;
                        final checkoutDetails = getContactViewStreamsnapshot.data?.data?[0].checkoutDetails;
                        return Skeletonizer(
                          enabled: loading,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(),
                              SizedBox(height: 10.h),
                              Text('${model?.firstName} (${model?.userCode})', style: AppStyles.poppins.copyWith(fontSize: 15.w, color: Colors.grey[800], fontWeight: FontWeight.w800)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text('Employee Information', style: AppStyles.poppins.copyWith(fontSize: 13.w, color: Colors.grey[800], fontWeight: FontWeight.w800)),
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
                                              Text('Check In Time', style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800])),
                                              const Spacer(),
                                              SelectableText(
                                                UtilityFunctions.convertIntoNormalDateTimeStringFromDateTimeString(model?.datetime ?? '2024-05-20 21:55:20'),
                                                style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800], fontWeight: FontWeight.w800),
                                              ),
                                            ],
                                          ),
                                        ),

                                        if (checkout?.datetime != null) _NewCardItem(field: 'Check Out Time', value: checkout?.outTime ?? '-', icondata: Icons.person_pin_outlined),
                                        _NewCardItem(field: 'Work From', value: model?.workFrom ?? '-', icondata: Icons.person_pin_outlined),
                                        if (checkout?.breakHours != null) _NewCardItem(field: 'Break Hours', value: checkout?.breakHours ?? '-', icondata: Icons.person_pin_outlined),
                                        if (checkout?.hours != null) _NewCardItem(field: 'Working Hours', value: checkout?.hours ?? '-', icondata: Icons.person_pin_outlined),
                                        if (checkout?.hours != null) _NewCardItem(field: 'Total Hours', value: checkout?.hours ?? '-', icondata: Icons.person_pin_outlined),
                                        // _NewCardItem(field: 'UserCode', value: model?.userCode ?? '-', icondata: Icons.note_alt_outlined),

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
                                              Text('Comments', style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800])),
                                              const Spacer(),
                                              SelectableText(
                                                model?.remarks ?? '-',
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

                              // SizedBox(height: 25.h),
                              // Text('Project Information', style: AppStyles.poppins.copyWith(fontSize: 13.w, color: Colors.grey[800], fontWeight: FontWeight.w800)),
                              Column(
                                children: [
                                  if (checkindataprojects.isNotEmpty)
                                    ...List.generate(
                                      checkindataprojects.length,
                                      (index) => Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 20.h),
                                          Text('Project #${index + 1}', style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800], fontWeight: FontWeight.w800)),
                                          SizedBox(height: 5.h),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 5.h),
                                            decoration: BoxDecoration(color: Colors.green[700], borderRadius: BorderRadius.circular(10.r)),
                                            child: Text('CHECK IN', style: AppStyles.poppins.copyWith(fontSize: 8.w, color: Colors.white, fontWeight: FontWeight.w800)),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 5.h),
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
                                                      Text('Project Name', style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800])),
                                                      const Spacer(),
                                                      SelectableText(
                                                        checkindataprojects[index].projectname ?? '-',
                                                        style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800], fontWeight: FontWeight.w800),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                _NewCardItem(field: 'Project Description', value: checkindataprojects[index].checkinProjects ?? '-', icondata: Icons.note_alt_outlined),
                                                // _NewCardItem(field: 'Required Hours', value: checkindataprojects[index].reqHoursMin ?? '-', icondata: Icons.note_alt_outlined),

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
                                                      Text('Required Hours', style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800])),
                                                      const Spacer(),
                                                      SelectableText(
                                                        checkindataprojects[index].reqHoursMin ?? '-',
                                                        style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800], fontWeight: FontWeight.w800),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (checkoutDetails != null) SizedBox(height: 5.h),
                                          if (checkoutDetails != null)
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 5.h),
                                              decoration: BoxDecoration(color: Colors.red[700], borderRadius: BorderRadius.circular(10.r)),
                                              child: Text('CHECK OUT', style: AppStyles.poppins.copyWith(fontSize: 8.w, color: Colors.white, fontWeight: FontWeight.w800)),
                                            ),
                                          if (checkoutDetails != null)
                                            Padding(
                                              padding: EdgeInsets.only(top: 5.h),
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
                                                        Text('Description', style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800])),
                                                        const Spacer(),
                                                        SelectableText(
                                                          checkoutDetails?[index].checkOutRemarks ?? '-',
                                                          style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800], fontWeight: FontWeight.w800),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  // _NewCardItem(field: 'Description', value: checkoutDetails?[index].checkOutRemarks ?? '-', icondata: Icons.note_alt_outlined),
                                                  // _NewCardItem(field: 'Required Hours', value: checkindataprojects[index].reqHoursMin ?? '-', icondata: Icons.note_alt_outlined),

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
                                                        Text('Hours Spent', style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800])),
                                                        const Spacer(),
                                                        SelectableText(
                                                          checkoutDetails?[index].hoursSpent ?? '-',
                                                          style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800], fontWeight: FontWeight.w800),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          SizedBox(height: 5.h),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 5.h),
                                            decoration: BoxDecoration(color: Colors.orange[700], borderRadius: BorderRadius.circular(10.r)),
                                            child: Text('STATUS : PENDING', style: AppStyles.poppins.copyWith(fontSize: 8.w, color: Colors.white, fontWeight: FontWeight.w800)),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
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

  Color? _statusColor({required String status}) {
    if (status == 'Active') {
      return Colors.green[600];
    } else if (status == 'Inactive') {
      return Colors.red;
    } else if (status == 'On Hold') {
      return Colors.purple[600];
    } else if (status == 'Completed') {
      return Colors.blue[600];
    } else {
      return Colors.green[600];
    }
  }
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
              child: SelectableText(
                value,
                textAlign: TextAlign.justify,
                style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800], fontWeight: FontWeight.w800),
              ),
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
