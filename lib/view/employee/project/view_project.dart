// ignore_for_file: lines_longer_than_80_chars, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:affiliate_platform/config/ripple.dart';
import 'package:affiliate_platform/logic/employee/project/project_bloc.dart';
import 'package:affiliate_platform/logic/employee/project/project_bloc.dart';
import 'package:affiliate_platform/logic/manage_contact/manage_contact_bloc.dart';
import 'package:affiliate_platform/models/manage_contact/contact_view_model.dart';
import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/utils/custom_tools.dart';
import 'package:affiliate_platform/view/common/custom_header.dart';
import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:affiliate_platform/view/common/sidebar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skeletonizer/skeletonizer.dart';

ValueNotifier<List<List<String?>?>?> affUsersHavePerm = ValueNotifier([]);

class ViewProject extends StatefulWidget {
  const ViewProject({
     this.projectId,
    super.key,
  });

  final String? projectId;

  @override
  State<ViewProject> createState() => _ViewProjectState();
}

class _ViewProjectState extends State<ViewProject> {
  var _refreshKey = UniqueKey();
  ProjectBloc? projectBloc;

  bool loading = true;

  @override
  void initState() {
    super.initState();
    affUsersHavePerm.value = [];
    affUsersHavePerm.notifyListeners();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    projectBloc ??= Provider.of<ProjectBloc>(context);
    projectBloc!.viewProject(projectId: widget.projectId!).then(
          (value) => setState(() {
            loading = false;
          }),
        );

    // setState(() {
    //   loading = false;
    // });
  }

  // To update or hot reload
  void _handleLocaleChanged() => setState(() {
        _refreshKey = UniqueKey();
      });
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<ProjectBloc>(context);
    return CustomScaffold(
      key: _refreshKey,
      haveFloatingButton: false,
      body: SafeArea(
        child: GestureDetector(
          // onTap: _handleLocaleChanged,
          // onTap: _handleLocaleChanged,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomHeader(isBackButtonNeeded: true, heading: 'Project Details'),

              //
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 16.h),
                    child: StreamBuilder(
                      stream: bloc.getProjectViewStream,
                      builder: (context, getContactViewStreamsnapshot) {
                         if (!getContactViewStreamsnapshot.hasData && !loading) {
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
                                        if (widget.projectId != null) {
                                          await bloc.viewProject(projectId: widget.projectId!);
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
                        final data = getContactViewStreamsnapshot.data?.data?[0];
                        final model = getContactViewStreamsnapshot.data?.data?[0].projects;
                        return Skeletonizer(
                          enabled: loading,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(),
                              SizedBox(height: 10.h),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text('Company Information', style: AppStyles.poppins.copyWith(fontSize: 13.w, color: Colors.grey[800], fontWeight: FontWeight.w800)),

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
                                              Icon(Icons.book_outlined, size: 13.w),
                                              SizedBox(width: 5.w),
                                              Text('Project Name', style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800])),
                                              const Spacer(),
                                              SelectableText(model?.name ?? '-', style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800], fontWeight: FontWeight.w800)),
                                            ],
                                          ),
                                        ),

