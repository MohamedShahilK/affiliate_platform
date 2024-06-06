// ignore_for_file: lines_longer_than_80_chars, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:affiliate_platform/config/ripple.dart';
import 'package:affiliate_platform/logic/employee/checkin/checkin_bloc.dart';
import 'package:affiliate_platform/logic/employee/project/project_bloc.dart';
import 'package:affiliate_platform/utils/constants/styles.dart';
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
              const CustomHeader(isBackButtonNeeded: true, heading: 'CheckIn Details'),

              //
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 16.h),
                    child: StreamBuilder(
                      stream: bloc.getProjectViewStream,
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
                                        await bloc.viewProject(projectId: widget.checkInId!);
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
                        final model = getContactViewStreamsnapshot.data?.data?[0].projects;
                        return Skeletonizer(
                          enabled: loading,
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
                                              Text('Project Name', style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800])),
                                              const Spacer(),
                                              SelectableText(model?.name ?? '-', style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800], fontWeight: FontWeight.w800)),
                                            ],
                                          ),
                                        ),

                                        // _NewCardItem(field: 'Phone Number', value: model.phoneNumber, icondata: Icons.phone_outlined),
                                        // _NewCardItem(field: 'Name', value: model?.name ?? '-', icondata: Icons.person_2_outlined),
                                        _NewCardItem(field: 'Client', value: model?.contactName ?? '-', icondata: Icons.person_pin_outlined),
                                        _NewCardItem(field: 'Quotation', value: model?.quotationRefr ?? '-', icondata: Icons.note_alt_outlined),
                                        _NewCardItem(field: 'Start Date', value: model?.startDate ?? '-', icondata: Icons.date_range),
                                        _NewCardItem(field: 'End Date', value: model?.endDate ?? '-', icondata: Icons.date_range),
                                        // _NewCardItem(field: 'Description', value: model?.description ?? '-', icondata: Icons.description_outlined),

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
                                              Text('Description', style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800])),
                                              const Spacer(),
                                              SelectableText(
                                                model?.description ?? '-',
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
