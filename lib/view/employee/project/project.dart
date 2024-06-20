// ignore_for_file: lines_longer_than_80_chars, inference_failure_on_instance_creation, use_build_context_synchronously

import 'package:affiliate_platform/app.dart';
import 'package:affiliate_platform/config/ripple.dart';
import 'package:affiliate_platform/logic/employee/project/project_bloc.dart';
import 'package:affiliate_platform/models/employee/project/get_all_projects.dart';
import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/utils/custom_tools.dart';
import 'package:affiliate_platform/view/common/custom_header.dart';
import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:affiliate_platform/view/common/sidebar.dart';
import 'package:affiliate_platform/view/employee/project/new_project.dart';
import 'package:affiliate_platform/view/employee/project/view_project.dart';
import 'package:affiliate_platform/view/manage_contact/manage_contact.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  var _refreshKey = UniqueKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // context.read<ProjectBloc>().getAllProjects();
      Loader.hide();
    });
  }

  // To update or hot reload
  void _handleLocaleChanged() => setState(() {
        _refreshKey = UniqueKey();
      });

  @override
  Widget build(BuildContext context) {
    final projectBloc = Provider.of<ProjectBloc>(context);
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
                      print('2222222222222222222222222222222222222 ${getAllProjectsStreamsnapshot.connectionState == ConnectionState.waiting}');
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
                                await projectBloc.getAllProjects();
                              },
                              borderRadius: BorderRadius.circular(15.r),
                              overlayColor: Colors.purple.withOpacity(.15),
                            ),
                          ],
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

                      if (blocOficialLoaderNotifier.value) {
                        allProjectsRespModel = null;
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
                                    child: ProjectField(
                                      heading: 'Project Search',
                                      hintText: 'Project Search',
                                      textStream: projectBloc.projectSearchStream,
                                      onChanged: projectBloc.projectSearchStream.add,
                                    ),
                                  ),
                                  SizedBox(width: 20.w),
                                  Expanded(
                                    child: ProjectDropDown(
                                      textStream: projectBloc.projectStatusStream,
                                      heading: 'Project Status',
                                      hint: 'Select Project Status',
                                      // items:leaveFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                      items: (allProjectsRespModel != null &&
                                              allProjectsRespModel.data != null &&
                                              allProjectsRespModel.data!.isNotEmpty &&
                                              allProjectsRespModel.data?[0].projectStatus != null)
                                          ? ['', ...allProjectsRespModel.data![0].projectStatus ?? []]
                                          : [''],
                                      label: 'Project Status',
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

                                  try {
                                    await projectBloc.getAllProjects(statusId: getStatusId(status: projectBloc.projectStatusStream.value));
                                    Loader.hide();
                                  } catch (e) {
                                    Loader.hide();
                                  } finally {
                                    Loader.hide();
                                  }
                                }),
                              ),
                              if (allProjectsRespModel != null &&
                                  allProjectsRespModel.data != null &&
                                  allProjectsRespModel.data!.isNotEmpty &&
                                  allProjectsRespModel.data![0].projectList != null &&
                                  allProjectsRespModel.data![0].projectList!.isEmpty)
                                const Center(child: Text('Not Data Found'))
                              else
                                Column(
                                  children: List.generate(
                                    (allProjectsRespModel == null) ? 5 : allProjectsRespModel.data![0].projectList!.length,
                                    (index) => _ProjectCard(index: index, model: allProjectsRespModel, projectId: allProjectsRespModel?.data![0].projectList![index].id),
                                  ),
                                ),
                            ],
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

  String getProjectStatusId({required String status}) {
    if (status == 'Inactive') {
      return '0';
    } else if (status == 'Active') {
      return '1';
    } else if (status == 'Completed') {
      return '2';
    } else if (status == 'On Hold') {
      return '3';
    } else {
      return '-1';
    }
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({
    required this.index,
    this.model,
    this.projectId,
    super.key,
  });

  final String? projectId;
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
                                  width: 80.w,
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
                                    builder: (context) => NewProject(projectId: projectId),
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
                                    builder: (context) => ViewProject(projectId: projectId),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 3.h),
                            _EachProjectSmallButtons(
                              color: Colors.red[400]!,
                              icon: Icons.delete_outline_outlined,
                              onTap: () async {
                                final isTrue = await showWarningDialog(
                                  context,
                                  title: 'Remove Project',
                                  description: 'Are you sure want to delete the project?',
                                  yes: 'Delete',
                                  no: 'Cancel',
                                );

                                if (isTrue != null && isTrue) {
                                  customLoader(context);
                                  final jsonData = await context.read<ProjectBloc>().deleteProject(projectId: projectId);

                                  if (jsonData != null && jsonData['status'] == 'SUCCESS' && jsonData['response'] == 'OK') {
                                    await context.read<ProjectBloc>().getAllProjects();
                                    Loader.hide();
                                    await successMotionToastInfo(context, msg: (jsonData['message'] as String?) ?? 'Project deleted successfully');
                                  } else if (jsonData != null && jsonData['response'] == 'OK') {
                                    Loader.hide();
                                    await successMotionToastInfo(context, msg: (jsonData['message'] as String?) ?? 'Project is already deleted');
                                  } else {
                                    Loader.hide();
                                    await erroMotionToastInfo(context, msg: "Something wrong!!. Can't able to delete");
                                  }
                                }
                              },
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

class ProjectDropDown extends StatefulWidget {
  const ProjectDropDown({
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
  State<ProjectDropDown> createState() => _NewContactDropDownState();
}

class _NewContactDropDownState extends State<ProjectDropDown> {
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

class ProjectField extends StatefulWidget {
  const ProjectField({
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
  State<ProjectField> createState() => _ProjectFieldState();
}

class _ProjectFieldState extends State<ProjectField> {
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
