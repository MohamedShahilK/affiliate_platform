// ignore_for_file: lines_longer_than_80_chars, inference_failure_on_instance_creation

import 'package:affiliate_platform/app.dart';
import 'package:affiliate_platform/config/ripple.dart';
import 'package:affiliate_platform/logic/employee/checkin/checkin_bloc.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
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
      onPopInvoked: (didPop) {
        Navigator.pop(context);
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
                          print('11111111111111111111111 $checkinData');
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
                            children: List.generate(
                              (allCheckinsRespModel == null) ? 5 : checkinData.length,
                              (index) => _ProjectCard(
                                index: index,
                                model: allCheckinsRespModel,
                                isLoading: getAllProjectsStreamsnapshot.connectionState == ConnectionState.waiting,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => checkoutStatus == 'No' ? const NewCheckOut() : ViewCheckIn(checkInId: checkInId),
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
                        title: 'Remove Contact',
                        description: 'Are you sure want to delete the contact?',
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
