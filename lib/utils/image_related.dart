// ignore_for_file: lines_longer_than_80_chars

import 'dart:io';

import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

// mixin ImagePickerMixin on Widget {
mixin ImagePickerMixin {
  Future<ImageSource?> selectImagePickerSource(BuildContext context) {
    return showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera_alt_outlined, size: 17.w),
                title: Text('Camera', style: AppStyles.poppins.copyWith(fontSize: 14.w, color: Colors.grey[800], fontWeight: FontWeight.w800)),
                trailing: Icon(Icons.arrow_forward_ios_rounded, size: 17.w),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
              SizedBox(height: 10.h),
              ListTile(
                leading: Icon(Icons.photo_size_select_actual_outlined, size: 17.w),
                title: Text('Gallery', style: AppStyles.poppins.copyWith(fontSize: 14.w, color: Colors.grey[800], fontWeight: FontWeight.w800)),
                trailing: Icon(Icons.arrow_forward_ios_rounded, size: 17.w),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<XFile?> pickXFileImage(
    BuildContext context, {
    ImageSource imageSource = ImageSource.gallery,
  }) async {
    XFile? xFile;
    // await _checkForPermissions(context, imageSource, pickVideo)
    // await _checkForPermissions(context, imageSource)
    //     .then((value) async {
    //   if (value) {
    //     final imagePicker = ImagePicker();
    //     try {
    //       xFile =
    //           await imagePicker.pickImage(source: imageSource, maxWidth: 512);
    //     } catch (e) {
    //       debugPrint(e.toString());
    //       return null;
    //     }
    //   }
    // });
    final imagePicker = ImagePicker();
    try {
      // xFile = await imagePicker.pickImage(source: imageSource, maxWidth: 512);
      xFile = await imagePicker.pickImage(source: imageSource, maxWidth: 800, maxHeight: 600);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
    return xFile;
  }

  Future<File> compressAndResizeImage(File imageFile) async {
    final result = await FlutterImageCompress.compressAndGetFile(
      imageFile.path,
      '${imageFile.path}_compressed.jpg',
      quality: 90, // Adjust quality as needed (0 to 100).
    );

    return File(result!.path);
  }
}
