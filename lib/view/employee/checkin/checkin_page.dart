// ignore_for_file: lines_longer_than_80_chars, inference_failure_on_instance_creation

import 'package:affiliate_platform/app.dart';
import 'package:affiliate_platform/config/ripple.dart';
import 'package:affiliate_platform/logic/employee/checkin/checkin_bloc.dart';
import 'package:affiliate_platform/models/employee/checkin/get_checkin_form.dart';
import 'package:affiliate_platform/models/employee/checkin/getall_checkins.dart';
import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/utils/custom_tools.dart';
import 'package:affiliate_platform/utils/utility_functions.dart';
import 'package:affiliate_platform/view/common/custom_header.dart';
import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:affiliate_platform/view/employee/checkin/new_checkin.dart';
import 'package:affiliate_platform/view/employee/checkin/view_checkin.dart';
import 'package:affiliate_platform/view/employee/checkout/new_checkout.dart';
import 'package:affiliate_platform/view/employee/project/new_project.dart';
import 'package:affiliate_platform/view/manage_contact/manage_contact.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key});

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  var _refreshKey = UniqueKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Loader.hide();
  }

  // To update or hot reload
  void _handleLocaleChanged() => setState(() {
        _refreshKey = UniqueKey();
      });

  @override
  Widget build(BuildContext context) {
    final checkinBloc = Provider.of<CheckInBloc>(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        await appExitDialog(context);
      },
      child: CustomScaffold(
        key: _refreshKey,
        onTapFloatingButton: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewCheckin(),
            ),
          );
        },
        body: SafeArea(
          child: GestureDetector(
            // onTap: _handleLocaleChanged,
            onTap: () {
              // _handleLocaleChanged();
              // menuVisibility.value = false;
              // menuVisibility.notifyListeners();
              Scaffold.of(context).closeDrawer();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // const CustomHeader(
                  //   heading: 'Profile',
                  //   isBackButtonNeeded: true,
                  //   isTrailingButtonNeeded: true,
                  // ),

                  const CustomHeader(),

                  //
                  // _body(),
                  StreamBuilder(
                    stream: checkinBloc.getCheckInFormStream,
                    builder: (context, getCheckInFormStreamsnapshot) {
                      if ((!getCheckInFormStreamsnapshot.hasData && getCheckInFormStreamsnapshot.connectionState != ConnectionState.waiting) || getCheckInFormStreamsnapshot.hasError) {
                        Loader.hide();
                        return Column(
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
                                  Text('Refresh', style: TextStyle(fontSize: 15.w)),
                                ],
                              ),
                            ).ripple(
                              context,
                              () async {
                                await checkinBloc.getCheckinForm();
                              },
                              borderRadius: BorderRadius.circular(15.r),
                              overlayColor: Colors.purple.withOpacity(.15),
                            ),
                          ],
                        );
                      }

                      GetCheckinForm? checkInFormModel;

                      if (getCheckInFormStreamsnapshot.hasData) {
                        checkInFormModel = getCheckInFormStreamsnapshot.data;
                      }

                      return StreamBuilder(
                        stream: checkinBloc.getAllCheckInsStream,
                        builder: (context, getAllProjectsStreamsnapshot) {
                          if ((!getAllProjectsStreamsnapshot.hasData && getAllProjectsStreamsnapshot.connectionState != ConnectionState.waiting) || getAllProjectsStreamsnapshot.hasError) {
                            Loader.hide();
                            return Column(
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
                                      Text('Refresh', style: TextStyle(fontSize: 15.w)),
                                    ],
                                  ),
                                ).ripple(
                                  context,
                                  () async {
                                    await checkinBloc.getAllCheckins();
                                  },
                                  borderRadius: BorderRadius.circular(15.r),
                                  overlayColor: Colors.purple.withOpacity(.15),
                                ),
                              ],
                            );
                          }

                          // print('2222222222222222222222222222222222222222222222 ${snapshot.data}');

                          GetAllCheckIns? allCheckinsRespModel;

                          List<CheckinData>? checkinData = [];

                          if (getAllProjectsStreamsnapshot.hasData) {
                            allCheckinsRespModel = getAllProjectsStreamsnapshot.data;
                            if (allCheckinsRespModel!.data != null && allCheckinsRespModel.data!.isNotEmpty) {
                              checkinData = allCheckinsRespModel.data?[0].checkinData ?? [];
                              // print('11111111111111111111111 $checkinData');
                            }
                          }

                          if (blocOficialLoaderNotifier.value) {
                            allCheckinsRespModel = null;
                          }

                          // print('232314343 ${projectList}');

                          return Skeletonizer(
                            enabled: getAllProjectsStreamsnapshot.connectionState == ConnectionState.waiting || blocOficialLoaderNotifier.value,
                            child: Padding(
                              padding: EdgeInsets.only(top: 30.h, bottom: 5.h, left: 20.w, right: 20.w),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CheckInDropDown(
                                          textStream: checkinBloc.employeeFilterStream,
                                          heading: 'Employee',
                                          hint: 'Select Employee',
                                          // items:leaveFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                          items: (checkInFormModel != null &&
                                                  checkInFormModel.data != null &&
                                                  checkInFormModel.data!.isNotEmpty &&
                                                  checkInFormModel.data?[0].employeeList != null &&
                                                  checkInFormModel.data![0].employeeList!.isNotEmpty)
                                              ? ['', ...checkInFormModel.data![0].employeeList?.map((e) => e.firstName ?? '') ?? []]
                                              : [''],
                                          label: 'Employee',
                                        ),
                                      ),
                                      SizedBox(width: 20.w),
                                      Expanded(
                                        child: CheckInDropDown(
                                          textStream: checkinBloc.projectFilterStream,
                                          heading: 'Project',
                                          hint: 'Select Project',
                                          // items:leaveFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                          items: (checkInFormModel != null &&
                                                  checkInFormModel.data != null &&
                                                  checkInFormModel.data!.isNotEmpty &&
                                                  checkInFormModel.data?[0].projectList != null &&
                                                  checkInFormModel.data![0].projectList!.isNotEmpty)
                                              ? ['', ...checkInFormModel.data![0].projectList?.map((e) => e.name ?? '') ?? []]
                                              : [''],
                                          label: 'Project',
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CheckInField(
                                          enabled: false,
                                          // isForDateField: true,
                                          heading: 'From Time',
                                          hintText: 'Select From Time',
                                          textStream: checkinBloc.checkInFromDateFilterStream,
                                          // onChanged: bloc.checkinTimeStream.add,
                                          onTap: () async {
                                            // print('132131231231232113 ${DateFormat('yyyy-MM-dd').parse(bloc.leaveStartDateStream.value)}');

                                            final date = await _selectDate(context);

                                            if (date != null) {
                                              checkinBloc.checkInFromDateFilterStream.add(date);
                                            }
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: CheckInField(
                                          enabled: false,
                                          // isForDateField: true,
                                          heading: 'To Time',
                                          hintText: 'Select To Time',
                                          textStream: checkinBloc.checkInToDateFilterStream,
                                          // onChanged: bloc.checkinTimeStream.add,
                                          onTap: () async {
                                            final date = await _selectDate(context);

                                            if (date != null) {
                                              checkinBloc.checkInToDateFilterStream.add(date);
                                            }
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: CheckInDropDown(
                                          textStream: checkinBloc.workFromFilterStream,
                                          heading: 'Work From',
                                          hint: 'Select Work From',
                                          // items:leaveFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                          items: const ['', 'Home', 'Office'],
                                          label: 'Work From',
                                        ),
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                      margin: EdgeInsets.only(bottom: 15.h),
                                      decoration: BoxDecoration(
                                        color: Colors.purple,
                                        borderRadius: BorderRadius.circular(10.r),
                                      ),
                                      child: Text('Filter', style: AppStyles.poppins.copyWith(fontSize: 10.w, color: Colors.white)),
                                    ).ripple(context, () async {
                                      customLoader(context);

                                      String? employeeId;

                                      String? projectId;

                                      if (checkinBloc.projectFilterStream.value != '') {
                                        projectId = checkInFormModel?.data?[0].projectList?.firstWhere((e) => e.name == checkinBloc.projectFilterStream.value).id;
                                      }

                                      if (checkinBloc.employeeFilterStream.value != '') {
                                        employeeId = checkInFormModel?.data?[0].employeeList?.firstWhere((e) => e.firstName == checkinBloc.employeeFilterStream.value).userId;
                                      }

                                      if (checkinBloc.checkInFromDateFilterStream.value != '' &&
                                          checkinBloc.checkInFromDateFilterStream.value != '' &&
                                          UtilityFunctions.isSecondDateBeforeFirst(
                                            firstDateStr: checkinBloc.checkInFromDateFilterStream.value,
                                            secondDateStr: checkinBloc.checkInToDateFilterStream.value,
                                          )) {
                                        await erroMotionToastInfo(context, msg: 'To Date must not be earlier than From Date');
                                        Loader.hide();
                                        return;
                                      }

                                      final workFromId = checkinBloc.workFromFilterStream.value == 'Home'
                                          ? '1'
                                          : checkinBloc.workFromFilterStream.value == 'Home'
                                              ? '2'
                                              : '';
                                      // print('22222222222222222222222222222 ${checkinBloc.workFromFilterStream.value}');
                                      try {
                                        await checkinBloc.getAllCheckins(employeeId: employeeId ,projectId: projectId, worfromId: workFromId);
                                        Loader.hide();
                                      } catch (e) {
                                        Loader.hide();
                                      } finally {
                                        Loader.hide();
                                      }
                                    }),
                                  ),
                                  Column(
                                    children: List.generate(
                                      (allCheckinsRespModel == null) ? 5 : checkinData.length,
                                      (index) => _ProjectCard(
                                        index: index,
                                        model: allCheckinsRespModel,
                                        isLoading: getAllProjectsStreamsnapshot.connectionState == ConnectionState.waiting,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> _selectDate(BuildContext context) async {
    var date = DateTime.now();
    final now = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    );

    if (picked != null) {
      date = DateTime(
        picked.year,
        picked.month,
        picked.day,

        // pickedTime.,
      );

      // print('77777777777777777777777777777 ${DateFormat('dd/MM/yyyy').format(date)}');
      final dateStr = DateFormat('dd/MM/yyyy').format(date);

      // if (dateStr == '') {
      //   await erroMotionToastInfo(context, msg: 'Something wrong !!');
      //   return null;
      // }

      return dateStr;
    }

    // await erroMotionToastInfo(context, msg: 'Something wrong !!');
    return null;
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({
    required this.index,
    this.model,
    this.isLoading = false,
    super.key,
  });

  final int index;
  final GetAllCheckIns? model;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    // final status = model?.data == null || model!.data!.isEmpty || model!.data![0].projectList!.isEmpty || model!.data![0].projectList!.isEmpty
    //     ? 'status'
    //     : model?.data![0].projectStatus![int.parse(model?.data![0].projectList![index].status ?? '1')] == 'status'
    //         ? 'status'
    //         : model?.data![0].projectStatus![int.parse(model?.data![0].projectList![index].status ?? '1')] ?? 'status';
    return SizedBox(
      // height: 150.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.only(top: 5.h, bottom: 15.h, left: 20.w, right: 20.w),
            margin: EdgeInsets.only(bottom: 10.h),
            // margin: EdgeInsets.symmetric(horizontal: 5.w),
            decoration: BoxDecoration(
              // color: Colors.grey[100],
              color: Colors.purple.withOpacity(.04),
              // border: Border.all(color:  Colors.grey[300]!),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      // 'Giridhar | Qtn2015',
                      'CheckIn #${index + 1}',
                      // '1',
                      style: AppStyles.poppins.copyWith(color: Colors.grey[800], fontSize: 9.w, fontWeight: FontWeight.w900),
                    ),
                    const Spacer(),
                    Text(
                      // 'Giridhar | Qtn2015',
                      // 'No. of Projects : 2',
                      'No. of Projects : ${model?.data == null || model!.data!.isEmpty || model!.data![0].checkinData == null || model!.data![0].checkinData!.isEmpty ? '-' : model?.data![0].checkinData![index].projects == '' ? '-' : model?.data![0].checkinData![index].projects ?? '-'}',
                      // '1',
                      style: AppStyles.poppins.copyWith(color: Colors.grey[800], fontSize: 11.w, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // Text(
                            //   'Name: ',
                            //   style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey[800], fontSize: 12.w),
                            // ),
                            Icon(Icons.person_2_outlined, size: 17.w, color: Colors.purple[400]),
                            SizedBox(width: 5.w),
                            SizedBox(
                              width: 90.w,
                              // child: Text(
                              //   // 'Mr. Lallit Potter',
                              //   widget.name,
                              //   style: AppStyles.poppins.copyWith(color: Colors.grey[800], fontSize: 12.w, overflow: TextOverflow.ellipsis),
                              // ),
                              child: MyTextWidget(
                                // text: 'Shahilasdadas',
                                text: model?.data == null || model!.data!.isEmpty || model!.data![0].checkinData == null || model!.data![0].checkinData!.isEmpty
                                    ? '-'
                                    : model?.data![0].checkinData![index].firstName == ''
                                        ? '-'
                                        : model?.data![0].checkinData![index].firstName ?? '-',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        // const Spacer(),
                        Row(
                          children: [
                            // Text(
                            //   'Company Name: ',
                            //   style: AppStyles.poppins.copyWith(fontWeight: FontWeight.w900, color: Colors.grey[800], fontSize: 12.w),
                            // ),
                            Icon(Icons.av_timer_sharp, size: 17.w, color: Colors.purple[400]),
                            SizedBox(width: 5.w),
                            SizedBox(
                              // width: 127.w,
                              // child: Text(
                              //   // 'R.K.I.F',
                              //   widget.model.companyName,
                              //   style: AppStyles.poppins.copyWith(color: Colors.grey[800], fontSize: 12.w, overflow: TextOverflow.ellipsis),
                              // ),
                              child: MyTextWidget(
                                text: model?.data == null || model!.data!.isEmpty || model!.data![0].checkinData == null || model!.data![0].checkinData!.isEmpty
                                    ? '-'
                                    : model?.data![0].checkinData![index].createdAt == ''
                                        ? '-'
                                        : UtilityFunctions.convertIntoNormalDateTimeStringFromDateTimeString(model?.data![0].checkinData![index].datetime ?? '2014-05-27 08:53:53'),
                                // text: '22-05-2024 09:51 AM',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // Text(
                                //   'Name: ',
                                //   style: AppStyles.poppins.copyWith(fontWeight: FontWeight.w900, color: Colors.grey[800], fontSize: 12.w),
                                // ),
                                Icon(Icons.timer_outlined, size: 17.w, color: Colors.purple[400]),
                                SizedBox(width: 5.w),
                                SizedBox(
                                  width: 70.w,
                                  // child: Text(
                                  //   // 'info@sgtf.ae',
                                  //   widget.model.email,
                                  //   style: AppStyles.poppins.copyWith(color: Colors.grey[800], fontSize: 12.w, overflow: TextOverflow.ellipsis),
                                  // ),
                                  child: MyTextWidget(
                                    text: model?.data == null || model!.data!.isEmpty || model!.data![0].checkinData == null || model!.data![0].checkinData!.isEmpty
                                        ? '-'
                                        : model?.data![0].checkinData![index].hours == ''
                                            ? '-'
                                            : model?.data![0].checkinData![index].hours ?? '-',
                                    // text: '08:30:00',
                                    isRightItem: true,
                                  ),
                                ),
                              ],
                            ),
                            // const Spacer(),
                            SizedBox(height: 5.h),
                            Row(
                              children: [
                                // Text(
                                //   'Name: ',
                                //   style: AppStyles.poppins.copyWith(fontWeight: FontWeight.w900, color: Colors.grey[800], fontSize: 12.w),
                                // ),
                                Icon(Icons.business, size: 17.w, color: Colors.purple[400]),
                                SizedBox(width: 5.w),
                                SizedBox(
                                  width: 70.w,
                                  // child: Text(
                                  //   // 'info@sgtf.ae',
                                  //   widget.model.email,
                                  //   style: AppStyles.poppins.copyWith(color: Colors.grey[800], fontSize: 12.w, overflow: TextOverflow.ellipsis),
                                  // ),
                                  child: MyTextWidget(
                                    text: model?.data == null || model!.data!.isEmpty || model!.data![0].checkinData == null || model!.data![0].checkinData!.isEmpty
                                        ? '-'
                                        : model?.data![0].checkinData![index].workFrom == ''
                                            ? '-'
                                            : model?.data![0].checkinData![index].workFrom ?? '-',
                                    // text: 'Office',
                                    isRightItem: true,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        //
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     _EachProjectSmallButtons(
                        //       color: Colors.green[900]!,
                        //       icon: Icons.edit_outlined,
                        //       onTap: () {
                        //         Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //             builder: (context) => const NewProject(),
                        //           ),
                        //         );
                        //       },
                        //     ),
                        //     SizedBox(height: 3.h),
                        //     _EachProjectSmallButtons(
                        //       color: Colors.blue[400]!,
                        //       icon: Icons.remove_red_eye_outlined,
                        //       onTap: () {
                        //         Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //             builder: (context) => const ViewProject(),
                        //           ),
                        //         );
                        //       },
                        //     ),
                        //     SizedBox(height: 3.h),
                        //     _EachProjectSmallButtons(
                        //       color: Colors.red[400]!,
                        //       icon: Icons.delete_outline_outlined,
                        //       onTap: () {},
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 15.h),

                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Builder(
                          builder: (context) {
                            final checkoutStatus = model?.data == null || model!.data!.isEmpty || model!.data![0].checkinData == null || model!.data![0].checkinData!.isEmpty
                                ? 'No'
                                : model?.data![0].checkinData![index].checkOutStatus == ''
                                    ? 'No'
                                    : model?.data![0].checkinData![index].checkOutStatus ?? 'No';
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                              decoration: BoxDecoration(
                                color: isLoading
                                    ? Colors.transparent
                                    : checkoutStatus == 'No'
                                        ? Colors.red[600]
                                        : Colors.green[600],
                                // border: Border.all(color: Colors.purple[400]!),
                                // borderRadius: BorderRadius.only(topRight: Radius.circular(15.r), bottomLeft: Radius.circular(15.r)),
                                shape: BoxShape.circle,
                                // borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Icon(
                                Icons.subdirectory_arrow_right_rounded,
                                size: 15.w,
                                // color: Colors.purple[400],
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                        // SizedBox(width: 5.w),
                      ],
                    ).ripple(context, () {
                      final checkInId = model?.data == null || model!.data!.isEmpty || model!.data![0].checkinData == null || model!.data![0].checkinData!.isEmpty
                          ? '-'
                          : model?.data![0].checkinData![index].checkInId == ''
                              ? '-'
                              : model?.data![0].checkinData![index].checkInId ?? '-';

                      final checkoutStatus = model?.data == null || model!.data!.isEmpty || model!.data![0].checkinData == null || model!.data![0].checkinData!.isEmpty
                          ? 'No'
                          : model?.data![0].checkinData![index].checkOutStatus == ''
                              ? 'No'
                              : model?.data![0].checkinData![index].checkOutStatus ?? 'No';

                      final checkoutDateStr = model?.data == null || model!.data!.isEmpty || model!.data![0].checkinData == null || model!.data![0].checkinData!.isEmpty
                          ? 0
                          : model?.data![0].checkinData![index].checkInDatetime == 0
                              ? 0
                              : model?.data![0].checkinData![index].checkInDatetime ?? 0;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => checkoutStatus == 'No' ? NewCheckOut(checkoutDateTimeStr: checkoutDateStr.toString()) : ViewCheckIn(checkInId: checkInId),
                        ),
                      );
                    }),
                    const Spacer(),
                    // _EachProjectSmallButtons(
                    //   // color: Colors.green[900]!,
                    //   isLoading: isLoading,
                    //   icon: Icons.edit_outlined,
                    //   onTap: () {},
                    // ),
                    // _EachProjectSmallButtons(
                    //   // color: Colors.blue[400]!,
                    //   isLoading: isLoading,
                    //   icon: Icons.remove_red_eye_outlined,
                    //   onTap: () {},
                    // ),
                    // _EachProjectSmallButtons(
                    //   // color: Colors.red[400]!,
                    //   isLoading: isLoading,
                    //   icon: Icons.delete_outline_outlined,
                    //   onTap: () {},
                    // ),

                    Builder(
                      builder: (context) {
                        final checkoutStatus = model?.data == null || model!.data!.isEmpty || model!.data![0].checkinData == null || model!.data![0].checkinData!.isEmpty
                            ? 'No'
                            : model?.data![0].checkinData![index].checkOutStatus == ''
                                ? 'No'
                                : model?.data![0].checkinData![index].checkOutStatus ?? 'No';
                        return checkoutStatus == 'Yes'
                            ? const SizedBox.shrink()
                            : Container(
                                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
                                decoration: BoxDecoration(
                                  // color:  Colors.red[600],
                                  border: Border.all(color: Colors.blue[600]!),
                                  // borderRadius: BorderRadius.only(topRight: Radius.circular(15.r), bottomLeft: Radius.circular(15.r)),
                                  shape: BoxShape.circle,
                                  // borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: Icon(
                                  Icons.remove_red_eye_outlined,
                                  size: 19.w,
                                  // color: Colors.purple[400],
                                  color: Colors.blue,
                                ),
                              ).ripple(context, () {
                                final checkInId = model?.data == null || model!.data!.isEmpty || model!.data![0].checkinData == null || model!.data![0].checkinData!.isEmpty
                                    ? '-'
                                    : model?.data![0].checkinData![index].checkInId == ''
                                        ? '-'
                                        : model?.data![0].checkinData![index].checkInId ?? '-';

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewCheckIn(checkInId: checkInId, isCheckoutDone: true),
                                  ),
                                );
                              });
                      },
                    ),

                    SizedBox(width: 5.w),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        // color:  Colors.red[600],
                        border: Border.all(color: Colors.red[600]!),
                        // borderRadius: BorderRadius.only(topRight: Radius.circular(15.r), bottomLeft: Radius.circular(15.r)),
                        shape: BoxShape.circle,
                        // borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Icon(
                        Icons.delete_outline_outlined,
                        size: 19.w,
                        // color: Colors.purple[400],
                        color: Colors.red,
                      ),
                    ).ripple(context, () async {
                      final isTrue = await showWarningDialog(
                        context,
                        title: 'Remove CheckIN',
                        description: 'Are you sure want to delete the checkin?',
                        yes: 'Delete',
                        no: 'Cancel',
                      );

                      if (isTrue != null && isTrue) {
                        final checkInId = model?.data == null || model!.data!.isEmpty || model!.data![0].checkinData == null || model!.data![0].checkinData!.isEmpty
                            ? '-'
                            : model?.data![0].checkinData![index].checkInId == ''
                                ? '-'
                                : model?.data![0].checkinData![index].checkInId ?? '-';
                        // ignore: use_build_context_synchronously
                        customLoader(context);
                        // ignore: use_build_context_synchronously
                        final jsonData = await context.read<CheckInBloc>().deleteContact(checkInID: checkInId);

                        if (jsonData) {
                          // ignore: use_build_context_synchronously
                          await context.read<CheckInBloc>().getAllCheckins();
                          Loader.hide();
                          // ignore: use_build_context_synchronously
                          await successMotionToastInfo(context, msg: 'CheckIn deleted successfully');
                        } else {
                          Loader.hide();
                          // ignore: use_build_context_synchronously
                          await erroMotionToastInfo(context, msg: "Something wrong!!. Can't able to delete");
                        }
                      }
                    }),
                  ],
                ),
              ],
            ),
          ),

          // // For Sales Person
          // Positioned(
          //   // top: -18.h,
          //   top: -8.h,
          //   left: 0,
          //   child: Container(
          //     padding: EdgeInsets.only(right: 8.w, bottom: 15.h, left: 8.w, top: 2.h),
          //     decoration: BoxDecoration(
          //       // color: Colors.grey[100],
          //       color: Colors.purple.withOpacity(.1),
          //       borderRadius: BorderRadius.circular(15.r),
          //     ),
          //     child: Row(
          //       children: [
          //         // Container(
          //         //   height: 22.w,
          //         //   width: 22.w,
          //         //   decoration: const BoxDecoration(
          //         //     shape: BoxShape.circle,
          //         //     color: Colors.white,
          //         //     image: DecorationImage(image: AssetImage('assets/images/user.png')),
          //         //   ),
          //         // ),
          //         // SizedBox(width: 5.w),
          //         Text(
          //           // 'Giridhar | Qtn2015',
          //           'Project #${index + 1}',
          //           // '1',
          //           style: AppStyles.poppins.copyWith(color: Colors.grey[800], fontSize: 9.w, fontWeight: FontWeight.w900),
          //         ),
          //         // SizedBox(width: 3.w),
          //         // Text(
          //         //   'Qtn2015',
          //         //   style: AppStyles.poppins.copyWith(color: Colors.blueGrey, fontSize: 9.w),
          //         // ),
          //         // SizedBox(width: 2.w),
          //         // Container(
          //         //   padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
          //         //   decoration: BoxDecoration(color: Colors.cyan[900], borderRadius: BorderRadius.circular(15.r)),
          //         //   child: Text('Qtn2015', style: AppStyles.poppins.copyWith(fontSize: 7.w, color: Colors.white)),
          //         // ),
          //       ],
          //     ),
          //   ),
          // ),

          // For Admin
          // Positioned(
          //   // top: -18.h,
          //   top: -22.h,
          //   left: 0,
          //   child: Container(
          //     padding: EdgeInsets.only(right: 8.w),
          //     decoration: BoxDecoration(color: Colors.grey[100]!, borderRadius: BorderRadius.circular(15.r)),
          //     child: Row(
          //       children: [
          //         Container(
          //           height: 22.w,
          //           width: 22.w,
          //           decoration: const BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: Colors.white,
          //             image: DecorationImage(image: AssetImage('assets/images/user.png')),
          //           ),
          //         ),
          //         SizedBox(width: 5.w),
          //         Text(
          //           // 'Giridhar | Qtn2015',
          //           '${widget.user} | ${widget.type}',
          //           style: AppStyles.poppins.copyWith(color: Colors.grey[800], fontSize: 9.w),
          //         ),
          //         // SizedBox(width: 3.w),
          //         // Text(
          //         //   'Qtn2015',
          //         //   style: AppStyles.poppins.copyWith(color: Colors.blueGrey, fontSize: 9.w),
          //         // ),
          //         // SizedBox(width: 2.w),
          //         // Container(
          //         //   padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
          //         //   decoration: BoxDecoration(color: Colors.cyan[900], borderRadius: BorderRadius.circular(15.r)),
          //         //   child: Text('Qtn2015', style: AppStyles.poppins.copyWith(fontSize: 7.w, color: Colors.white)),
          //         // ),
          //       ],
          //     ),
          //   ),
          // ),
          // Positioned(
          //   top: -18.h,
          //   right: 0,
          //   child: Container(
          //     padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
          //     decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(15.r)),
          //     child: Text('Mar 12th 2024', style: AppStyles.poppins.copyWith (fontSize: 7.w, color: Colors.white)),
          //   ),
          // ),
        ],
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

class _EachProjectSmallButtons extends StatelessWidget {
  const _EachProjectSmallButtons({
    // required this.color,
    required this.icon,
    required this.onTap,
    this.isLoading = false,
  });

  // final Color color;
  final IconData icon;
  final VoidCallback onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
          decoration: BoxDecoration(
            // color: Colors.purple[400],
            border: Border.all(color: isLoading ? Colors.transparent : Colors.purple[400]!),
            // borderRadius: BorderRadius.only(topRight: Radius.circular(15.r), bottomLeft: Radius.circular(15.r)),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 16.w,
            color: Colors.purple[400],
          ),
        ),
        SizedBox(width: 5.w),
      ],
    ).ripple(context, onTap);
  }
}

class CheckInDropDown extends StatefulWidget {
  const CheckInDropDown({
    // required this.controller,
    required this.textStream,
    required this.heading,
    required this.hint,
    required this.label,
    // required this.initialValue,
    required this.items,
    super.key,
    // this.attendanceModel,
  });

  final BehaviorSubject<String> textStream;
  final String heading;
  final String hint;
  final String label;
  // final String initialValue;
  final List<String> items;
  // final GetAttendanceModel? attendanceModel;

  @override
  State<CheckInDropDown> createState() => _NewContactDropDownState();
}

class _NewContactDropDownState extends State<CheckInDropDown> {
  // final items = ['', 'a', 'b', 'c'];

  // String selectedValue = '';

  @override
  void initState() {
    super.initState();
    // selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              // border: Border.all(color: const Color.fromARGB(139, 103, 51, 137)),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: StreamBuilder(
              stream: widget.textStream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? '';
                return DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Row(
                      children: [
                        Icon(Icons.list, size: 16.w, color: Colors.purple[100]),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            widget.hint,
                            style: AppStyles.poppins.copyWith(
                              fontSize: 10.w,
                              // fontWeight: FontWeight.bold,
                              color: Colors.purple[100],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: widget.items.map(
                      (String item) {
                        var item1 = item;
                        if (item == '') {
                          item1 = widget.hint;
                        }

                        // print('9898988999898989898988 $item1');
                        return DropdownMenuItem<String>(
                          value: item1,
                          child: Text(
                            item1,
                            // style: AppStyles.poppins.copyWith(
                            //   fontSize: 12.w,
                            //   // fontWeight: FontWeight.bold,
                            //   color: Colors.purple,
                            // ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      },
                    ).toList(),
                    style: AppStyles.poppins.copyWith(
                      color: Colors.purple,
                      fontSize: 10.w,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // value: selectedValue == '' ? null : selectedValue,
                    value: data == '' ? null : data,
                    onChanged: (value) {
                      // setState(() {
                      if (value == widget.hint) {
                        // selectedValue = '';
                        widget.textStream.add('');
                      } else {
                        // selectedValue = value!;
                        widget.textStream.add(value!);
                        // if (widget.heading == 'Client') {

                        // }else  if (widget.heading == 'Quotation') {

                        // }else if (widget.heading == 'Status'){}
                      }
                      // });
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 35.h,
                      // width: 160,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        // border: Border.all(
                        //   color: Colors.black26
                        // ),
                        // color: Colors.white,
                      ),
                      // elevation: 2,
                    ),
                    iconStyleData: IconStyleData(
                      icon: const Icon(FontAwesomeIcons.angleDown),
                      iconSize: 14.w,
                      iconEnabledColor: Colors.purple[100],
                      iconDisabledColor: Colors.grey,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white,
                      ),
                      // offset: const Offset(-20, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all(6),
                        thumbVisibility: MaterialStateProperty.all(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 14, right: 14),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: -10.h,
            left: 12.w,
            child: Container(
              color: Colors.white,
              child: Text(
                widget.label,
                style: AppStyles.poppins.copyWith(fontSize: 9.w, color: Colors.purple),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CheckInField extends StatefulWidget {
  const CheckInField({
    // required this.controller,
    required this.heading,
    required this.textStream,
    // required this.controller,
    required this.hintText,
    this.icon,
    this.suffixIcon,
    this.isObscure = false,
    this.enabled = true,
    this.validator,
    this.keyboardType,
    this.onTap,
    this.onChanged,
    // this.initialValue = '',
    this.textInputType = TextInputType.name,
    this.isLargeField = false,
    this.isForDateField = false,
    this.isNewLeave = false,
    super.key,
  });

  final bool isForDateField;
  final bool isNewLeave;
  // final TextEditingController controller;
  final String heading;
  // final String initialValue;
  final bool isLargeField;
  final TextInputType textInputType;
  final BehaviorSubject<String> textStream;
  // final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final bool isObscure;
  final bool enabled;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final void Function()? onTap;
  final void Function(String)? onChanged;

  @override
  State<CheckInField> createState() => _CheckInFieldState();
}

class _CheckInFieldState extends State<CheckInField> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.textStream.listen((value) {
      if (value.isEmpty) {
        _controller.clear();
      } else if (_controller.text != value) {
        _controller.text = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: StreamBuilder<Object>(
        stream: widget.textStream,
        builder: (context, snapshot) {
          return InkWell(
            onTap: widget.onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(heading, style: AppStyles.poppins.copyWith(fontSize: 12.w, color: Colors.purple)),
                // SizedBox(height: 7.h),
                SizedBox(
                  // height: widget.isLargeField ? null : 50.h,
                  height: 35.h,
                  child: TextFormField(
                    // initialValue: widget.initialValue,
                    scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom + 15.w * 6, // Adjust the value as needed
                    ),
                    // controller: controller,
                    style: AppStyles.poppins.copyWith(
                      color: Colors.purple,
                      fontSize: 10.w,
                    ),
                    keyboardType: !widget.isLargeField ? widget.textInputType : TextInputType.multiline,
                    // minLines: !isLargeField ? null : 1,
                    // maxLines: !isLargeField ? null : 20,
                    // maxLength: !isLargeField ? null : 500,
                    // expands:isLargeField ,
                    // maxLines: null,
                    controller: _controller,
                    validator: widget.validator,
                    onChanged: widget.onChanged,
                    // onTap: widget.onTap,
                    obscuringCharacter: '*',
                    obscureText: widget.isObscure,
                    enabled: widget.enabled,
                    decoration: InputDecoration(
                      // isDense: true,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: widget.heading,
                      labelStyle: AppStyles.poppins.copyWith(fontSize: 12.w, color: Colors.purple),
                      hintText: widget.hintText,
                      hintStyle: AppStyles.openSans.copyWith(
                        color: Colors.purple[100],
                        fontSize: 10.w,
                      ),
                      contentPadding: EdgeInsets.only(left: 15.w),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color.fromARGB(139, 103, 51, 137)),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color.fromARGB(139, 103, 51, 137)),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color.fromARGB(255, 152, 102, 185)),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
