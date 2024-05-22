// ignore_for_file: lines_longer_than_80_chars, inference_failure_on_instance_creation, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:async';

import 'package:affiliate_platform/config/ripple.dart';
import 'package:affiliate_platform/logic/auth/auth_bloc.dart';
import 'package:affiliate_platform/logic/manage_contact/manage_contact_bloc.dart';
import 'package:affiliate_platform/models/manage_contact/all_contacts.dart';
import 'package:affiliate_platform/models/manage_contact/contact_view_model.dart';
import 'package:affiliate_platform/services/manage_contact/manage_contact_services.dart';
import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/utils/custom_tools.dart';
import 'package:affiliate_platform/view/common/custom_header.dart';
import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:affiliate_platform/view/common/sidebar.dart';
import 'package:affiliate_platform/view/manage_contact/data_sample.dart';
import 'package:affiliate_platform/view/manage_contact/new_contact.dart';
import 'package:affiliate_platform/view/manage_contact/view_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skeletonizer/skeletonizer.dart';
// ignore: library_prefixes
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

ValueNotifier<bool> isAddFollowUp = ValueNotifier(false);
ValueNotifier<List<dynamic>> isEditFollowUp = ValueNotifier([]);

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    final manageContactBloc = Provider.of<ManageContactBloc>(context);
    return PopScope(
      onPopInvoked: (didPop) {
        Navigator.pop(context);
      },
      child: GestureDetector(
        // onTap: _handleLocaleChanged,
        onTap: () {
          // _handleLocaleChanged();
          // menuVisibility.value = false;
          // menuVisibility.notifyListeners();
          Scaffold.of(context).closeDrawer();
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
          body: SafeArea(
            child: Column(
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
                StreamBuilder(
                  stream: manageContactBloc.getAllContactsStream,
                  builder: (context, snapshot) {
                    // if (snapshot.connectionState == ConnectionState.waiting) {
                    //   return const CircularProgressIndicator();
                    // }

                    if ((!snapshot.hasData && snapshot.connectionState != ConnectionState.waiting) || snapshot.hasError) {
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
                                await manageContactBloc.getAllContacts();
                              },
                              borderRadius: BorderRadius.circular(15.r),
                              overlayColor: Colors.purple.withOpacity(.15),
                            ),
                          ],
                        ),
                      );
                    }

                    // print('2222222222222222222222222222222222222222222222 ${snapshot.data}');

                    GetAllContactsAndUsers? allContactsRespModel;

                    if (snapshot.hasData) {
                      allContactsRespModel = snapshot.data;
                    }

                    return Expanded(
                      child: SingleChildScrollView(
                        child: Skeletonizer(
                          enabled: snapshot.connectionState == ConnectionState.waiting,
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

                                ...List.generate((allContactsRespModel == null) ? 5 : allContactsRespModel.data1![0].contacts!.length, (index) {
                                  // ...List.generate(sampleList['contacts']!.length, (index) {
                                  // final list = sampleList['contacts']?[index];
                                  // final model = Contact1.fromJson(list ?? {});
                                  return _CustomExpansionTile(
                                    model: allContactsRespModel,
                                    index: index,
                                  );
                                }),
                              ],
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
  final GetAllContactsAndUsers? model;

  @override
  State<_CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<_CustomExpansionTile> {
  bool showAllIcons = true;

  @override
  Widget build(BuildContext context) {
    final manageBloc = Provider.of<ManageContactBloc>(context);
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
            // color: Colors.grey[100],
            color: Colors.purple.withOpacity(.05),
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
                  // For Sales Person
                  Positioned(
                    // top: -18.h,
                    top: -17.h,
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
                                  child: MyTextWidget(
                                    text: widget.model?.data1 == null || widget.model!.data1!.isEmpty || widget.model!.data1![0].contacts!.isEmpty
                                        ? '-'
                                        : widget.model?.data1![0].contacts![widget.index].name == ''
                                            ? '-'
                                            : widget.model?.data1![0].contacts![widget.index].name ?? '-',
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
                                Icon(Icons.business, size: 17.w),
                                SizedBox(width: 5.w),
                                SizedBox(
                                  width: 90.w,
                                  // child: Text(
                                  //   // 'R.K.I.F',
                                  //   widget.model.companyName,
                                  //   style: AppStyles.poppins.copyWith(color: Colors.grey[800], fontSize: 12.w, overflow: TextOverflow.ellipsis),
                                  // ),
                                  child: MyTextWidget(
                                    text: widget.model?.data1 == null || widget.model!.data1!.isEmpty || widget.model!.data1![0].contacts!.isEmpty
                                        ? '-'
                                        : widget.model?.data1![0].contacts![widget.index].company == ''
                                            ? '-'
                                            : widget.model?.data1![0].contacts![widget.index].company ?? '-',
                                  ),
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
                                  child: MyTextWidget(
                                    text: widget.model?.data1 == null || widget.model!.data1!.isEmpty || widget.model!.data1![0].contacts!.isEmpty
                                        ? '-'
                                        : widget.model?.data1![0].contacts![widget.index].email == ''
                                            ? '-'
                                            : widget.model?.data1![0].contacts![widget.index].email ?? '-',
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
                                Icon(Icons.phone_outlined, size: 17.w),
                                SizedBox(width: 5.w),
                                Text(
                                  // '971522627165',
                                  widget.model?.data1 == null || widget.model!.data1!.isEmpty || widget.model!.data1![0].contacts!.isEmpty
                                      ? '-'
                                      : widget.model?.data1![0].contacts![widget.index].mobile == ''
                                          ? '-'
                                          : widget.model?.data1![0].contacts![widget.index].mobile ?? '-',
                                  style: GoogleFonts.poppins().copyWith(color: Colors.grey[800], fontSize: 12.w),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
                            widget.model?.data1 == null || widget.model!.data1!.isEmpty || widget.model!.data1![0].contacts!.isEmpty
                                ? '-'
                                : widget.model?.data1![0].contacts![widget.index].nextFollowup == ''
                                    ? '-'
                                    : widget.model?.data1![0].contacts![widget.index].nextFollowup ?? '-',
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
                                    '18/04/2024',
                                    // widget.model.data1 == null || widget.model.data1!.isEmpty || widget.model.data1![0].contacts!.isEmpty
                                    //     ? '-'
                                    //     : widget.model.data1![0].contacts![0]. ?? '-',
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
                            color: Colors.purple[400],
                            borderRadius: BorderRadius.circular(15.r),
                            // shape: BoxShape.circle,
                          ),
                          child: Text(
                            'Follow Up',
                            // 'F',
                            style: AppStyles.poppins.copyWith(color: Colors.white, fontSize: 12.w),
                          ),
                        ).ripple(context, () async {
                          customLoader(context);
                          isAddFollowUp.value = false;
                          isAddFollowUp.notifyListeners();
                          await manageBloc
                              .viewContact(contactId: widget.model?.data1![0].contacts![widget.index].id ?? '-')
                              .then((value) => _followUpDialog(context, widget.model?.data1![0].contacts![widget.index].id ?? '-'));
                          Loader.hide();
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
                                    path: widget.model?.data1 == null || widget.model!.data1!.isEmpty || widget.model!.data1![0].contacts!.isEmpty
                                        ? '-'
                                        : widget.model?.data1![0].contacts![widget.index].email ?? '-',
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
                                  // UrlLauncher.launchUrl(Uri.parse('tel://${widget.model.phoneNumber.contains('+') ? widget.model.phoneNumber : '+971${widget.model.phoneNumber}'}'));
                                  UrlLauncher.launchUrl(Uri.parse(
                                      'tel://${(widget.model?.data1 == null || widget.model!.data1!.isEmpty || widget.model!.data1![0].contacts!.isEmpty ? '-' : widget.model?.data1![0].contacts![widget.index].name ?? '-').contains('+') ? widget.model?.data1 == null || widget.model!.data1!.isEmpty || widget.model!.data1![0].contacts!.isEmpty ? '-' : widget.model!.data1![0].contacts![widget.index].name ?? '-' : '+971${widget.model?.data1 == null || widget.model!.data1!.isEmpty || widget.model!.data1![0].contacts!.isEmpty ? '-' : widget.model?.data1![0].contacts![widget.index].name ?? '-'}'}'));
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
                                color: Colors.green[900]!,
                                icon: Icons.edit_outlined,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NewContact(contactId: widget.model?.data1?[0].contacts?[widget.index].id),
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
                                builder: (context) => ViewContact(
                                  contactId: widget.model?.data1?[0].contacts?[widget.index].id ?? '',
                                ),
                              ),
                            );
                          },
                        ),
                        _EachContachSmallButtons(
                          color: Colors.red[400]!,
                          icon: Icons.delete_outline_outlined,
                          onTap: () async {
                            final isTrue = await showWarningDialog(
                              context,
                              title: 'Remove Contact',
                              description: 'Are you sure want to delete the contact?',
                              yes: 'Delete',
                              no: 'Cancel',
                            );

                            if (isTrue != null && isTrue) {
                              customLoader(context);
                              final isDeleted = await manageBloc.deleteContact(contactId: widget.model?.data1?[0].contacts?[widget.index].id ?? '');

                              if (isDeleted) {
                                await manageBloc.getAllContacts();
                                // ignore: use_build_context_synchronously
                                await successMotionToastInfo(context, msg: 'Contact deleted successfully.');
                                Loader.hide();
                              } else {
                                Loader.hide();
                                // ignore: use_build_context_synchronously
                                await erroMotionToastInfo(context, msg: "Can't able to delete contact");
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
        ),
      ),
    );
  }

  void _followUpDialog(BuildContext context, String contactId) {
    final bloc = Provider.of<ManageContactBloc>(context, listen: false);
    // bool isAddFollowUp = false;
    // ignore: inference_failure_on_function_invocation
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return StreamBuilder(
            stream: bloc.getContactViewStream,
            builder: (context, snapshot) {
              final model = snapshot.data;
              return ValueListenableBuilder(
                valueListenable: isAddFollowUp,
                builder: (context, editfollow, _) {
                  return AlertDialog(
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
                      top: 30.h,
                      bottom: 50.h,
                      left: 15.w,
                      right: 15.w,
                    ),
                    titlePadding: EdgeInsets.zero,
                    content: ValueListenableBuilder(
                      valueListenable: isAddFollowUp,
                      builder: (context, follow, _) {
                        return Stack(
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
                                  // Text(
                                  //   'No Followups Found!!',
                                  //   style: AppStyles.poppins.copyWith(fontSize: 10.w, fontWeight: FontWeight.w700, color: Colors.red),
                                  // ),

                                  SizedBox(height: 25.h),

                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10.h),
                                    // child: Column(
                                    //   children: [
                                    //     _FollowUpWidget(widget: widget),
                                    //   ],
                                    // ),
                                    child: isAddFollowUp.value
                                        ? SizedBox(
                                            width: 800.w,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                                              child: Form(
                                                key: _formKey,
                                                child: Column(
                                                  children: [
                                                    _AddFollowUpField(
                                                      textStream: bloc.followupTitleStream,
                                                      onChanged: bloc.followupTitleStream.add,
                                                      heading: 'Followup Title',
                                                      hint: 'Followup Title',
                                                    ),
                                                    _AddFollowUpField(
                                                      textStream: bloc.followupDescriptionStream,
                                                      onChanged: bloc.followupDescriptionStream.add,
                                                      heading: 'Description',
                                                      hint: 'Description',
                                                    ),
                                                    _AddFollowUpField(
                                                      textStream: bloc.followupDateStream,
                                                      onChanged: bloc.followupDateStream.add,
                                                      heading: 'Next followup date',
                                                      hint: 'Followup date dd-mm-yy',
                                                      enabled: false,
                                                      onTap: () async {
                                                        // await showDatePicker(
                                                        //     context: context,
                                                        //     initialDate: DateTime.now(),
                                                        //     firstDate: DateTime(2000),
                                                        //     lastDate: DateTime.now(),
                                                        //   );

                                                        final dateOnly = await _selectDate(context);

                                                        if (dateOnly != null) {
                                                          bloc.followupDateStream.add(dateOnly);
                                                        } else {
                                                          await erroMotionToastInfo(context, msg: 'Something wrong in date selection!!!. Contact Admin');
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox(
                                            height: 450.h, // Change as per your requirement
                                            width: double.maxFinite, // Change as per your requirement
                                            child: ListView.separated(
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) => _FollowUpWidget(
                                                model: model,
                                                index: index,
                                              ),
                                              // itemBuilder: (context, index) => Container(),
                                              separatorBuilder: (context, index) => Padding(
                                                padding: EdgeInsets.only(top: 12.h),
                                                child: Divider(
                                                  indent: 10.w,
                                                  endIndent: 10.w,
                                                  color: Colors.grey[200],
                                                ),
                                              ),
                                              itemCount: model != null && model.data != null && model.data!.isNotEmpty ? model.data![0].contactFollowups!.length : 0,
                                            ),
                                          ),
                                  ),

                                  SizedBox(height: 10.h),

                                  // New Follow up add button
                                  if (isAddFollowUp.value)
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                                      decoration: BoxDecoration(color: Colors.purple[400], borderRadius: BorderRadius.circular(15.r)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.check,
                                            size: 18.w,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 5.w),
                                          Text(
                                            'Add',
                                            style: AppStyles.poppins.copyWith(fontSize: 13.w, fontWeight: FontWeight.w700, color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ).ripple(context, () async {
                                      if (!_formKey.currentState!.validate()) {
                                        return;
                                      }
                                      customLoader(context);
                                      if (isEditFollowUp.value[0] as bool) {
                                        await bloc.editFollowup(contactId: contactId, followupId: model?.data?[0].contactFollowups?[isEditFollowUp.value[1] as int].id ?? '');
                                        print('222222222222222222222222222222');
                                      } else {
                                        print('1111111111111111111111111111111');
                                        await bloc.addFollowup(contactId: contactId);
                                      }
                                      await bloc.viewContact(contactId: contactId);
                                      // setState(() {
                                      //   isAddFollowUp = false;
                                      // });
                                      isAddFollowUp.value = false;
                                      isAddFollowUp.notifyListeners();

                                      isEditFollowUp.value = [false];
                                      isEditFollowUp.notifyListeners();

                                      Loader.hide();
                                    })
                                  else
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                                      decoration: BoxDecoration(color: Colors.purple[400], borderRadius: BorderRadius.circular(15.r)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.add,
                                            size: 18.w,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            'Add Followup',
                                            style: AppStyles.poppins.copyWith(fontSize: 13.w, fontWeight: FontWeight.w700, color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ).ripple(context, () {
                                      // setState(() {
                                      //   isAddFollowUp = true;
                                      // });
                                      bloc.followupTitleStream.add('');
                                      bloc.followupDescriptionStream.add('');
                                      bloc.followupDateStream.add('');

                                      isAddFollowUp.value = true;
                                      isAddFollowUp.notifyListeners();

                                      isEditFollowUp.value = [false];
                                      isEditFollowUp.notifyListeners();
                                    }),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 5.h,
                              right: 10.w,
                              child: Container(
                                margin: EdgeInsets.only(top: 10.h),
                                height: 30.w,
                                width: 30.w,
                                decoration: BoxDecoration(
                                  // border: Border.all(color: Colors.grey),
                                  color: Colors.purple[400],
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.close, size: 18.w, color: Colors.white),
                              ).ripple(context, () {
                                Navigator.pop(context);
                              }),
                            ),
                            if (isAddFollowUp.value)
                              Positioned(
                                top: 5.h,
                                left: 10.w,
                                child: Container(
                                  margin: EdgeInsets.only(top: 10.h),
                                  height: 30.w,
                                  width: 30.w,
                                  decoration: BoxDecoration(
                                    // border: Border.all(color: Colors.grey),
                                    color: Colors.purple[400],
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.arrow_back_ios_new_rounded, size: 18.w, color: Colors.white),
                                ).ripple(context, () {
                                  // setState(() {
                                  //   isAddFollowUp = false;
                                  // });
                                  isAddFollowUp.value = false;
                                  isAddFollowUp.notifyListeners();
                                }),
                              ),
                          ],
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    ).then((value) {
      isEditFollowUp.value = [false];
      isEditFollowUp.notifyListeners();
    });
  }

  Future<String?> _selectDate(BuildContext context) async {
    final now = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    );

    if (picked != null) {
      final dateOnly = DateTime(picked.year, picked.month, picked.day);

      print('77777777777777777777777777777 ${intl.DateFormat('dd-MM-yyyy').format(dateOnly)}');
      return intl.DateFormat('dd-MM-yyyy').format(dateOnly);
    }
    return null;
  }
}

class _FollowUpWidget extends StatefulWidget {
  const _FollowUpWidget({
    required this.model,
    required this.index,
    super.key,
  });

  final ContactViewModel? model;
  final int index;

  @override
  State<_FollowUpWidget> createState() => _FollowUpWidgetState();
}

class _FollowUpWidgetState extends State<_FollowUpWidget> {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<ManageContactBloc>(context);
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  children: [
                    Text(
                      'Followup #1',
                      style: AppStyles.poppins.copyWith(fontSize: 12.w, fontWeight: FontWeight.w700, color: Colors.purple[400]),
                    ),
                    const Spacer(),
                    Text(
                      'Date : ${widget.model?.data?[0].contactFollowups?[widget.index].createdAt}',
                      style: AppStyles.poppins.copyWith(fontSize: 12.w, fontWeight: FontWeight.w700, color: Colors.purple[400]),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  widget.model?.data?[0].contactFollowups?[widget.index].description ?? '',
                  style: AppStyles.poppins.copyWith(fontSize: 12.w, fontWeight: FontWeight.w700, color: Colors.grey[700]),
                ),
              ),
            ],
          ).ripple(context, () async {
            // await bloc.editFollowup(contactId: widget.model?.data?[0].contact?.createdBy ?? '', followupId: widget.model?.data?[0].contactFollowups?[widget.index].id ?? '');

            isAddFollowUp.value = true;
            isAddFollowUp.notifyListeners();

            bloc.followupTitleStream.add(widget.model?.data?[0].contactFollowups?[widget.index].title ?? '');
            bloc.followupDescriptionStream.add(widget.model?.data?[0].contactFollowups?[widget.index].description ?? '');
            bloc.followupDateStream.add(intl.DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.model?.data?[0].contactFollowups?[widget.index].nextFollowupDate ?? '19-04-2024')));

            isEditFollowUp.value = [true, widget.index];
            isEditFollowUp.notifyListeners();
          }),
        ),
        Positioned(
          bottom: 0,
          right: 10.w,
          child: Icon(Icons.delete_outline, size: 20.w, color: Colors.purple[400]).ripple(context, () async {
            final isTrue = await showWarningDialog(
              context,
              title: 'Remove Followup',
              description: 'Are you sure want to delete the followup?',
              yes: 'Delete',
              no: 'Cancel',
            );

            if (isTrue != null && isTrue) {
              customLoader(context);
              final bloc = Provider.of<ManageContactBloc>(context, listen: false);

              final contactId = widget.model?.data?[0].id;
              final followupId = widget.model?.data?[0].contactFollowups?[widget.index].id;

              final isDeleted = await bloc.deleteFollowup(contactId: contactId ?? '', followupId: followupId ?? '');

              if (isDeleted) {
                await successMotionToastInfo(context, msg: 'Followup deleted successfully.');
                await bloc.viewContact(contactId: contactId ?? '');
                // bool isPresent = false;
                Loader.hide();
              } else {
                await erroMotionToastInfo(context, msg: 'Something wrong!!');
                Loader.hide();
              }
            }
          }),
        ),
      ],
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
            // color: color,
            color: Colors.purple[400],
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

class _AddFollowUpField extends StatefulWidget {
  const _AddFollowUpField({
    // required this.controller,
    required this.heading,
    required this.textStream,
    required this.hint,
    this.onChanged,
    this.enabled = true,
    this.onTap,
    // this.initialValue = '',
    this.textInputType = TextInputType.name,
    this.isLargeField = false,
    super.key,
  });

  // final TextEditingController controller;
  final BehaviorSubject<String> textStream;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool enabled;
  final String heading;
  final String hint;
  // final String initialValue;
  final bool isLargeField;
  final TextInputType textInputType;

  @override
  State<_AddFollowUpField> createState() => _AddFollowUpFieldState();
}

class _AddFollowUpFieldState extends State<_AddFollowUpField> {
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(heading, style: AppStyles.poppins.copyWith(fontSize: 12.w, color: Colors.purple)),
              // SizedBox(height: 7.h),
              SizedBox(
                height: widget.isLargeField ? null : 70.h,
                child: TextFormField(
                  controller: _controller,
                  onChanged: widget.onChanged,
                  onTap: widget.onTap,
                  validator: (value) {
                    if (value == '') {
                      return 'Required';
                    }
                    return null;
                  },
                  // enabled: widget.enabled,
                  // initialValue: widget.initialValue,
                  scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 15.w * 6, // Adjust the value as needed
                  ),
                  // controller: controller,
                  style: AppStyles.poppins.copyWith(
                    color: Colors.purple,
                    fontSize: 13.w,
                  ),
                  keyboardType: !widget.isLargeField ? widget.textInputType : TextInputType.multiline,
                  // minLines: !isLargeField ? null : 1,
                  // maxLines: !isLargeField ? null : 20,
                  // maxLength: !isLargeField ? null : 500,
                  // expands:isLargeField ,
                  // maxLines: null,
                  decoration: InputDecoration(
                    // isDense: true,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: widget.heading,
                    labelStyle: AppStyles.poppins.copyWith(fontSize: 12.w, color: Colors.purple),
                    hintText: widget.hint,
                    hintStyle: AppStyles.openSans.copyWith(
                      color: Colors.purple[100],
                      fontSize: 13.w,
                    ),
                    contentPadding: EdgeInsets.only(left: 15.w),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color.fromARGB(139, 103, 51, 137)),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color.fromARGB(139, 103, 51, 137)),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color.fromARGB(255, 152, 102, 185)),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
