// ignore_for_file: cascade_invocations, lines_longer_than_80_chars, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, inference_failure_on_instance_creation

import 'dart:io';

import 'package:affiliate_platform/config/ripple.dart';
import 'package:affiliate_platform/view/profile/edit_profile.dart';
import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/utils/image_related.dart';
import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:affiliate_platform/view/common/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

final croppedImagePath = ValueNotifier<String?>(null);

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with ImagePickerMixin {
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
        floatingActionButtonIcon: FontAwesomeIcons.userPen,
        onTapFloatingButton: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EditProfile(),
            ),
          );
        },
        body: GestureDetector(
          // onTap: _handleLocaleChanged,
          onTap: () {
            // _handleLocaleChanged();
            menuVisibility.value = false;
            menuVisibility.notifyListeners();
          },
          child: Column(
            children: [
              // const CustomHeader(
              //   heading: 'Profile',
              //   isBackButtonNeeded: true,
              //   isTrailingButtonNeeded: true,
              // ),
      
              const CustomHeader(),
      
              //
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Column(
                          children: [
                            // DP
                            ValueListenableBuilder(
                              valueListenable: croppedImagePath,
                              builder: (context, value, child) {
                                return Stack(
                                  children: [
                                    Container(
                                      height: 90.w,
                                      width: 90.w,
                                      decoration: croppedImagePath.value == null
                                          ? const BoxDecoration(
                                              // shape: BoxShape.circle,
                                              color: Colors.white,
                                              image: DecorationImage(image: AssetImage('assets/images/avatar2.png'),fit: BoxFit.fill),
                                            )
                                          : BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              image: DecorationImage(image: FileImage(File(croppedImagePath.value!)),fit: BoxFit.fill),
                                            ),
                                    ),
                                    Positioned(
                                      bottom: 0.h,
                                      right: 5.w,
                                      child: Container(
                                        width: 25.w,
                                        height: 25.w,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          border: Border.all(color: Colors.green[400]!),
                                        ),
                                        child: Icon(Icons.edit, color: Colors.green[900], size: 15.w),
                                      ),
                                    ),
                                  ],
                                ).ripple(context, () async {
                                  final imageSrc = await selectImagePickerSource(context);
      
                                  final xfile = await pickXFileImage(context, imageSource: imageSrc!);
      
                                  if (xfile != null) {
                                    await compressAndResizeImage(File(xfile.path)).then((fileInJpg) async {
                                      // print('3333333333333333333333333333333333333333333');
                                      // showDialog(
                                      //   context: context,
                                      //   builder: (context) => AlertDialog(
                                      //     backgroundColor: Colors.transparent,
                                      //     actionsPadding: EdgeInsets.zero,
                                      //     iconPadding: EdgeInsets.zero,
                                      //     buttonPadding: EdgeInsets.zero,
                                      //     contentPadding: EdgeInsets.zero,
                                      //     // insetPadding: EdgeInsets.zero,
                                      //     // insetPadding: const EdgeInsets.symmetric(
                                      //     //   horizontal: 70,
                                      //     // ),
                                      //     insetPadding: EdgeInsets.only(
                                      //       bottom: 50.h,
                                      //       left: 15.w,
                                      //       right: 15.w,
                                      //     ),
                                      //     titlePadding: EdgeInsets.zero,
                                      //     content: Image.file(fileInJpg),
                                      //   ),
                                      // );
      
                                      // final bytes = fileInJpg.readAsBytesSync();
      
                                      final croppedFile = await ImageCropper().cropImage(
                                        cropStyle: CropStyle.circle,
                                        sourcePath: fileInJpg.path,
                                        // aspectRatioPresets: [
                                        //   CropAspectRatioPreset.square,
                                        //   CropAspectRatioPreset.ratio3x2,
                                        //   CropAspectRatioPreset.original,
                                        //   CropAspectRatioPreset.ratio4x3,
                                        //   CropAspectRatioPreset.ratio16x9,
                                        // ],
                                        uiSettings: [
                                          AndroidUiSettings(
                                            toolbarTitle: 'Profile Image',
                                            toolbarColor: Colors.purple[300],
                                            toolbarWidgetColor: Colors.white,
                                            // initAspectRatio: CropAspectRatioPreset.original,
                                            hideBottomControls: true,
                                            lockAspectRatio: false,
                                            showCropGrid: false,
                                          ),
                                          IOSUiSettings(
                                            title: 'Profile Image',
                                          ),
                                          WebUiSettings(
                                            context: context,
                                          ),
                                        ],
                                      );
      
                                      final output = croppedFile?.path;
      
                                      // print('22222222222222222222222 ${output}');
      
                                      croppedImagePath.value = output;
                                      croppedImagePath.notifyListeners();
                                    });
                                  }
                                });
                              },
                            ),
                            // DP
      
                            // const Spacer(),
      
                            SizedBox(height: 15.h),
      
                            // Top Section
                            Column(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SelectableText(
                                  'Mohamed Shahil (VST-113)',
                                  textAlign: TextAlign.center,
                                  // style: AppStyles.poppins.copyWith(fontSize: 18.w, color: Colors.grey[800], fontWeight: FontWeight.w800),
                                  style: AppStyles.poppins.copyWith(fontSize: 18.w, color: Colors.purple[900], fontWeight: FontWeight.w800),
                                ),
                                SelectableText(
                                  'Mobile App Developer',
                                  textAlign: TextAlign.justify,
                                  style: AppStyles.poppins.copyWith(fontSize: 14.w, color: Colors.grey[800]),
                                ),
                                SizedBox(height: 10.h),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.date_range, size: 18.w,color: Colors.purple[900]),
                                          SizedBox(width: 5.w),
                                          SelectableText(
                                            '01/06/2023',
                                            textAlign: TextAlign.justify,
                                            style: AppStyles.poppins.copyWith(fontSize: 14.w, color: Colors.grey[800]),
                                          ),
                                        ],
                                      ),
                                      // SizedBox(width: 5.h),
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.phone_android_outlined, size: 18.w,color: Colors.purple[900]),
                                          SizedBox(width: 5.w),
                                          SelectableText(
                                            '+918925555742',
                                            textAlign: TextAlign.justify,
                                            style: AppStyles.poppins.copyWith(fontSize: 14.w, color: Colors.grey[800]),
                                          ),
                                        ],
                                      ),
                                      // .ripple(context, (){
                                      //   // UrlLauncher.launchUrl(Uri.parse('tel://${widget.model.phoneNumber.contains('+') ? widget.model.phoneNumber : '+971${widget.model.phoneNumber}'}'));
                                      //   UrlLauncher.launchUrl(Uri.parse('tel://+918925555742'));
                                      // }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // Top Section
      
                            SizedBox(height: 30.h),
      
                            // Below
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 25.w),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  // padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                                  child: const Column(
                                    children: [
                                      // SizedBox(height: 16.h),
                                      _BottomSectionItem(
                                        icon: Icons.email_outlined,
                                        field: 'Email',
                                        value: 'shahil@virtualsystechnologies.com',
                                      ),
                                      _BottomSectionItem(
                                        icon: Icons.home_work_outlined,
                                        field: 'Permanent Address',
                                        value: 'Shree Revabhai Industrial Estate, CTM Sureliya Road, Amraiwadi',
                                      ),
                                      _BottomSectionItem(
                                        icon: Icons.home_outlined,
                                        field: 'Communication Address',
                                        value: 'Grd Floor Sidhartha Chamber, Gokhale Road, Naupada , Opp. Gaodevi Mandir, Naupada',
                                      ),
                                      _BottomSectionItem(
                                        icon: Icons.school_outlined,
                                        field: 'Education / Qualification Information',
                                        value: "Master's in Computer Science, Stanford University, 2020. Specialization: Artificial Intelligence and Machine Learning",
                                      ),
                                      _BottomSectionItem(
                                        icon: Icons.business_center_outlined,
                                        field: 'Previous Experience Information',
                                        value: 'Software Engineer at Google, 5 years. Specialized in backend development and distributed systems architecture',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Below
                          ],
                        ),
                      ),
                    ],
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

