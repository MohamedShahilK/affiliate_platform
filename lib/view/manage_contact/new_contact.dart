// ignore_for_file: lines_longer_than_80_chars, use_build_context_synchronously

import 'package:affiliate_platform/config/ripple.dart';
import 'package:affiliate_platform/logic/manage_contact/manage_contact_bloc.dart';
import 'package:affiliate_platform/models/manage_contact/contact_form_model.dart';
import 'package:affiliate_platform/models/manage_contact/contact_view_model.dart';
import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/utils/custom_tools.dart';
import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:affiliate_platform/view/common/sidebar.dart';
import 'package:affiliate_platform/view/manage_contact/data_sample.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NewContact extends StatefulWidget {
  const NewContact({this.model, this.contactId, super.key});

  final Contact1? model;
  final String? contactId;

  @override
  State<NewContact> createState() => _NewContactState();
}

class _NewContactState extends State<NewContact> {
  ManageContactBloc? manageContactBloc;

  @override
  void didChangeDependencies() {
    manageContactBloc ??= Provider.of<ManageContactBloc>(context);
    manageContactBloc!.clearStreams();
    if (widget.contactId == null) {
      manageContactBloc!.getContactViewStream.add(null);
    } else {
      manageContactBloc!.getEachEditContact(contactId: widget.contactId!);
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await manageContactBloc!.getContactForm();
      // if (widget.contactId != null) {
      //   await manageContactBloc!.getEachContact(contactId: widget.contactId!);
      // }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<ManageContactBloc>(context);

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
                  child: StreamBuilder(
                    stream: bloc.getContactFormStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
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
                                    Text('Refres11', style: TextStyle(fontSize: 15.w)),
                                  ],
                                ),
                              ).ripple(
                                context,
                                () async {
                                  await bloc.getContactForm();
                                },
                                borderRadius: BorderRadius.circular(15.r),
                                overlayColor: Colors.purple.withOpacity(.15),
                              ),
                            ],
                          ),
                        );
                      }

                      ContactFormModel? allContactsRespModel;

                      if (snapshot.hasData) {
                        allContactsRespModel = snapshot.data;
                        if (allContactsRespModel!.data![0].contactType != null) {
                          // print('22222222222222222222222222222222222 ${allContactsRespModel.data![0].contactType!.values.toList(growable: false)}');
                        }
                      }

                      return StreamBuilder(
                        stream: bloc.getContactViewStream,
                        builder: (context, getContactViewStreamsnapshot) {
                          if ((!getContactViewStreamsnapshot.hasData && getContactViewStreamsnapshot.connectionState == ConnectionState.done) || getContactViewStreamsnapshot.hasError) {
                            Loader.hide();
                            return Expanded(
                              child: Center(
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
                                          Text('Refreshee', style: TextStyle(fontSize: 15.w)),
                                        ],
                                      ),
                                    ).ripple(
                                      context,
                                      () async {
                                        if (widget.contactId != null) {
                                          await bloc.getEachEditContact(contactId: widget.contactId!);
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(15.r),
                                      overlayColor: Colors.purple.withOpacity(.15),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          ContactViewModel? contactViewRespModel;

                          // if (getContactViewStreamsnapshot.connectionState == ConnectionState.waiting) {
                          //   return CircularProgressIndicator();
                          // }

                          if (getContactViewStreamsnapshot.hasData) {
                            contactViewRespModel = getContactViewStreamsnapshot.data;
                            // print('3333333333333333333333333333 ${contactViewRespModel}');

                            if (contactViewRespModel != null && contactViewRespModel.data != null && contactViewRespModel.data!.isNotEmpty) {
                              final contact = contactViewRespModel.data?[0].contact;

                              if (contact != null ) {
                                if (bloc.nameStream.value == '' && contact.name != null && contact.name != '') {
                                  bloc.nameStream.add(contact.name ?? '');
                                }

                                if (contact.contactType != null&& (contact.contactType != '' || contact.contactType!= '0')) {
                                  // final type =
                                  //     snapshot.data!.data![0].contactType!.values.toList(growable: false).where((e) => (e as String) == contact.contactType).toList().first as String?;

                                  // bloc.contactTypeStream.add(type ?? '');

                                  final typeList = snapshot.data!.data![0].contactType!.values.toList(growable: false).map((e) => e as String).toList();

                                  String currentType;

                                  if (contact.contactType != '0') {
                                    currentType = typeList[int.parse(contact.contactType!) - 1];
                                  } else {
                                    currentType = typeList[int.parse(contact.contactType!)];
                                  }

                                  // print(
                                  //     '5555555555555555555555555 ${snapshot.data!.data![0].contactType!.values.toList(growable: false).map((e) => e as String).toList()[int.parse(contact.contactType!)]}');

                                  bloc.contactTypeStream.add(currentType);
                                }

                                if (contact.contactSource != null && (contact.contactSource != '' || contact.contactSource != '0')) {
                                  final list = snapshot.data!.data![0].contactSources!.where((i) => i.id == contact.contactSource).toList();

                                  String source = '';

                                  if (list.isNotEmpty) {
                                    source = list.first.sourceName ?? '';
                                  }

                                  // print('66666666666666666666666666666 ${source} ');

                                  // final currentSource = ;

                                  // print(
                                  //     '5555555555555555555555555 ${snapshot.data!.data![0].contactType!.values.toList(growable: false).map((e) => e as String).toList()[int.parse(contact.contactType!)]}');

                                  bloc.contactSourceStream.add(source == '0' ? '' : source);
                                }

                                if (contact.mobile != null && contact.mobile != '') {
                                  bloc.mobileStream.add(contact.mobile ?? '');
                                }

                                if (contact.email != null && contact.email != '') {
                                  bloc.emailStream.add(contact.email ?? '');
                                }

                                if (contact.designation != null && contact.designation != '') {
                                  bloc.designationStream.add(contact.designation ?? '');
                                }
                                if (contact.company != null && contact.company != '') {
                                  bloc.companyNameStream.add(contact.company ?? '');
                                }

                                if (contact.companyLandline != null && contact.companyLandline != '') {
                                  bloc.landlineStream.add(contact.companyLandline ?? '');
                                }
                                if (contact.companyWebsite != null && contact.companyWebsite != '') {
                                  bloc.websiteStream.add(contact.companyWebsite ?? '');
                                }
                                if (contact.companyLocation != null && contact.companyLocation != '') {
                                  bloc.companyLocationStream.add(contact.companyLocation ?? '');
                                }

                                if (contact.companyAddress != null && contact.companyAddress != '') {
                                  bloc.companyAddressStream.add(contact.companyAddress ?? '');
                                }

                                if (contact.remarks != null && contact.remarks != '') {
                                  bloc.remarkStream.add(contact.remarks ?? '');
                                }
                              }
                            }
                          }

                          return Skeletonizer(
                            enabled: getContactViewStreamsnapshot.connectionState == ConnectionState.waiting,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Heading

                                // Form Fields

                                Padding(
                                  padding: EdgeInsets.only(top: 7.h),
                                  child: Column(
                                    children: [
                                      NewContactField(
                                        heading: 'Contact Name',
                                        hintText: 'Contact Person Full Name',
                                        textStream: bloc.nameStream,
                                        onChanged: bloc.nameStream.add,
                                      ),
                                      NewContactDropDown(
                                        textStream: bloc.contactTypeStream,
                                        heading: 'Contact Type',
                                        hint: 'Select Contact Type',
                                        // items:allContactsRespModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                        items: (allContactsRespModel != null &&
                                                allContactsRespModel.data != null &&
                                                allContactsRespModel.data!.isNotEmpty &&
                                                allContactsRespModel.data?[0].contactType != null)
                                            ? ['', ...allContactsRespModel.data![0].contactType!.values.toList(growable: false).map((e) => e as String)]
                                            : [''],
                                        label: 'Contact Type',
                                        // initialValue: allContactsRespModel == null ? '' : allContactsRespModel.data![0].contactType!.entries.map((e) => e as String).toList().first,
                                        initialValue: widget.model?.type ?? '',
                                      ), //dropdown
                                      NewContactField(
                                        heading: 'Mobile Number',
                                        hintText: 'eg: 9719864631313',
                                        textInputType: TextInputType.phone,
                                        textStream: bloc.mobileStream,
                                        onChanged: bloc.mobileStream.add,
                                      ),
                                      NewContactField(
                                        heading: 'Email Address',
                                        hintText: 'eg: example@exm.com',
                                        textInputType: TextInputType.emailAddress,
                                        textStream: bloc.emailStream,
                                        onChanged: bloc.emailStream.add,
                                      ),
                                      NewContactDropDown(
                                        textStream: bloc.contactSourceStream,
                                        heading: 'Contact Source',
                                        hint: 'Select Contact Source',
                                        // items: widget.model != null ? ['', 'Internet', 'Social Media', 'Email'] : ['', 'Internet', 'Social Media', 'Email'],
                                        items: (allContactsRespModel != null &&
                                                allContactsRespModel.data != null &&
                                                allContactsRespModel.data!.isNotEmpty &&
                                                allContactsRespModel.data?[0].contactSources != null)
                                            ? ['', ...allContactsRespModel.data![0].contactSources!.map((e) => e.sourceName ?? '')]
                                            : [''],
                                        label: 'Contact Source',
                                        initialValue: widget.model?.contactSource ?? '',
                                      ), //dropdown
                                      NewContactField(
                                        heading: 'Contact Designation',
                                        hintText: 'eg: CEO',
                                        textStream: bloc.designationStream,
                                        onChanged: bloc.designationStream.add,
                                      ),
                                      NewContactField(
                                        heading: 'Company Name',
                                        hintText: 'eg: Arabinfotec Pvt Ltd',
                                        textStream: bloc.companyNameStream,
                                        onChanged: bloc.companyNameStream.add,
                                      ),
                                      NewContactField(
                                        heading: 'Company Landline Number',
                                        hintText: 'eg: 97163466578',
                                        textInputType: TextInputType.phone,
                                        textStream: bloc.landlineStream,
                                        onChanged: bloc.landlineStream.add,
                                      ),
                                      NewContactField(
                                        heading: 'Company Website',
                                        hintText: 'eg: https://arabinfotechllc.com/',
                                        textInputType: TextInputType.url,
                                        textStream: bloc.websiteStream,
                                        onChanged: bloc.websiteStream.add,
                                      ),
                                      NewContactField(
                                        heading: 'Company Location',
                                        hintText: 'Enter Location',
                                        textStream: bloc.companyLocationStream,
                                        onChanged: bloc.companyLocationStream.add,
                                      ),
                                      NewContactLargeField(
                                        heading: 'Company Address',
                                        hintText: 'Enter Adress',
                                        textStream: bloc.companyAddressStream,
                                        onChanged: bloc.companyAddressStream.add,
                                      ),
                                      NewContactLargeField(
                                        heading: 'Remarks if any',
                                        hintText: '-- NOTE --',
                                        textStream: bloc.remarkStream,
                                        onChanged: bloc.remarkStream.add,
                                      ),
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
                                    ).ripple(context, () async {
                                      if (widget.contactId == null) {
                                        final contactTypeMap = snapshot.data!.data![0].contactType!;
                                        final contactSourceList = snapshot.data!.data![0].contactSources!;

                                        if (bloc.contactTypeStream.value != '' || bloc.contactSourceStream.value != '') {
                                          final contactTypeKey = contactTypeMap.keys.firstWhere((k) => contactTypeMap[k] == bloc.contactTypeStream.value, orElse: () => '');

                                          final contactSrcKey = contactSourceList.indexWhere((e) => e.sourceName == bloc.contactSourceStream.value);

                                          // print('222222222222222222222222 ${typeList}');

                                          if (contactTypeKey != '') {
                                            bloc.contactTypeIdStream.add(contactTypeKey);
                                          }

                                          if (contactSrcKey != -1) {
                                            bloc.contactSourceIdStream.add(contactSrcKey.toString());
                                          }

                                          final resp = await bloc.submitForm();

                                          if (resp != null && resp.status == 'SUCCESS' && resp.response == 'OK') {
                                            Navigator.pop(context);
                                            await bloc.getAllContacts();
                                            await successMotionToastInfo(context, msg: 'Submitted Done');
                                          } else {
                                            await erroMotionToastInfo(context, msg: 'Submission Failed !!');
                                          }
                                        } else {
                                          final resp = await bloc.submitForm();

                                          if (resp != null && resp.status == 'SUCCESS' && resp.response == 'OK') {
                                            await successMotionToastInfo(context, msg: 'Submitted Done');
                                          } else {
                                            await erroMotionToastInfo(context, msg: 'Submission Failed !!');
                                          }
                                        }
                                      } else {
                                        final contactTypeMap = snapshot.data!.data![0].contactType!;
                                        final contactSourceList = snapshot.data!.data![0].contactSources!;

                                        if (bloc.contactTypeStream.value != '' || bloc.contactSourceStream.value != '') {
                                          final contactTypeKey = contactTypeMap.keys.firstWhere((k) => contactTypeMap[k] == bloc.contactTypeStream.value, orElse: () => '');

                                          final contactSrcKey = contactSourceList.indexWhere((e) => e.sourceName == bloc.contactSourceStream.value);

                                          // print('222222222222222222222222 ${typeList}');

                                          if (contactTypeKey != '') {
                                            bloc.contactTypeIdStream.add(contactTypeKey);
                                          }

                                          if (contactSrcKey != -1) {
                                            bloc.contactSourceIdStream.add(contactSrcKey.toString());
                                          }

                                          final resp = await bloc.contactEdit(contactId: widget.contactId!);

                                          if (resp != null && resp.status == 'SUCCESS' && resp.response == 'OK' && resp.message == 'Contact updated successfully.') {
                                            Navigator.pop(context);
                                            await bloc.getAllContacts();
                                            await successMotionToastInfo(context, msg: 'Updated Successfully');
                                          } else {
                                            await erroMotionToastInfo(context, msg: 'Submission Failed !!');
                                          }
                                        } else {
                                          final resp = await bloc.contactEdit(contactId: widget.contactId!);

                                          if (resp != null && resp.status == 'SUCCESS' && resp.response == 'OK') {
                                            await successMotionToastInfo(context, msg: 'Updated Successfully');
                                          } else {
                                            await erroMotionToastInfo(context, msg: 'Submission Failed !!');
                                          }
                                        }
                                      }
                                    }),
                                  ],
                                ),

                                SizedBox(height: 160.h),
                              ],
                            ),
                          );
                        },
                      );
                    },
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
  const NewContactDropDown({
    // required this.controller,
    required this.textStream,
    required this.heading,
    required this.hint,
    required this.label,
    required this.initialValue,
    required this.items,
    super.key,
  });

  final BehaviorSubject<String> textStream;
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
    final bloc = Provider.of<ManageContactBloc>(context);
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
            child: StreamBuilder(
              stream: widget.textStream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? '';
                print('44444444444444444444444 $data');
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
                    // value: selectedValue == '' ? null : selectedValue,
                    value: data == '' ? null : data,
                    onChanged: (value) {
                      setState(() {
                        if (value == widget.hint) {
                          selectedValue = '';
                          widget.textStream.add(selectedValue);
                        } else {
                          selectedValue = value!;
                          widget.textStream.add(selectedValue);
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

class NewContactField extends StatefulWidget {
  const NewContactField({
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
    super.key,
  });

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
  State<NewContactField> createState() => _NewContactFieldState();
}

class _NewContactFieldState extends State<NewContactField> {
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
                height: widget.isLargeField ? null : 50.h,
                child: TextFormField(
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
                  controller: _controller,
                  validator: widget.validator,
                  onChanged: widget.onChanged,
                  onTap: widget.onTap,
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

class NewContactLargeField extends StatefulWidget {
  const NewContactLargeField({
    // required this.controller,
    required this.heading,
    required this.textStream, // required this.controller,
    required this.hintText,
    this.textInputType = TextInputType.name,
    this.isLargeField = false,
    this.icon,
    this.suffixIcon,
    this.isObscure = false,
    this.enabled = true,
    this.validator,
    this.keyboardType,
    this.onTap,
    this.onChanged,
    super.key,
  });

  // final TextEditingController controller;
  final String heading;

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
  State<NewContactLargeField> createState() => _NewContactLargeFieldState();
}

class _NewContactLargeFieldState extends State<NewContactLargeField> {
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
                height: 100.h,
                child: TextFormField(
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
                  maxLength: 500,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  expands: true,
                  maxLines: null,
                  // maxLines: null,
                  controller: _controller,
                  validator: widget.validator,
                  onChanged: widget.onChanged,
                  onTap: widget.onTap,
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
