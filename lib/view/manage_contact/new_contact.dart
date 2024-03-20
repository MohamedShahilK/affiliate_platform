// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:affiliate_platform/view/common/sidebar.dart';
import 'package:affiliate_platform/view/manage_contact/data_sample.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewContact extends StatelessWidget {
  const NewContact({this.model, super.key});

  final Contact? model;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      haveFloatingButton: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomHeader(isBackButtonNeeded: true, heading: 'Add New Contact'),
            // Padding(
            //   padding: EdgeInsets.only(top: 15.h),
            //   // child: Row(
            //   //   children: [
            //   //     const Expanded(child: Divider(height: 1)),
            //   //     SizedBox(width: 15.w),
            //   //     Text(
            //   //       'Add New Contact',
            //   //       style: AppStyles.poppins.copyWith(fontSize: 16.w),
            //   //     ),
            //   //     SizedBox(width: 15.w),
            //   //     const Expanded(child: Divider(height: 1)),
            //   //   ],
            //   // ),
            //   // child: Padding(
            //   //   padding: EdgeInsets.only(left: 15.w),
            //   //   child: Stack(
            //   //     alignment: Alignment.center,
            //   //     children: [
            //   //       SizedBox(height: 30.h),
            //   //       Positioned(
            //   //         left: 0,
            //   //         right: 0,
            //   //         top: 0,
            //   //         child: Container(
            //   //           height: .6.h,
            //   //           color: Colors.grey[400],
            //   //         ),
            //   //       ),
            //   //       Text(
            //   //         'Add New Contact',
            //   //         style: AppStyles.poppins.copyWith(fontSize: 14.w, fontWeight: FontWeight.w700, color: Colors.grey[600]),
            //   //       ),
            //   //       Positioned(
            //   //         left: 0,
            //   //         right: 0,
            //   //         bottom: 0,
            //   //         child: Container(
            //   //           height: .6.h,
            //   //           color: Colors.grey[400],
            //   //         ),
            //   //       ),
            //   //     ],
            //   //   ),
            //   // ),
            //   child: Padding(
            //     padding: EdgeInsets.only(left: 15.w),
            //     child: Text(
            //       'Add New Contact',
            //       style: AppStyles.openSans.copyWith(fontSize: 13.w, fontWeight: FontWeight.w700, color: Colors.grey[600]),
            //     ),
            //   ),
            // ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Heading

                      // Form Fields

                      Padding(
                        padding: EdgeInsets.only(top: 7.h),
                        child: Column(
                          children: [
                            NewContactField(heading: 'Contact Name', hint: 'Contact Person Full Name', initialValue: model?.name ?? ''),
                            NewContactDropDown(
                              heading: 'Contact Type',
                              hint: 'Select Contact Type',
                              items: model != null ? ['', model!.type, 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                              label: 'Contact Type',
                              initialValue: model?.type ?? '',
                            ), //dropdown
                            NewContactField(heading: 'Mobile Number', hint: 'eg: 9719864631313', textInputType: TextInputType.phone, initialValue: model?.phoneNumber ?? ''),
                            NewContactField(heading: 'Email Address', hint: 'eg: example@exm.com', textInputType: TextInputType.emailAddress, initialValue: model?.email ?? ''),
                            NewContactDropDown(
                              heading: 'Contact Source',
                              hint: 'Select Contact Source',
                              items: model != null ? ['', model!.contactSource, 'Internet', 'Social Media', 'Email'] : ['', 'Internet', 'Social Media', 'Email'],
                              label: 'Contact Source',
                              initialValue: model?.contactSource ?? '',
                            ), //dropdown
                            NewContactField(heading: 'Contact Destination', hint: 'eg: CEO', initialValue: model?.contactDesignation ?? ''),
                            NewContactField(heading: 'Company Name', hint: 'eg: Arabinfotec Pvt Ltd', initialValue: model?.companyName ?? ''),
                            NewContactField(heading: 'Company Landline Number', hint: 'eg: 97163466578', textInputType: TextInputType.phone, initialValue: model?.companyLandline ?? ''),
                            NewContactField(
                              heading: 'Company Website',
                              hint: 'eg: https://arabinfotechllc.com/',
                              textInputType: TextInputType.url,
                              initialValue: model?.companyWebsite ?? '',
                            ),
                            NewContactField(heading: 'Company Location', hint: 'Enter Location', initialValue: model?.companyLocation ?? ''),
                            NewContactLargeField(heading: 'Company Address', hint: 'Enter Adress', initialValue: model?.companyAddress ?? ''),
                            NewContactLargeField(heading: 'Remarks if any', hint: '-- NOTE --', initialValue: model?.remarks ?? ''),
                          ],
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Text('Reset', style: AppStyles.poppins.copyWith(fontSize: 14.w, color: Colors.white)),
                          ),
                          SizedBox(width: 10.w),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Text('Submit', style: AppStyles.poppins.copyWith(fontSize: 14.w, color: Colors.white)),
                          ),
                        ],
                      ),

                      SizedBox(height: 160.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewContactDropDown extends StatefulWidget {
  NewContactDropDown({
    // required this.controller,
    required this.heading,
    required this.hint,
    required this.label,
    required this.initialValue,
    required this.items,
    super.key,
  });

  final String heading;
  final String hint;
  final String label;
  final String initialValue;
  final List<String> items;

  @override
  State<NewContactDropDown> createState() => _NewContactDropDownState();
}

class _NewContactDropDownState extends State<NewContactDropDown> {
  // final items = ['', 'a', 'b', 'c'];

  String selectedValue = '';

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
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
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color.fromARGB(139, 103, 51, 137)),
            ),
            child: DropdownButtonHideUnderline(
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
                          fontSize: 12.w,
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
                  fontSize: 12.w,
                  overflow: TextOverflow.ellipsis,
                ),
                value: selectedValue == '' ? null : selectedValue,
                onChanged: (value) {
                  setState(() {
                    if (value == widget.hint) {
                      selectedValue = '';
                    } else {
                      selectedValue = value!;
                    }
                  });
                },
                buttonStyleData: ButtonStyleData(
                  height: 50,
                  // width: 160,
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
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

class NewContactField extends StatelessWidget {
  const NewContactField({
    // required this.controller,
    required this.heading,
    required this.hint,
    this.initialValue = '',
    this.textInputType = TextInputType.name,
    this.isLargeField = false,
    super.key,
  });

  // final TextEditingController controller;
  final String heading;
  final String hint;
  final String initialValue;
  final bool isLargeField;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(heading, style: AppStyles.poppins.copyWith(fontSize: 12.w, color: Colors.purple)),
          // SizedBox(height: 7.h),
          SizedBox(
            height: isLargeField ? null : 50.h,
            child: TextFormField(
              initialValue: initialValue,
              scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 15.w * 6, // Adjust the value as needed
              ),
              // controller: controller,
              style: AppStyles.poppins.copyWith(
                color: Colors.purple,
                fontSize: 13.w,
              ),
              keyboardType: !isLargeField ? textInputType : TextInputType.multiline,
              // minLines: !isLargeField ? null : 1,
              // maxLines: !isLargeField ? null : 20,
              // maxLength: !isLargeField ? null : 500,
              // expands:isLargeField ,
              // maxLines: null,
              decoration: InputDecoration(
                // isDense: true,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: heading,
                labelStyle: AppStyles.poppins.copyWith(fontSize: 12.w, color: Colors.purple),
                hintText: hint,
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
      ),
    );
  }
}

