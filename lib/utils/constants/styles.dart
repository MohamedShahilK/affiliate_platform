import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static TextStyle openSans = GoogleFonts.openSans(
    fontSize: 22,
    color: Colors.white,
  );

  static TextStyle appBarHeadingStyle = GoogleFonts.openSans(
    fontSize: 18,
    color: Colors.white,
  );

  // Drawer
  static TextStyle drawerItemTextstyle = GoogleFonts.openSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  // TextField and DropDown
  static TextStyle fieldHeadingStyle = GoogleFonts.openSans(
    fontWeight: FontWeight.w600,
    fontSize: 11,
  );
  static TextStyle textFieldValueTextstyle = GoogleFonts.openSans();
  static const TextStyle dropDownValueTextstyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );
  static TextStyle hintTextStyle = GoogleFonts.openSans(fontSize: 13.5);
  static TextStyle loginHintTextStyle =
      GoogleFonts.openSans(fontSize: 13.5, color: Colors.grey[700]);

  // static TextStyle generateButtonStyle = GoogleFonts.abhayaLibre(
  //   color: AppColors.generateButtonColor,
  // );
  static TextStyle dropDownHintStyle = GoogleFonts.albertSans(
    fontWeight: FontWeight.bold,
    fontSize: 11,
  );
}
