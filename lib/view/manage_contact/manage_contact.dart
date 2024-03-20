// ignore_for_file: lines_longer_than_80_chars, inference_failure_on_instance_creation

import 'dart:async';

import 'package:affiliate_platform/config/ripple.dart';
import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/utils/custom_tools.dart';
import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:affiliate_platform/view/common/sidebar.dart';
import 'package:affiliate_platform/view/manage_contact/data_sample.dart';
import 'package:affiliate_platform/view/manage_contact/new_contact.dart';
import 'package:affiliate_platform/view/manage_contact/view_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class ManageContactPage extends StatefulWidget {
  const ManageContactPage({super.key});

  @override
  State<ManageContactPage> createState() => _ManageContactPageState();
}

class _ManageContactPageState extends State<ManageContactPage> {
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
      child: GestureDetector(
        // onTap: _handleLocaleChanged,
        onTap: () {
          _handleLocaleChanged();
          menuVisibility.value = false;
          menuVisibility.notifyListeners();
        },
        child: CustomScaffold(
          key: _refreshKey,
          onTapFloatingButton: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NewContact(),
              ),
            );
          },
          body: Column(
            children: [
              const CustomHeader(),
              // Align(
              //   alignment: Alignment.topRight,
              //   child: Padding(
              //     padding: EdgeInsets.only(right: 15.w, top: 3.h, bottom: 3.h),
              //     child: ElevatedButton(
              //       onPressed: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => const NewContact(),
              //           ),
              //         );
              //       },
              //       child: Text(
              //         'Create New Contact',
              //         style: AppStyles.poppins.copyWith(fontSize: 10.w, fontWeight: FontWeight.w700, color: Colors.purple[800]),
              //       ),
              //     ),
              //   ),
              // ),

              //
              //
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Column(
                      children: [
                        SizedBox(height: 15.h),
                        // _CustomExpansionTile(),
                        // _CustomExpansionTile(),
                        // _CustomExpansionTile(),
                        // _CustomExpansionTile(),
                        // _CustomExpansionTile(),
                        // _CustomExpansionTile(),
                        // _CustomExpansionTile(),
                        // _CustomExpansionTile(),
                        // _CustomExpansionTile(),

                        ...List.generate(sampleList['contacts']!.length, (index) {
                          final list = sampleList['contacts']?[index];
                          final model = Contact.fromJson(list ?? {});
                          return _CustomExpansionTile(
                            model: model,
                            index: index,
                          );
                        }),
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
}

class _CustomExpansionTile extends StatefulWidget {
  const _CustomExpansionTile({
    // required this.user,
    // required this.type,
    // required this.name,
    // required this.companyName,
    // required this.email,
    // required this.phone,
    // required this.followupMsg,
    // required this.followupDate,
    required this.index,
    required this.model,
  });

  // final String user;
  // final String type;
  // final String name;
  // final String companyName;
  // final String email;
  // final String phone;
  // final String followupMsg;
  // final String followupDate;
  final int index;
  final Contact model;

  @override
  State<_CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<_CustomExpansionTile> {
  bool showAllIcons = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.h),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,

          // iconTheme: IconThemeData(color: Colors.red)
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: ExpansionTile(
            trailing: const SizedBox.shrink(),
            // iconColor: Colors.grey[100],
            tilePadding: EdgeInsets.zero,
            collapsedIconColor: Colors.purple[400],
            title: SizedBox(
              // height: 150.h,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 5.h, bottom: 5.h, left: 20.w, right: 0.w),
                    // margin: EdgeInsets.symmetric(horizontal: 5.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      // border: Border.all(color:  Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Row(
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
                                Icon(Icons.person_2_outlined, size: 17.w),
                                SizedBox(width: 5.w),
                                SizedBox(
                                  width: 90.w,
                                  // child: Text(
                                  //   // 'Mr. Lallit Potter',
                                  //   widget.name,
                                  //   style: AppStyles.poppins.copyWith(color: Colors.grey[800], fontSize: 12.w, overflow: TextOverflow.ellipsis),
                                  // ),
                                  child: MyTextWidget(text: widget.model.name),
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
                                Icon(Icons.business, size: 17.w),
                                SizedBox(width: 5.w),
                                SizedBox(
                                  width: 90.w,
                                  // child: Text(
                                  //   // 'R.K.I.F',
                                  //   widget.model.companyName,
                                  //   style: AppStyles.poppins.copyWith(color: Colors.grey[800], fontSize: 12.w, overflow: TextOverflow.ellipsis),
                                  // ),
                                  child: MyTextWidget(text: widget.model.companyName),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // Text(
                                //   'Name: ',
                                //   style: AppStyles.poppins.copyWith(fontWeight: FontWeight.w900, color: Colors.grey[800], fontSize: 12.w),
                                // ),
                                Icon(Icons.email_outlined, size: 17.w),
                                SizedBox(width: 5.w),
                                SizedBox(
                                  width: 90.w,
                                  // child: Text(
                                  //   // 'info@sgtf.ae',
                                  //   widget.model.email,
                                  //   style: AppStyles.poppins.copyWith(color: Colors.grey[800], fontSize: 12.w, overflow: TextOverflow.ellipsis),
                                  // ),
                                  child: MyTextWidget(text: widget.model.email, isRightItem: true),
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
                                Icon(Icons.phone_outlined, size: 17.w),
                                SizedBox(width: 5.w),
                                Text(
                                  // '971522627165',
                                  widget.model.phoneNumber,
                                  style: GoogleFonts.poppins().copyWith(color: Colors.grey[800], fontSize: 12.w),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // For Sales Person
                  Positioned(
                    // top: -18.h,
                    top: -22.h,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.only(right: 8.w, bottom: 15.h, left: 8.w, top: 2.h),
                      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(15.r)),
                      child: Row(
                        children: [
                          // Container(
                          //   height: 22.w,
                          //   width: 22.w,
                          //   decoration: const BoxDecoration(
                          //     shape: BoxShape.circle,
                          //     color: Colors.white,
                          //     image: DecorationImage(image: AssetImage('assets/images/user.png')),
                          //   ),
                          // ),
                          // SizedBox(width: 5.w),
                          Text(
                            // 'Giridhar | Qtn2015',
                            'Contact #${widget.index + 1}',
                            style: AppStyles.poppins.copyWith(color: Colors.grey[800], fontSize: 9.w, fontWeight: FontWeight.w900),
                          ),
                          // SizedBox(width: 3.w),
                          // Text(
                          //   'Qtn2015',
                          //   style: AppStyles.poppins.copyWith(color: Colors.blueGrey, fontSize: 9.w),
                          // ),
                          // SizedBox(width: 2.w),
                          // Container(
                          //   padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                          //   decoration: BoxDecoration(color: Colors.cyan[900], borderRadius: BorderRadius.circular(15.r)),
                          //   child: Text('Qtn2015', style: AppStyles.poppins.copyWith(fontSize: 7.w, color: Colors.white)),
                          // ),
                        ],
                      ),
                    ),
                  ),

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
            ),
            children: [
              Container(
                // padding: EdgeInsets.only(top: 5.h, bottom: 10.h, left: 20.w, right: 40.w),
                padding: EdgeInsets.only(top: 5.h, bottom: 10.h, left: 20.w, right: 20.w),
                // child: GridView(
                //   shrinkWrap: true,
                //   gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 20.h),
                //   children: [
                //     Row(
                //       children: [
                //         Text(
                //           'Contact Source: ',
                //           style: AppStyles.poppins.copyWith (fontWeight: FontWeight.w900, color: Colors.grey[800], fontSize: 12.w),
                //         ),
                //         Text(
                //           'NA',
                //           style: TextStyle(color: Colors.grey[800], fontSize: 12.w),
                //         ),
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Text(
                //           'Contact Destination: ',
                //           style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey[800], fontSize: 12.w),
                //         ),
                //         Text(
                //           'NA',
                //           style: TextStyle(color: Colors.grey[800], fontSize: 12.w),
                //         ),
                //       ],
                //     ),
                //      Row(
                //       children: [
                //         Text(
                //           'Company Location: ',
                //           style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey[800], fontSize: 12.w),
                //         ),
                //         Text(
                //           'NA',
                //           style: TextStyle(color: Colors.grey[800], fontSize: 12.w),
                //         ),
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Text(
                //           'Company Address: ',
                //           style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey[800], fontSize: 12.w),
                //         ),
                //         Text(
                //           'NA',
                //           style: TextStyle(color: Colors.grey[800], fontSize: 12.w),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 4.h),
                      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(15.r)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText(
                            'Next Followup : ',
                            style: AppStyles.poppins.copyWith(fontWeight: FontWeight.w900, color: Colors.purple[900], fontSize: 11.w),
                          ),
                          SizedBox(height: 2.h),
                          SelectableText(
                            // "I hope you're doing well. I wanted to touch base regarding the custom software development project for XYZ Corporation. Following our recent discussions, our team has been actively refining the project scope and strategies to ensure we meet your needs effectively.",
                            widget.model.sampleFollowupMessage,
                            // 'NA',
                            style: TextStyle(color: Colors.grey[800], fontSize: 10.w),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 4.h),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                              decoration: BoxDecoration(color: Colors.grey[600], borderRadius: BorderRadius.circular(15.r)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Date: ',
                                    style: AppStyles.poppins.copyWith(fontWeight: FontWeight.w900, color: Colors.white, fontSize: 8.w),
                                  ),
                                  Text(
                                    // '18/04/2024',
                                    widget.model.followupDate,
                                    // 'NA',
                                    style: TextStyle(color: Colors.white, fontSize: 8.w),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 4.h),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            color: Colors.green[600],
                            borderRadius: BorderRadius.circular(15.r),
                            // shape: BoxShape.circle,
                          ),
                          child: Text(
                            'Follow Up',
                            // 'F',
                            style: AppStyles.poppins.copyWith(color: Colors.white, fontSize: 12.w),
                          ),
                        ).ripple(context, () {
                          _followUpDialog(context);
                        }),
                        // SizedBox(width: 5.w),
                        const Spacer(),

                        Visibility(
                          visible: showAllIcons,
                          child: Row(
                            children: [
                              _EachContachSmallButtons(
                                color: Colors.black45,
                                icon: Icons.keyboard_arrow_right_rounded,
                                onTap: () {
                                  setState(() {
                                    showAllIcons = false;
                                  });
                                },
                              ),
                              _EachContachSmallButtons(
                                color: Colors.orange[600]!,
                                icon: Icons.email_outlined,
                                onTap: () {
                                  String? encodeQueryParameters(Map<String, String> params) {
                                    return params.entries.map((MapEntry<String, String> e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
                                  }

                                  final emailLaunchUri = Uri(
                                    scheme: 'mailto',
                                    path: widget.model.email,
                                    query: encodeQueryParameters(<String, String>{
                                      'subject': 'Example Subject & Symbols are allowed!',
                                    }),
                                  );

                                  UrlLauncher.launchUrl(emailLaunchUri);
                                },
                              ),
                              _EachContachSmallButtons(
                                color: Colors.blue[700]!,
                                icon: Icons.phone_outlined,
                                onTap: () {
                                  UrlLauncher.launchUrl(Uri.parse('tel://${widget.model.phoneNumber.contains('+') ? widget.model.phoneNumber : '+971${widget.model.phoneNumber}'}'));
                                },
                              ),
                              // _EachContachSmallButtons(
                              //   color: Colors.green[500]!,
                              //   icon: FontAwesomeIcons.whatsapp,
                              //   onTap: () async {
                              //     final whatsappUrl = 'whatsapp://send?phone=${widget.model.phoneNumber.contains('+') ? widget.model.phoneNumber : '+971${widget.model.phoneNumber}'}';
                              //     await UrlLauncher.canLaunchUrl(Uri.parse(whatsappUrl))
                              //         ? UrlLauncher.launchUrl(Uri.parse(whatsappUrl))
                              //         // ignore: use_build_context_synchronously
                              //         : await erroMotionToastInfo(context, msg: 'WhatsApp is not installed');
                              //   },
                              // ),
                              _EachContachSmallButtons(
                                color: Colors.purple[900]!,
                                icon: Icons.edit_outlined,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>  NewContact(model:widget.model),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                        Visibility(
                          visible: !showAllIcons,
                          child: Row(
                            children: [
                              _EachContachSmallButtons(
                                color: Colors.black45,
                                icon: Icons.more_horiz,
                                onTap: () {
                                  setState(() {
                                    showAllIcons = true;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        _EachContachSmallButtons(
                          color: Colors.blue[400]!,
                          icon: Icons.remove_red_eye_outlined,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewContact(model: widget.model),
                              ),
                            );
                          },
                        ),
                        _EachContachSmallButtons(
                          color: Colors.red[400]!,
                          icon: Icons.delete_outline_outlined,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _followUpDialog(BuildContext context) {
    // ignore: inference_failure_on_function_invocation
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        actionsPadding: EdgeInsets.zero,
        iconPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        // insetPadding: EdgeInsets.zero,
        // insetPadding: const EdgeInsets.symmetric(
        //   horizontal: 70,
        // ),
        insetPadding: EdgeInsets.only(
          bottom: 50.h,
          left: 15.w,
          right: 15.w,
        ),
        titlePadding: EdgeInsets.zero,
        content: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(),
                  Text(
                    'No Followups Found!!',
                    style: AppStyles.poppins.copyWith(fontSize: 10.w, fontWeight: FontWeight.w700, color: Colors.red),
                  ),

                  SizedBox(height: 10.h),

                  // New Follow up add button
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                    decoration: BoxDecoration(color: Colors.purple[400], borderRadius: BorderRadius.circular(15.r)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add,
                          size: 13.w,
                          color: Colors.white,
                        ),
                        Text(
                          'Add Followup',
                          style: AppStyles.poppins.copyWith(fontSize: 10.w, fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 5.h,
              right: 10.w,
              child: Container(
                height: 15.w,
                width: 15.w,
                decoration: BoxDecoration(border: Border.all(color: Colors.grey), shape: BoxShape.circle),
                child: Icon(Icons.close, size: 13.w),
              ).ripple(context, () {
                Navigator.pop(context);
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _EachContachSmallButtons extends StatelessWidget {
  const _EachContachSmallButtons({
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
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: color,
            // borderRadius: BorderRadius.only(topRight: Radius.circular(15.r), bottomLeft: Radius.circular(15.r)),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 17.w,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 5.w),
      ],
    ).ripple(context, onTap);
  }
}

class _ContactItem extends StatelessWidget {
  const _ContactItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 25.w),
        // margin: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          // border: Border.all(color:  Colors.grey[300]!),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 0.h),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Text(
                      //   'Name: ',
                      //   style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey[800], fontSize: 12.w),
                      // ),
                      Icon(Icons.person_2_outlined, size: 17.w),
                      SizedBox(width: 3.w),
                      Text(
                        'Mr. Lallit Potter',
                        style: TextStyle(color: Colors.grey[800], fontSize: 12.w),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      // Text(
                      //   'Company Name: ',
                      //   style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey[800], fontSize: 12.w),
                      // ),
                      Icon(Icons.business, size: 17.w),
                      SizedBox(width: 3.w),
                      Text(
                        'R.K.I.F',
                        style: TextStyle(color: Colors.grey[800], fontSize: 12.w),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'User/Type: ',
                        style: AppStyles.poppins.copyWith(fontWeight: FontWeight.w900, color: Colors.grey[800], fontSize: 12.w),
                      ),
                      Text(
                        'Giridhar',
                        style: AppStyles.poppins.copyWith(color: Colors.grey[800], fontSize: 12.w),
                      ),
                      SizedBox(width: 2.w),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                        decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(15.r)),
                        child: Text('Qtn2015', style: AppStyles.poppins.copyWith(fontSize: 10.w, color: Colors.white)),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    'Mar 12th 2024',
                    style: AppStyles.poppins.copyWith(color: Colors.grey[800], fontSize: 12.w),
                  ),
                ],
              ),

              SizedBox(height: 10.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'info@sgtf.ae',
                    style: TextStyle(color: Colors.grey[800], fontSize: 12.w),
                  ),
                  const Spacer(),
                  Text(
                    '971522627165',
                    style: TextStyle(color: Colors.grey[800], fontSize: 12.w),
                  ),
                ],
              ),

              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: Colors.green[300],
                      borderRadius: BorderRadius.circular(15.r),
                      // shape: BoxShape.circle,
                    ),
                    child: Text(
                      'Follow Up',
                      style: AppStyles.poppins.copyWith(color: Colors.white, fontSize: 12.w),
                    ),
                  ).ripple(context, () {
                    _followUpDialog(context);
                  }),
                  // SizedBox(width: 5.w),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 7.h),
                    decoration: BoxDecoration(
                      color: Colors.blue[300],
                      // borderRadius: BorderRadius.only(topRight: Radius.circular(15.r), bottomLeft: Radius.circular(15.r)),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.remove_red_eye_outlined,
                      size: 18.w,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 7.h),
                    decoration: BoxDecoration(
                      color: Colors.red[300],
                      // borderRadius: BorderRadius.only(topRight: Radius.circular(15.r), bottomLeft: Radius.circular(15.r)),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.delete_outline_outlined,
                      size: 18.w,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              // SizedBox(height: 10.h),

              // const Spacer(),
              // Divider(indent: 15.w, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  void _followUpDialog(BuildContext context) {
    // ignore: inference_failure_on_function_invocation
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        actionsPadding: EdgeInsets.zero,
        iconPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        // insetPadding: EdgeInsets.zero,
        // insetPadding: const EdgeInsets.symmetric(
        //   horizontal: 70,
        // ),
        insetPadding: EdgeInsets.only(
          bottom: 50.h,
          left: 15.w,
          right: 15.w,
        ),
        titlePadding: EdgeInsets.zero,
        content: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(),
                  Text(
                    'No Followups Found!!',
                    style: AppStyles.poppins.copyWith(fontSize: 10.w, fontWeight: FontWeight.w700, color: Colors.red),
                  ),

                  SizedBox(height: 10.h),

                  // New Follow up add button
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                    decoration: BoxDecoration(color: Colors.purple[400], borderRadius: BorderRadius.circular(15.r)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add,
                          size: 13.w,
                          color: Colors.white,
                        ),
                        Text(
                          'Add Followup',
                          style: AppStyles.poppins.copyWith(fontSize: 10.w, fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 5.h,
              right: 10.w,
              child: Container(
                height: 15.w,
                width: 15.w,
                decoration: BoxDecoration(border: Border.all(color: Colors.grey), shape: BoxShape.circle),
                child: Icon(Icons.close, size: 13.w),
              ).ripple(context, () {
                Navigator.pop(context);
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class MyTextWidget extends StatefulWidget {
  const MyTextWidget({required this.text, this.isRightItem = false, super.key});

  final String text;
  final bool isRightItem;

  @override
  State<MyTextWidget> createState() => _MyTextWidgetState();
}

class _MyTextWidgetState extends State<MyTextWidget> {
  bool isOverflowed = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final textSpan = TextSpan(text: widget.text, style: AppStyles.poppins.copyWith(fontWeight: FontWeight.w900, color: Colors.grey[800], fontSize: 12.w));
        final textPainter = TextPainter(text: textSpan, maxLines: 1, textDirection: TextDirection.ltr);

        textPainter.layout(maxWidth: constraints.maxWidth);

        isOverflowed = textPainter.didExceedMaxLines;
        // print('111111111111111111111111111111 $isOverflowed');
        // setState(() {
        // });

        return isOverflowed
            ? GestureDetector(
                onTapDown: (TapDownDetails details) {
                  showTextDialog(context, details.globalPosition);
                },
                child: Text(widget.text, style: AppStyles.poppins.copyWith(color: Colors.grey[800], fontSize: 12.w, overflow: TextOverflow.ellipsis)),
              )
            : Text(widget.text, style: AppStyles.poppins.copyWith(color: Colors.grey[800], fontSize: 12.w, overflow: TextOverflow.ellipsis));
      },
    );
  }

  void showTextDialog(BuildContext context, Offset tapPosition) {
    final overlay = Overlay.of(context).context.findRenderObject();
    final renderBox = context.findRenderObject() as RenderBox;
    final textOffset = renderBox.localToGlobal(Offset.zero, ancestor: overlay);

    final textRenderBox = context.findRenderObject() as RenderBox;
    final localTapPosition = textRenderBox.globalToLocal(tapPosition);

    Timer? timer;

    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned(
              // left: textOffset.dx + localTapPosition.dx - 20.0, // Adjust the dialog position as needed
              // top: textOffset.dy + localTapPosition.dy - 20.0, // Adjust the dialog position as needed

              left: widget.isRightItem ? textOffset.dx + localTapPosition.dx - 100.w : textOffset.dx + localTapPosition.dx - 20.w, // Adjust the dialog position as needed
              top: textOffset.dy + localTapPosition.dy - 30.h, // Adjust the dialog position as needed
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Text(widget.text, style: AppStyles.poppins.copyWith(color: Colors.white, fontSize: 11.w)),
              ),
            ),
          ],
        );
      },
    ).then((_) {
      timer?.cancel(); // Cancel the timer if the dialog is dismissed manually
    });

    timer = Timer(const Duration(seconds: 1), () {
      Navigator.of(context).pop(); // Close dialog after 1 second
    });
  }
}
