// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/app.dart';
import 'package:affiliate_platform/config/ripple.dart';
import 'package:affiliate_platform/logic/employee/leave/leave_bloc.dart';
import 'package:affiliate_platform/models/employee/leave/leave_form_model.dart';
import 'package:affiliate_platform/models/employee/leave/leave_model.dart';
import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/utils/custom_tools.dart';
import 'package:affiliate_platform/utils/utility_functions.dart';
import 'package:affiliate_platform/view/common/custom_header.dart';
import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:affiliate_platform/view/employee/leave/new_leave.dart';
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

class LeavePage extends StatefulWidget {
  const LeavePage({super.key});

  @override
  State<LeavePage> createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage> {
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
    final leaveBloc = Provider.of<LeaveBloc>(context);
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
              builder: (context) => const NewLeave(),
            ),
          );
        },
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              Scaffold.of(context).closeDrawer();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const CustomHeader(),

                  //
                  StreamBuilder(
                    stream: leaveBloc.getLeaveFormStream,
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
                                await leaveBloc.getLeaveForm();
                              },
                              borderRadius: BorderRadius.circular(15.r),
                              overlayColor: Colors.purple.withOpacity(.15),
                            ),
                          ],
                        );
                      }

                      GetLeaveForm? leaveFormModel;

                      if (getCheckInFormStreamsnapshot.hasData) {
                        leaveFormModel = getCheckInFormStreamsnapshot.data;
                      }
                      return StreamBuilder(
                        stream: leaveBloc.getAllLeavesStream,
                        builder: (context, getAllLeavesStreamsnapshot) {
                          if ((!getAllLeavesStreamsnapshot.hasData && getAllLeavesStreamsnapshot.connectionState != ConnectionState.waiting) || getAllLeavesStreamsnapshot.hasError) {
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
                                    await leaveBloc.getAllLeaves();
                                  },
                                  borderRadius: BorderRadius.circular(15.r),
                                  overlayColor: Colors.purple.withOpacity(.15),
                                ),
                              ],
                            );
                          }

                          GetAllLeaves? allLeavesRespModel;

                          // List<CheckoutData>? checkinData = [];

                          if (getAllLeavesStreamsnapshot.hasData) {
                            allLeavesRespModel = getAllLeavesStreamsnapshot.data;
                            // if (allLeavesRespModel!.data != null && allLeavesRespModel.data!.isNotEmpty) {
                            //   checkinData = allLeavesRespModel.data?[0].checkoutData ?? [];
                            // }
                          }

                          if (blocOficialLoaderNotifier.value) {
                            allLeavesRespModel = null;
                          }

                          return Skeletonizer(
                            enabled: getAllLeavesStreamsnapshot.connectionState == ConnectionState.waiting || blocOficialLoaderNotifier.value,
                            child: Padding(
                              padding: EdgeInsets.only(top: 30.h, bottom: 5.h, left: 20.w, right: 20.w),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CheckInDropDown(
                                          textStream: leaveBloc.employeeFilterStream,
                                          heading: 'Employee',
                                          hint: 'Select Employee',
                                          // items:leaveFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                          items: (leaveFormModel != null &&
                                                  leaveFormModel.data != null &&
                                                  leaveFormModel.data!.isNotEmpty &&
                                                  leaveFormModel.data?[0].employeeList != null &&
                                                  leaveFormModel.data![0].employeeList!.isNotEmpty)
                                              ? ['', ...leaveFormModel.data![0].employeeList?.map((e) => e.firstName ?? '') ?? []]
                                              : [''],
                                          label: 'Employee',
                                        ),
                                      ),
                                      SizedBox(width: 20.w),
                                      Expanded(
                                        child: CheckInDropDown(
                                          textStream: leaveBloc.leaveTypeFilterStream,
                                          heading: 'Leave Type',
                                          hint: 'Select Leave Type',
                                          // items:leaveFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                          items: (leaveFormModel != null &&
                                                  leaveFormModel.data != null &&
                                                  leaveFormModel.data!.isNotEmpty &&
                                                  leaveFormModel.data?[0].leavesType != null &&
                                                  leaveFormModel.data![0].leavesType!.isNotEmpty)
                                              ? ['', ...leaveFormModel.data![0].leavesType?.map((e) => e.name ?? '') ?? []]
                                              : [''],
                                          label: 'Leave Type',
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
                                          textStream: leaveBloc.leaveFromDateFilterStream,
                                          // onChanged: bloc.checkinTimeStream.add,
                                          onTap: () async {
                                            // print('132131231231232113 ${DateFormat('yyyy-MM-dd').parse(bloc.leaveStartDateStream.value)}');

                                            final date = await _selectDate(context);

                                            if (date != null) {
                                              leaveBloc.leaveFromDateFilterStream.add(date);
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
                                          textStream: leaveBloc.leaveToDateFilterStream,
                                          // onChanged: bloc.checkinTimeStream.add,
                                          onTap: () async {
                                            final date = await _selectDate(context);

                                            if (date != null) {
                                              leaveBloc.leaveToDateFilterStream.add(date);
                                            }
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: CheckInDropDown(
                                          textStream: leaveBloc.leaveStatusFilterStream,
                                          heading: 'Leave Status',
                                          hint: 'Select Leave Status',
                                          // items:leaveFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                          items: const ['', 'Pending', 'Approval', 'Reject'],
                                          label: 'Leave Status',
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

                                      String? leaveTypeId;

                                      if (leaveBloc.leaveTypeFilterStream.value != '') {
                                        leaveTypeId = leaveFormModel?.data?[0].leavesType?.firstWhere((e) => e.name == leaveBloc.leaveTypeFilterStream.value).id;
                                      }

                                      String? approvalStatusId;

                                      if (leaveBloc.leaveStatusFilterStream.value != '') {
                                        approvalStatusId = leaveStatusId(status: leaveBloc.leaveStatusFilterStream.value);
                                      }

                                      if (leaveBloc.leaveFromDateFilterStream.value != '' &&
                                          leaveBloc.leaveToDateFilterStream.value != '' &&
                                          UtilityFunctions.isSecondDateBeforeFirst(
                                            firstDateStr: leaveBloc.leaveFromDateFilterStream.value,
                                            secondDateStr: leaveBloc.leaveToDateFilterStream.value,
                                          )) {
                                        await erroMotionToastInfo(context, msg: 'To Date must not be earlier than From Date');
                                        Loader.hide();
                                        return;
                                      }

                                      try {
                                        print('22222222222222222222222222 $leaveTypeId');
                                        // print('22222222222222222222222222 $approvalStatusId');
                                        await leaveBloc.getAllLeaves(
                                          leaveTypeId: leaveTypeId,
                                          leaveApprovalStatusId: approvalStatusId,
                                        );
                                        Loader.hide();
                                      } catch (e) {
                                        Loader.hide();
                                      } finally {
                                        Loader.hide();
                                      }
                                    }),
                                  ),
                                  if (allLeavesRespModel != null &&
                                      allLeavesRespModel.data != null &&
                                      allLeavesRespModel.data!.isNotEmpty &&
                                      allLeavesRespModel.data![0].leavesList != null &&
                                      allLeavesRespModel.data![0].leavesList!.isEmpty)
                                    const Center(child: Text('No Data Found'))
                                  else
                                    Column(
                                      children: List.generate(
                                        (allLeavesRespModel == null) ? 5 : allLeavesRespModel.data![0].leavesList!.length,
                                        (index) => _ProjectCard(
                                          index: index,
                                          model: allLeavesRespModel,
                                          isLoading: getAllLeavesStreamsnapshot.connectionState == ConnectionState.waiting,
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

  String leaveStatusId({required String status}) {
    if (status == 'Pending') {
      return '1';
    } else if (status == 'Approval') {
      return '2';
    } else if (status == 'Reject') {
      return '3';
    } else {
      return '1';
    }
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
  final GetAllLeaves? model;
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
                    Builder(
                      builder: (context) {
                        final durationId = model?.data == null || model!.data!.isEmpty || model!.data![0].leavesList!.isEmpty
                            ? '3'
                            : model?.data![0].leavesList![index].leaveDuration == ''
                                ? '3'
                                : model?.data![0].leavesList![index].leaveDuration ?? '3';

                        final durationName = getLeaveDuration(durationId: durationId);

                        return Row(
                          children: [
                            Text(
                              // 'Giridhar | Qtn2015',
                              'Leave #${index + 1}',
                              // '1',
                              style: AppStyles.poppins.copyWith(color: Colors.grey[800], fontSize: 9.w, fontWeight: FontWeight.w900),
                            ),
                            SizedBox(width: 7.w),
                            Text(
                              // 'Giridhar | Qtn2015',
                              '($durationName)',
                              // '1',
                              style: AppStyles.poppins.copyWith(color: Colors.grey[800], fontSize: 9.w, fontWeight: FontWeight.w900),
                            ),
                          ],
                        );
                      },
                    ),
                    const Spacer(),
                    Builder(
                      builder: (context) {
                        final durationId = model?.data == null || model!.data!.isEmpty || model!.data![0].leavesList!.isEmpty
                            ? '3'
                            : model?.data![0].leavesList![index].leaveDuration == ''
                                ? '3'
                                : model?.data![0].leavesList![index].leaveDuration ?? '3';

                        final leaveInterval = model?.data == null || model!.data!.isEmpty || model!.data![0].leavesList!.isEmpty
                            ? '1'
                            : model?.data![0].leavesList![index].leavesIntervals == ''
                                ? '1'
                                : model?.data![0].leavesList![index].leavesIntervals ?? '1';

                        return Text(
                          // 'Giridhar | Qtn2015',
                          durationId == '3' ? 'No. of Days : $leaveInterval' : 'No. of Hours : $leaveInterval',
                          // 'No. of Projects : ${model?.data == null || model!.data!.isEmpty || model!.data![0].checkoutData!.isEmpty ? '-' : model?.data![0].checkoutData![index].totalProjects == '' ? '-' : model?.data![0].checkoutData![index].totalProjects ?? '-'}',
                          // '1',
                          style: AppStyles.poppins.copyWith(color: Colors.grey[800], fontSize: 11.w, fontWeight: FontWeight.w900),
                        );
                      },
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
                                // text: 'Shahil (VST-113)',
                                text:
                                    '${model?.data == null || model!.data!.isEmpty || model!.data![0].leavesList!.isEmpty ? '-' : model?.data![0].leavesList![index].firstName == '' ? '-' : model?.data![0].leavesList![index].firstName ?? '-'} (${model?.data == null || model!.data!.isEmpty || model!.data![0].leavesList!.isEmpty ? '-' : model?.data![0].leavesList![index].userCode == '' ? '-' : model?.data![0].leavesList![index].userCode ?? '-'})',
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
                            SizedBox(width: 2.w),
                            Icon(FontAwesomeIcons.s, size: 12.w, color: Colors.purple[400]),
                            SizedBox(width: 5.w),
                            SizedBox(
                              width: 90.w,
                              // child: Text(
                              //   // 'R.K.I.F',
                              //   widget.model.companyName,
                              //   style: AppStyles.poppins.copyWith(color: Colors.grey[800], fontSize: 12.w, overflow: TextOverflow.ellipsis),
                              // ),
                              child: MyTextWidget(
                                text: model?.data == null || model!.data!.isEmpty || model!.data![0].leavesList!.isEmpty
                                    ? '-'
                                    : model?.data![0].leavesList![index].leaveStartDate == ''
                                        ? '-'
                                        : UtilityFunctions.convertIntoNormalDateStringFromDateTimeString(model?.data![0].leavesList![index].leaveStartDate ?? '2014-05-27'),
                                // text: '22-05-2024',
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
                                SizedBox(width: 2.w),
                                Icon(FontAwesomeIcons.e, size: 12.w, color: Colors.purple[400]),
                                SizedBox(width: 5.w),
                                SizedBox(
                                  // width: 70.w,
                                  // child: Text(
                                  //   // 'info@sgtf.ae',
                                  //   widget.model.email,
                                  //   style: AppStyles.poppins.copyWith(color: Colors.grey[800], fontSize: 12.w, overflow: TextOverflow.ellipsis),
                                  // ),
                                  child: MyTextWidget(
                                    text: model?.data == null || model!.data!.isEmpty || model!.data![0].leavesList!.isEmpty
                                        ? '-'
                                        : model?.data![0].leavesList![index].leaveEndDate == ''
                                            ? '-'
                                            : UtilityFunctions.convertIntoNormalDateStringFromDateTimeString(model?.data![0].leavesList![index].leaveEndDate ?? '2014-05-27'),
                                    // text: '25-05-2024',
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
                                Icon(Icons.sick_outlined, size: 17.w, color: Colors.purple[400]),
                                SizedBox(width: 5.w),
                                SizedBox(
                                  width: 70.w,
                                  // child: Text(
                                  //   // 'info@sgtf.ae',
                                  //   widget.model.email,
                                  //   style: AppStyles.poppins.copyWith(color: Colors.grey[800], fontSize: 12.w, overflow: TextOverflow.ellipsis),
                                  // ),
                                  child: MyTextWidget(
                                    text: model?.data == null || model!.data!.isEmpty || model!.data![0].leavesList!.isEmpty
                                        ? '-'
                                        : model?.data![0].leavesList![index].leavesTypeName == ''
                                            ? '-'
                                            : model?.data![0].leavesList![index].leavesTypeName ?? '-',
                                    // text: 'Sick leave (Illness or Injury)',
                                    isRightItem: true,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 15.h),

                //

                Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (model?.data![0].leavesList![index].approvalStatus == '1')
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          color: Colors.orange[700],
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Text(
                          'Pending',
                          style: TextStyle(fontSize: 12.w, color: Colors.white),
                        ),
                      ),
                    if (model?.data![0].leavesList![index].approvalStatus == '2')
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          color: Colors.green[700],
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Text(
                          'Approved',
                          style: TextStyle(fontSize: 12.w, color: Colors.white),
                        ),
                      ),
                    if (model?.data![0].leavesList![index].approvalStatus == '3')
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          color: Colors.red[700],
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Text(
                          'Rejected',
                          style: TextStyle(fontSize: 12.w, color: Colors.white),
                        ),
                      ),
                    const Spacer(),
                    if (model?.data![0].leavesList![index].approvalStatus == '1')
                      _EachProjectSmallButtons(
                        // color: Colors.green[900]!,
                        isLoading: isLoading,
                        icon: Icons.edit_outlined,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewLeave(
                              leaveModel: model?.data![0].leavesList![index],
                            ),
                          ),
                        ),
                      ),
                    if (model?.data![0].leavesList![index].approvalStatus == '1')
                      _EachProjectSmallButtons(
                        // color: Colors.red[400]!,
                        isLoading: isLoading,
                        icon: Icons.delete_outline_outlined,
                        onTap: () async {
                          final isTrue = await showWarningDialog(
                            context,
                            title: 'Remove Leave',
                            description: 'Are you sure want to delete the leave?',
                            yes: 'Delete',
                            no: 'Cancel',
                          );

                          if (isTrue != null && isTrue) {
                            final leaveId = model?.data == null || model!.data!.isEmpty || model!.data![0].leavesList == null || model!.data![0].leavesList!.isEmpty
                                ? '-'
                                : model?.data![0].leavesList![index].id == ''
                                    ? '-'
                                    : model?.data![0].leavesList![index].id ?? '-';
                            // ignore: use_build_context_synchronously
                            customLoader(context);
                            // ignore: use_build_context_synchronously
                            final jsonData = await context.read<LeaveBloc>().deleteLeave(leaveId: leaveId);
                            if (jsonData) {
                              // ignore: use_build_context_synchronously
                              await context.read<LeaveBloc>().getAllLeaves();
                              Loader.hide();
                              // ignore: use_build_context_synchronously
                              await successMotionToastInfo(context, msg: 'Leave deleted successfully');
                            } else {
                              Loader.hide();
                              // ignore: use_build_context_synchronously
                              await erroMotionToastInfo(context, msg: "Something wrong!!. Can't able to delete");
                            }
                          }
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
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
