// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/config/ripple.dart';
import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/view/common/custom_header.dart';
import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:affiliate_platform/view/common/sidebar.dart';
import 'package:affiliate_platform/view/employee/project/new_project.dart';
import 'package:affiliate_platform/view/employee/project/view_project.dart';
import 'package:affiliate_platform/view/manage_contact/manage_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

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
                  Padding(
                    padding: EdgeInsets.only(top: 30.h, bottom: 5.h, left: 20.w, right: 20.w),
                    child: const Column(
                      children: [
                        _ProjectCard(index: 0),
                        _ProjectCard(index: 1),
                        _ProjectCard(index: 2),
                        _ProjectCard(index: 3),
                        _ProjectCard(index: 4),
                        _ProjectCard(index: 5),
                        _ProjectCard(index: 6),
                        _ProjectCard(index: 7),
                        _ProjectCard(index: 8),
                        _ProjectCard(index: 9),
                      ],
                    ),
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
    super.key,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
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
                              child: const MyTextWidget(
                                //   text: widget.model?.data1 == null || widget.model!.data1!.isEmpty || widget.model!.data1![0].contacts!.isEmpty
                                //       ? '-'
                                //       : widget.model?.data1![0].contacts![widget.index].name == ''
                                //           ? '-'
                                //           : widget.model?.data1![0].contacts![widget.index].name ?? '-',
                                text: 'AL Fursan',
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
                              child: const MyTextWidget(
                                // text: widget.model?.data1 == null || widget.model!.data1!.isEmpty || widget.model!.data1![0].contacts!.isEmpty
                                //     ? '-'
                                //     : widget.model?.data1![0].contacts![widget.index].company == ''
                                //         ? '-'
                                //         : widget.model?.data1![0].contacts![widget.index].company ?? '-',
                                text: 'Hakkeem Neerad',
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
                                  child: const MyTextWidget(
                                    // text: widget.model?.data1 == null || widget.model!.data1!.isEmpty || widget.model!.data1![0].contacts!.isEmpty
                                    //     ? '-'
                                    //     : widget.model?.data1![0].contacts![widget.index].email == ''
                                    //         ? '-'
                                    //         : widget.model?.data1![0].contacts![widget.index].email ?? '-',
                                    text: '1000 AED',
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
                                  decoration: BoxDecoration(color: _statusColor('Active'), borderRadius: BorderRadius.circular(15.r)),
                                  child: Text(
                                    // '971522627165',
                                    // widget.model?.data1 == null || widget.model!.data1!.isEmpty || widget.model!.data1![0].contacts!.isEmpty
                                    //     ? '-'
                                    //     : widget.model?.data1![0].contacts![widget.index].mobile == ''
                                    //         ? '-'
                                    //         : widget.model?.data1![0].contacts![widget.index].mobile ?? '-',
                                    'Active',
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
                                    builder: (context) => const NewProject(),
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
                                    builder: (context) => const ViewProject(),
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

  Color? _statusColor(status) {
    if (status == 'Active') {
      return Colors.green[600];
    } else if (status == 'Inactive') {
      return Colors.red;
    } else if (status == 'On Hold') {
      return Colors.purple[600];
    } else {
      return Colors.blue[600];
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
