// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/app.dart';
import 'package:affiliate_platform/config/ripple.dart';
import 'package:affiliate_platform/logic/employee/leave/leave_bloc.dart';
import 'package:affiliate_platform/models/employee/leave/leave_model.dart';
import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/utils/custom_tools.dart';
import 'package:affiliate_platform/utils/utility_functions.dart';
import 'package:affiliate_platform/view/common/custom_header.dart';
import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:affiliate_platform/view/employee/leave/new_leave.dart';
import 'package:affiliate_platform/view/manage_contact/manage_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
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
                    stream: leaveBloc.getAllLeavesStream,
                    builder: (context, getAllLeavesStreamsnapshot) {
                      if ((!getAllLeavesStreamsnapshot.hasData && getAllLeavesStreamsnapshot.connectionState != ConnectionState.waiting) || getAllLeavesStreamsnapshot.hasError) {
                        Loader.hide();
                        return Expanded(
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
                          ),
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
                            children: List.generate(
                              (allLeavesRespModel == null) ? 5 : allLeavesRespModel.data![0].leavesList!.length,
                              (index) => _ProjectCard(
                                index: index,
                                model: allLeavesRespModel,
                                isLoading: getAllLeavesStreamsnapshot.connectionState == ConnectionState.waiting,
                              ),
                            ),
                          ),
                        ),
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
