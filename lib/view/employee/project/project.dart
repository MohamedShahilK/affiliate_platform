// ignore_for_file: lines_longer_than_80_chars, inference_failure_on_instance_creation

import 'package:affiliate_platform/config/ripple.dart';
import 'package:affiliate_platform/logic/employee/project/project_bloc.dart';
import 'package:affiliate_platform/models/employee/project/get_all_projects.dart';
import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/view/common/custom_header.dart';
import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:affiliate_platform/view/common/sidebar.dart';
import 'package:affiliate_platform/view/employee/project/new_project.dart';
import 'package:affiliate_platform/view/employee/project/view_project.dart';
import 'package:affiliate_platform/view/manage_contact/manage_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  var _refreshKey = UniqueKey();

  // To update or hot reload
  void _handleLocaleChanged() => setState(() {
        _refreshKey = UniqueKey();
      });

  @override
  Widget build(BuildContext context) {
    final projectBloc = Provider.of<ProjectBloc>(context);
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
              builder: (context) => const NewProject(),
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
                    stream: projectBloc.getAllProjectsStream,
                    builder: (context, getAllProjectsStreamsnapshot) {
                      if ((!getAllProjectsStreamsnapshot.hasData && getAllProjectsStreamsnapshot.connectionState != ConnectionState.waiting) || getAllProjectsStreamsnapshot.hasError) {
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
                                  await projectBloc.getAllProjects();
                                },
                                borderRadius: BorderRadius.circular(15.r),
                                overlayColor: Colors.purple.withOpacity(.15),
                              ),
                            ],
                          ),
                        );
                      }

                      // print('2222222222222222222222222222222222222222222222 ${snapshot.data}');

                      GetAllProjects? allProjectsRespModel;

                      List<ProjectList>? projectList = [];

                      if (getAllProjectsStreamsnapshot.hasData) {
                        allProjectsRespModel = getAllProjectsStreamsnapshot.data;
                        if (allProjectsRespModel!.data != null && allProjectsRespModel.data!.isNotEmpty) {
                          projectList = allProjectsRespModel.data?[0].projectList ?? [];
                        }
                      }

                      // print('232314343 ${projectList}');

                      return Skeletonizer(
                        enabled: getAllProjectsStreamsnapshot.connectionState == ConnectionState.waiting,
                        child: Padding(
                          padding: EdgeInsets.only(top: 30.h, bottom: 5.h, left: 20.w, right: 20.w),
                          child: Column(
                            children: List.generate(
                              (allProjectsRespModel == null) ? 5 : allProjectsRespModel.data![0].projectList!.length,
                              (index) => _ProjectCard(index: index, model: allProjectsRespModel,contactId: allProjectsRespModel?.data![0].projectList![index].id),
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
    this.contactId,
    super.key,
  });

  final String? contactId;
  final int index;
  final GetAllProjects? model;

  @override
  Widget build(BuildContext context) {
    final status = model?.data == null || model!.data!.isEmpty || model!.data![0].projectList!.isEmpty || model!.data![0].projectList!.isEmpty
        ? 'status'
        : model?.data![0].projectStatus![int.parse(model?.data![0].projectList![index].status ?? '1')] == 'status'
            ? 'status'
            : model?.data![0].projectStatus![int.parse(model?.data![0].projectList![index].status ?? '1')] ?? 'status';
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
                Text(
                  // 'Giridhar | Qtn2015',
                  'Project #${index + 1}',
                  // '1',
                  style: AppStyles.poppins.copyWith(color: Colors.grey[800], fontSize: 9.w, fontWeight: FontWeight.w900),
                ),
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
                            Icon(Icons.book_outlined, size: 17.w, color: Colors.purple[400]),
                            SizedBox(width: 5.w),
                            SizedBox(
                              width: 90.w,
                              // child: Text(
                              //   // 'Mr. Lallit Potter',
                              //   widget.name,
                              //   style: AppStyles.poppins.copyWith(color: Colors.grey[800], fontSize: 12.w, overflow: TextOverflow.ellipsis),
                              // ),
                              child: MyTextWidget(
                                text: model?.data == null || model!.data!.isEmpty || model!.data![0].projectList!.isEmpty
                                    ? '-'
                                    : model?.data![0].projectList![index].name == ''
                                        ? '-'
                                        : model?.data![0].projectList![index].name ?? '-',
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
                            Icon(Icons.person_2_outlined, size: 17.w, color: Colors.purple[400]),
                            SizedBox(width: 5.w),
                            SizedBox(
                              width: 90.w,
                              // child: Text(
                              //   // 'R.K.I.F',
                              //   widget.model.companyName,
                              //   style: AppStyles.poppins.copyWith(color: Colors.grey[800], fontSize: 12.w, overflow: TextOverflow.ellipsis),
                              // ),
                              child: MyTextWidget(
                                text: model?.data == null || model!.data!.isEmpty || model!.data![0].projectList!.isEmpty
                                    ? '-'
                                    : model?.data![0].projectList![index].contactName == ''
                                        ? '-'
                                        : model?.data![0].projectList![index].contactName ?? '-',
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
                                // Icon(Icons.email_outlined, size: 17.w),
                                // SizedBox(width: 5.w),
                                SizedBox(
                                  width: 70.w,
                                  // child: Text(
                                  //   // 'info@sgtf.ae',
                                  //   widget.model.email,
                                  //   style: AppStyles.poppins.copyWith(color: Colors.grey[800], fontSize: 12.w, overflow: TextOverflow.ellipsis),
                                  // ),
                                  child: MyTextWidget(
                                    text: model?.data == null || model!.data!.isEmpty || model!.data![0].projectList!.isEmpty
                                        ? '-'
                                        : model?.data![0].projectList![index].quotationRefr == ''
                                            ? '-'
                                            : model?.data![0].projectList![index].quotationRefr ?? '-',
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
                                //   'Company Name: ',
                                //   style: AppStyles.poppins.copyWith(fontWeight: FontWeight.w900, color: Colors.grey[800], fontSize: 12.w),
                                // ),
                                // Icon(Icons., size: 17.w),
                                // SizedBox(width: 5.w),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                                  decoration: BoxDecoration(color: _statusColor(status: status), borderRadius: BorderRadius.circular(15.r)),
                                  child: Text(
                                    status,
                                    // 'Active',
                                    // style: GoogleFonts.poppins().copyWith(color: Colors.grey[800], fontSize: 12.w),
                                    style: GoogleFonts.poppins().copyWith(color: Colors.white, fontSize: 10.w),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        //
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _EachProjectSmallButtons(
                              color: Colors.green[900]!,
                              icon: Icons.edit_outlined,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>  NewProject(contactId: contactId),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 3.h),
                            _EachProjectSmallButtons(
                              color: Colors.blue[400]!,
                              icon: Icons.remove_red_eye_outlined,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>  ViewProject(contactId: contactId),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 3.h),
                            _EachProjectSmallButtons(
                              color: Colors.red[400]!,
                              icon: Icons.delete_outline_outlined,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                //  SizedBox(height: 15.h),

                //     //
                //     Column(
                //       mainAxisAlignment: MainAxisAlignment.end,
                //       children: [
                //         _EachProjectSmallButtons(
                //           color: Colors.green[900]!,
                //           icon: Icons.edit_outlined,
                //           onTap: () {},
                //         ),
                //         _EachProjectSmallButtons(
                //           color: Colors.blue[400]!,
                //           icon: Icons.remove_red_eye_outlined,
                //           onTap: () {},
                //         ),
                //         _EachProjectSmallButtons(
                //           color: Colors.red[400]!,
                //           icon: Icons.delete_outline_outlined,
                //           onTap: () {},
                //         ),
                //       ],
                //     )
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
    required this.color,
    required this.icon,
    required this.onTap,
  });

  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
          decoration: BoxDecoration(
            // color: color,
            color: Colors.purple[400],
            // borderRadius: BorderRadius.only(topRight: Radius.circular(15.r), bottomLeft: Radius.circular(15.r)),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 16.w,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 5.w),
      ],
    ).ripple(context, onTap);
  }
}