class _BottomSectionItem extends StatelessWidget {
  const _BottomSectionItem({required this.field, required this.value, required this.icon});

  final String field;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        // padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
        // decoration: BoxDecoration(
        //   color: Colors.white,
        //   borderRadius: BorderRadius.circular(15),
        //   boxShadow: [
        //     BoxShadow(
        //       color: Colors.grey.withOpacity(0.5),
        //       spreadRadius: 1,
        //       blurRadius: 3,
        //       offset: const Offset(0, 2), // changes position of shadow
        //     ),
        //   ],
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 16.w, color: Colors.purple[900],),
                SizedBox(width: 5.w),
                SelectableText(
                  field,
                  textAlign: TextAlign.justify,
                  // style: AppStyles.poppins.copyWith(fontSize: 13.w, color: Colors.grey[800], fontWeight: FontWeight.bold),
                  style: AppStyles.poppins.copyWith(fontSize: 13.w, color: Colors.purple[900], fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 3.h, left: 8.w),
                child: SelectableText(
                  value,
                  // textAlign: TextAlign.justify,
                  // style: AppStyles.poppins.copyWith(fontSize: 13.w, color: Colors.grey[800], fontStyle: FontStyle.italic),
                  style: AppStyles.poppins.copyWith(fontSize: 13.w, color: Colors.grey[800]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
