// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/config/ripple.dart';
import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:affiliate_platform/view/common/sidebar.dart';
import 'package:affiliate_platform/view/manage_contact/data_sample.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ViewContact extends StatelessWidget {
  const ViewContact({required this.model, super.key});

  final Contact model;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      haveFloatingButton: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomHeader(isBackButtonNeeded: true, heading: 'Contact Details'),

          //
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   padding: EdgeInsets.all(15.w),
                    //   decoration: BoxDecoration(
                    //     color: Colors.blue,
                    //     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100.r), topLeft: Radius.circular(100.r),topRight: Radius.circular(100.r),bottomRight: Radius.circular(25.r)),

                    //   ),
                    //   child: Icon(Icons.business,size: 50.w,color: Colors.white),
                    // ),

                    // Design 1

                    // Top Section
                    // Align(child: Text(model.name, style: AppStyles.poppins.copyWith(fontSize: 18.w, color: Colors.purple[600], fontWeight: FontWeight.w800))),
                    // SizedBox(height: 3.h),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(model.companyName, style: AppStyles.poppins.copyWith(fontSize: 14.w, color: Colors.grey[600], fontWeight: FontWeight.w800)),
                    //     // SizedBox(width: 10.w),
                    //     // Container(
                    //     //   height: 25.w,
                    //     //   width: 25.w,
                    //     //   decoration: BoxDecoration(color: Colors.blue[700], shape: BoxShape.circle),
                    //     //   child: Icon(FontAwesomeIcons.earthAfrica, size: 15.w, color: Colors.white),
                    //     // ),
                    //     SizedBox(width: 4.w),
                    //     Icon(FontAwesomeIcons.earthAfrica, size: 15.w, color: Colors.blue[700]),
                    //   ],
                    // ),
                    // SizedBox(height: 7.h),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         // Container(
                    //         //   height: 25.w,
                    //         //   width: 25.w,
                    //         //   decoration: BoxDecoration(color: Colors.green[700], shape: BoxShape.circle),
                    //         //   child: Icon(Icons.phone, size: 15.w, color: Colors.white),
                    //         // ),
                    //         Icon(Icons.phone_android_outlined, size: 15.w, color: Colors.green[700]),
                    //         SizedBox(width: 3.w),
                    //         Text(model.phoneNumber, style: AppStyles.poppins.copyWith(fontSize: 14.w, color: Colors.grey[600])),
                    //       ],
                    //     ),
                    //     SizedBox(width: 12.w),
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         // Container(
                    //         //   height: 25.w,
                    //         //   width: 25.w,
                    //         //   decoration: BoxDecoration(color: Colors.red[700], shape: BoxShape.circle),
                    //         //   child: Icon(Icons.email, size: 15.w, color: Colors.white),
                    //         // ),
                    //         Icon(Icons.email, size: 15.w, color: Colors.red[700]),
                    //         SizedBox(width: 3.w),
                    //         Text(model.email, style: AppStyles.poppins.copyWith(fontSize: 14.w, color: Colors.grey[600])),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    // // Top Section

                    // SizedBox(height: 30.h),

                    // Card(
                    //   margin: EdgeInsets.symmetric(horizontal: 8.w),
                    //   color: Colors.white,
                    //   // decoration: BoxDecoration(
                    //   //   color: Colors.grey[100],borderRadius: BorderRadius.circular(20.r),
                    //   // ),
                    //   child: Padding(
                    //     padding: EdgeInsets.symmetric(horizontal: 10.w),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Container(),
                    //         SizedBox(height: 20.h),
                    //          _EachValue(field: 'Company Address', value: model.companyAddress),
                    //          _EachValue(field: 'Company Landline', value: model.companyLandline),
                    //          _EachValue(field: 'Company Location', value: model.companyLocation),
                    //          _EachValue(field: 'Company Website', value: model.companyWebsite),
                    //          _EachValue(field: 'Created By', value: model.createdBy),
                    //          _EachValue(field: 'Contact Type', value: model.type),
                    //          _EachValue(field: 'Contact Source', value: model.contactSource),
                    //          _EachValue(field: 'Contact Designation', value:model.contactDesignation),
                    //          _EachValue(field: 'Remarks', value: model.remarks),
                    //         SizedBox(height: 10.h),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 15.h),
                    //   padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                    //   decoration: BoxDecoration(
                    //     color: Colors.green[600],
                    //     borderRadius: BorderRadius.circular(10.r),
                    //     // shape: BoxShape.circle,
                    //   ),
                    //   child: Text(
                    //     'Follow Up',
                    //     style: AppStyles.poppins.copyWith(color: Colors.white, fontSize: 16.w),
                    //   ),
                    // ).ripple(context, () {
                    //   _followUpDialog(context);
                    // }),

                    // Design 1

                    // Design 2

                    // Text('Company Information', style: AppStyles.poppins.copyWith(fontSize: 13.w, color: Colors.grey[800], fontWeight: FontWeight.w800)),
                    // Column(
                    //   children: [
                    //     _CardItem(field: 'Name', value: model.name),
                    //     _CardItem(field: 'Company', value: model.companyName),
                    //     _CardItem(field: 'Phone Number', value: model.phoneNumber),
                    //     _CardItem(field: 'Email', value: model.email),
                    //     _CardItem(field: 'Company Address', value: model.companyAddress),
                    //     _CardItem(field: 'Company Landline', value: model.companyLandline),
                    //     _CardItem(field: 'Company Location', value: model.companyLocation),
                    //     _CardItem(field: 'Company Website', value: model.companyWebsite),
                    //   ],
                    // ),
                    // Text('Contact Information', style: AppStyles.poppins.copyWith(fontSize: 13.w, color: Colors.grey[800], fontWeight: FontWeight.w800)),
                    // Column(
                    //   children: [
                    //     _CardItem(field: 'Created By', value: model.createdBy),
                    //     _CardItem(field: 'Contact Type', value: model.type),
                    //     _CardItem(field: 'Contact Source', value: model.contactSource),
                    //     _CardItem(field: 'Contact Designation', value: model.contactDesignation),
                    //     _CardItem(field: 'Remarks', value: model.remarks),
                    //   ],
                    // ),

                    // Design 2

                    Container(),

                    Align(child: Text(model.name, style: AppStyles.poppins.copyWith(fontSize: 18.w, color: Colors.purple[600], fontWeight: FontWeight.w800))),

                    Align(child: Text(model.companyName, style: AppStyles.poppins.copyWith(fontSize: 14.w, color: Colors.grey[600], fontWeight: FontWeight.w800))),

                    SizedBox(height: 30.h),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Company Information', style: AppStyles.poppins.copyWith(fontSize: 13.w, color: Colors.grey[800], fontWeight: FontWeight.w800)),
                        // Padding(
                        //   padding: EdgeInsets.only(top: 10.h),
                        //   // child: _NewCardItem(model: model),
                        //   child: Column(
                        //     children: [
                        //       Container(
                        //         margin: EdgeInsets.only(bottom: 2.h),
                        //         decoration: BoxDecoration(
                        //           // border: Border.all(color: Colors.grey),
                        //           color: Color(0xFFFEFBFF),
                        //           borderRadius: BorderRadius.only(topRight: Radius.circular(12.r), topLeft: Radius.circular(12.r)),
                        //         ),
                        //         padding: EdgeInsets.symmetric(vertical: 13.h, horiz20ontal: 5.w),
                        //         child: Row(
                        //           children: [
                        //             Icon(Icons.person, size: 13.w),
                        //             SizedBox(width: 5.w),
                        //             Text('Name', style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800])),
                        //             const Spacer(),
                        //             Text(model.name, style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800], fontWeight: FontWeight.w800)),
                        //           ],
                        //         ),
                        //       ),

                        //       //
                        //       _NewCardItem(field: 'Company', value: model.companyName, icondata: Icons.business),
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
                                    Icon(Icons.person, size: 13.w),
                                    SizedBox(width: 5.w),
                                    Text('Phone Number', style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800])),
                                    const Spacer(),
                                    SelectableText(model.phoneNumber, style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800], fontWeight: FontWeight.w800)),
                                  ],
                                ),
                              ),

                              // _NewCardItem(field: 'Phone Number', value: model.phoneNumber, icondata: Icons.phone_outlined),
                              _NewCardItem(field: 'Email', value: model.email, icondata: Icons.email_outlined),
                              _NewCardItem(field: 'Company Address', value: model.companyAddress, icondata: Icons.note_alt_outlined),
                              _NewCardItem(field: 'Company Landline', value: model.companyLandline, icondata: Icons.lan_outlined),
                              _NewCardItem(field: 'Company Location', value: model.companyLocation, icondata: Icons.location_on_outlined),
                              // _NewCardItem(field: 'Company Website', value: model.companyWebsite),

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
                                    Icon(FontAwesomeIcons.earthAfrica, size: 13.w),
                                    SizedBox(width: 5.w),
                                    Text('Company Website', style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800])),
                                    const Spacer(),
                                    SelectableText(model.companyWebsite, style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800], fontWeight: FontWeight.w800)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    //
                    SizedBox(height: 20.h),

                    //
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Contact Information', style: AppStyles.poppins.copyWith(fontSize: 13.w, color: Colors.grey[800], fontWeight: FontWeight.w800)),
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
                                    Icon(Icons.person_add_alt, size: 13.w),
                                    SizedBox(width: 5.w),
                                    Text('Created By', style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800])),
                                    const Spacer(),
                                    SelectableText(model.createdBy, style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800], fontWeight: FontWeight.w800)),
                                  ],
                                ),
                              ),

                              //

                              _NewCardItem(
                                field: 'Contact Type',
                                value: model.type,
                                icondata: Icons.type_specimen_outlined,
                              ),
                              _NewCardItem(
                                field: 'Contact Source',
                                value: model.contactSource,
                                icondata: Icons.source_outlined,
                              ),
                              _NewCardItem(
                                field: 'Contact Designation',
                                value: model.contactDesignation,
                                icondata: Icons.location_city_rounded,
                              ),

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
                                    Icon(FontAwesomeIcons.readme, size: 13.w),
                                    SizedBox(width: 5.w),
                                    Text('Remarks', style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800])),
                                    const Spacer(),
                                    SelectableText(model.remarks, style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800], fontWeight: FontWeight.w800)),
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
              ),
            ),
          ),
        ],
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
                child: SelectableText(value, textAlign: TextAlign.justify, style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800], fontWeight: FontWeight.w800))),
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