                                        // _NewCardItem(field: 'Phone Number', value: model.phoneNumber, icondata: Icons.phone_outlined),
                                        // _NewCardItem(field: 'Name', value: model?.name ?? '-', icondata: Icons.person_2_outlined),
                                        _NewCardItem(field: 'Client', value: model?.contactName ?? '-', icondata: Icons.person_pin_outlined),
                                        _NewCardItem(field: 'Quotation', value: model?.quotationRefr ?? '-', icondata: Icons.note_alt_outlined),
                                        _NewCardItem(field: 'Start Date', value: model?.startDate ?? '-', icondata: Icons.date_range),
                                        _NewCardItem(field: 'End Date', value: model?.endDate ?? '-', icondata: Icons.date_range),
                                        // _NewCardItem(field: 'Description', value: model?.description ?? '-', icondata: Icons.description_outlined),

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
                                              Icon(Icons.stairs_outlined, size: 13.w),
                                              SizedBox(width: 5.w),
                                              Text('Description', style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800])),
                                              const Spacer(),
                                              SelectableText(
                                                model?.description ?? '-',
                                                style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800], fontWeight: FontWeight.w800),
                                              ),
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
                        );
                      },
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

  // Color getRandomColor() {
  //   final random = Random();
  //   var red = random.nextInt(256);
  //   var green = random.nextInt(256);
  //   var blue = random.nextInt(256);

  //   // Ensure the generated color is not white (255, 255, 255)
  //   while (red == 255 && green == 255 && blue == 255) {
  //     red = random.nextInt(256);
  //     green = random.nextInt(256);
  //     blue = random.nextInt(256);
  //   }

  //   return Color.fromARGB(255, red, green, blue);
  // }

  // Color getRandomColor() {
  //   Random random = Random();
  //   Color color;
  //   do {
  //     int red = random.nextInt(128); // Generating a darker shade for red
  //     int green = random.nextInt(128); // Generating a darker shade for green
  //     int blue = random.nextInt(128); // Generating a darker shade for blue
  //     color = Color.fromARGB(255, red, green, blue);
  //   } while (color == Colors.white);
  //   return color;
  // }

  void _addPermissionsDialog(BuildContext context, Data? contact) {
    final bloc = Provider.of<ManageContactBloc>(context, listen: false);

    // ignore: inference_failure_on_function_invocation
    final currentUserId = contact?.contact?.createdBy;
    final permissionUsersIdList = contact?.permissionUserIds;

    // var permList = [];

    if (affUsersHavePerm.value!.isEmpty) {
      affUsersHavePerm = ValueNotifier(
        contact?.affiliateUsers?.map((e) {
          if (permissionUsersIdList != null) {
            // permList = permissionUsersIdList;
            for (final id in permissionUsersIdList) {
              // print(permissionUsersIdList);
              if (id == e.id) {
                // print(currentUserId);
                return [e.firstName, e.id];
              }
            }
          }
        }).toList(),
      );
    }

    affUsersHavePerm.value?.removeWhere((element) {
      // remove the owner name from displaying as chip in dialog box
      if (contact?.contact?.createdBy == element?[1]) {
        print('777777777777777777777777777777777777777777777777777777777777');
        return true;
      }

      // remove all null values
      return element == null;
    });

    // print(affUsersHavePerm);

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
              child: ValueListenableBuilder(
                valueListenable: affUsersHavePerm,
                builder: (context, value, _) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(),

                      if (affUsersHavePerm.value != null && affUsersHavePerm.value!.isNotEmpty)
                        Column(
                          children: [
                            SizedBox(height: 10.h),
                            Wrap(
                              runSpacing: 5.h,
                              spacing: 2.w,
                              children: List.generate(
                                affUsersHavePerm.value!.length,
                                (index) => Container(
                                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
                                  decoration: BoxDecoration(color: Colors.green[900], borderRadius: BorderRadius.circular(6.r)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        affUsersHavePerm.value?[index]?[0] ?? 'None',
                                        style: AppStyles.poppins.copyWith(fontSize: 12.w, color: Colors.white),
                                      ),
                                      SizedBox(width: 3.w),
                                      Icon(Icons.close, size: 14.w, color: Colors.white).ripple(context, () async {
                                        final isTrue = await showWarningDialog(
                                          context,
                                          title: 'Remove User',
                                          description: 'Are you sure want to delete the user from permissions?',
                                          yes: 'Remove',
                                          no: 'Cancel',
                                        );

                                        if (isTrue != null && isTrue) {
                                          customLoader(context);
                                          // final isDeleted = await bloc.deletePermissionForAffUsers(context, contactId: widget.contactId, affUserId: affUsersHavePerm.value?[index]?[1] ?? '');
                                          // if (isDeleted) {
                                          //   setState(() async {
                                          //     await successMotionToastInfo(context, msg: 'Contact permission deleted successfully.');
                                          //     // bool isPresent = false;
                                          //     for (final innerList in affUsersHavePerm.value!) {
                                          //       if (innerList!.contains(affUsersHavePerm.value?[index]?[1])) {
                                          //         affUsersHavePerm.value?.remove(innerList);
                                          //         affUsersHavePerm.notifyListeners();
                                          //         Loader.hide();
                                          //         // isPresent = true;
                                          //         break;
                                          //       }
                                          //     }
                                          //     // affUsersHavePerm.value = [];
                                          //     // // permList
                                          //     // affUsersHavePerm.notifyListeners();
                                          //   });
                                          //   Loader.hide();
                                          // } else {
                                          //   Loader.hide();
                                          // }
                                        }
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      else
                        Text(
                          'No Permissions Given To Users!!',
                          style: AppStyles.poppins.copyWith(fontSize: 10.w, fontWeight: FontWeight.w700, color: Colors.red),
                        ),

                      SizedBox(height: 10.h),

                      // Permission add button
                      // Container(
                      //   padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                      //   decoration: BoxDecoration(color: Colors.purple[400], borderRadius: BorderRadius.circular(15.r)),
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: [
                      //       Icon(
                      //         Icons.add,
                      //         size: 13.w,
                      //         color: Colors.white,
                      //       ),
                      //       Text(
                      //         'Add Permission',
                      //         style: AppStyles.poppins.copyWith(fontSize: 10.w, fontWeight: FontWeight.w700, color: Colors.white),
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: PermissionsDropDown(
                          textStream: bloc.permissionStream,
                          heading: 'Affiliate Users',
                          hint: 'Select User',
                          // items: widget.model != null ? ['', 'Internet', 'Social Media', 'Email'] : ['', 'Internet', 'Social Media', 'Email'],
                          // items: (contact != null && contact.affiliateUsers != null && contact.affiliateUsers!.isNotEmpty)
                          //     ? ['', ...contact.affiliateUsers!.map((e) => e.firstName ?? '')]
                          //     : [''],
                          items: (contact != null && contact.affiliateUsers != null && contact.affiliateUsers!.isNotEmpty)
                              ? contact.affiliateUsers!.map((e) {
                                  if (e.id == contact.contact?.createdBy) {
                                    return [''];
                                  }
                                  return [e.firstName ?? '', e.id ?? ''];
                                }).toList()
                              : [],
                          label: 'Affiliate Users',
                          // initialValue: widget.model?.contactSource ?? '',
                          contactModel: contact,
                          // permissionUsersNotifier: affUsersHavePerm,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Positioned(
              top: 5.h,
              right: 10.w,
              child: Container(
                height: 18.w,
                width: 18.w,
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

class PermissionsDropDown extends StatefulWidget {
  const PermissionsDropDown({
    // required this.controller,
    required this.textStream,
    required this.heading,
    required this.hint,
    required this.label,
    // required this.initialValue,
    required this.items,
    required this.contactModel,
    // required this.permissionUsersNotifier,
    super.key,
  });

  final BehaviorSubject<List<String>> textStream;
  final String heading;
  final String hint;
  final String label;
  // final String initialValue;
  final List<List<String>> items;
  final Data? contactModel;
  // final ValueNotifier<List<String?>?> permissionUsersNotifier;

  @override
  State<PermissionsDropDown> createState() => _PermissionsDropDownState();
}

class _PermissionsDropDownState extends State<PermissionsDropDown> {
  // final items = ['', 'a', 'b', 'c'];

  // String selectedValue = '';

  @override
  void initState() {
    super.initState();
    // selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.items);
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
              builder: (ctx, snapshot) {
                final data = snapshot.data ?? [];
                // print('44444444444444444444444 $data');
                return DropdownButtonHideUnderline(
                  child: DropdownButton2(
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
                      (List<String> item) {
                        var item1 = item;
                        if (item.isEmpty) {
                          item1[0] = widget.hint;
                        }
                        return DropdownMenuItem(
                          value: item1,
                          child: Text(
                            item1[0],
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
                    value: data.isEmpty ? null : data,
                    // value: data,
                    onChanged: (value) {
                      customLoader(context);
                      setState(() async {
                        if (value?[0] == widget.hint) {
                          // selectedValue = '';
                          // widget.textStream.add([selectedValue,data[1]]);

                          widget.textStream.add([]);
                          Loader.hide();
                        } else {
                          // selectedValue = value![0];
                          if (value!.isNotEmpty) {
                            // widget.textStream.add(['Giridhar', '36']);
                            // widget.textStream.value.c
                            // widget.textStream.add(value.isEmpty ? [] : [value[0], value[1]]);
                            print('333333333333333333333333333333 ${value}');
                            print('555555555555555555555555555555 ${widget.textStream.value}');
                          } else {
                            await erroMotionToastInfo(context, msg: 'Something wrong!!');
                            Loader.hide();
                          }

                          // final alreadyThere = affUsersHavePerm.value?.contains([selectedValue]) ?? false;

                          // if (alreadyThere) {
                          //   await erroMotionToastInfo(context, msg: 'Already Selected');
                          //   Loader.hide();
                          //   return;
                          // }

                          final list = widget.contactModel?.affiliateUsers?.where((e) {
                            if (value.isNotEmpty) {
                              return value[0] == e.firstName && value[1] == e.id;
                            }
                            return false;
                          }).toList();
                          if (list != null && list.isNotEmpty) {
                            final affUserId = list[0].id;

                            // affUsersHavePerm.value?.add([list[0].firstName, affUserId]);

                            // final alreadyThere = affUsersHavePerm.value?.contains([value[0], value[1]]) ?? false;
                            // bool alreadyThere = true;
                            // final l = affUsersHavePerm.value?.any((e) => e == ['Anakha', '37']) ?? false;
                            // print('000000000000000000000000000000000000000000000000000000');
                            // if (l != null && l.first == null) {
                            //   alreadyThere = false;
                            // } else {
                            //   alreadyThere = true;
                            // }

                            bool isPresent = false;
                            for (final innerList in affUsersHavePerm.value!) {
                              if (innerList!.contains(list[0].id)) {
                                isPresent = true;
                                break;
                              }
                            }

                            print('99999999999999999999999999999999999999999 $isPresent');
                            print('wwwwwwwwwwwwwwwwwwwwwwwwwwww ${[list[0].firstName, list[0].id]}');

                            if (isPresent) {
                              // affUsersHavePerm.value?.removeLast();
                              await erroMotionToastInfo(context, msg: 'Already Selected');
                              Loader.hide();
                              return;
                            }

                            final isAdded = await bloc.addPermissionForAffUsers(contactId: widget.contactModel?.id ?? '', affUserId: affUserId ?? '');

                            if (isAdded) {
                              await successMotionToastInfo(context, msg: 'Contact permission updated successfully.');
                              affUsersHavePerm.value?.add([list[0].firstName, affUserId]);
                              affUsersHavePerm.notifyListeners();
                              print('99999999999999999999999999999999999999999 ${affUsersHavePerm.value}');
                            } else {
                              Loader.hide();
                            }
                          } else {
                            await erroMotionToastInfo(context, msg: 'Something wrong!!');
                          }
                          Loader.hide();
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
              child: SelectableText(value, textAlign: TextAlign.justify, style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800], fontWeight: FontWeight.w800)),
            ),
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