class NewContactLargeField extends StatelessWidget {
  const NewContactLargeField({
    // required this.controller,
    required this.heading,
    required this.hint,
    this.initialValue = '',
    this.textInputType = TextInputType.name,
    this.isLargeField = false,
    super.key,
  });

  // final TextEditingController controller;
  final String heading;
  final String hint;
  final String initialValue;
  final bool isLargeField;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(heading, style: AppStyles.poppins.copyWith(fontSize: 12.w, color: Colors.purple)),
          // SizedBox(height: 7.h),
          SizedBox(
            height: 100.h,
            child: TextFormField(
              initialValue: initialValue,
              scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 15.w * 6, // Adjust the value as needed
              ),
              // controller: controller,
              style: AppStyles.poppins.copyWith(
                color: Colors.purple,
                fontSize: 13.w,
              ),
              keyboardType: !isLargeField ? textInputType : TextInputType.multiline,
              // minLines: !isLargeField ? null : 1,
              // maxLines: !isLargeField ? null : 20,
              maxLength: 500,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              expands: true,
              maxLines: null,
              decoration: InputDecoration(
                // isDense: true,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: heading,
                labelStyle: AppStyles.poppins.copyWith(fontSize: 12.w, color: Colors.purple),
                hintText: hint,
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
      ),
    );
  }
}
