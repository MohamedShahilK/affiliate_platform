// ignore_for_file: lines_longer_than_80_chars, use_build_context_synchronously

import 'package:affiliate_platform/config/ripple.dart';
import 'package:affiliate_platform/logic/employee/project/project_bloc.dart';
import 'package:affiliate_platform/logic/manage_contact/manage_contact_bloc.dart';
import 'package:affiliate_platform/models/employee/project/project_form.dart';
import 'package:affiliate_platform/models/employee/project/view_project.dart';
import 'package:affiliate_platform/models/manage_contact/contact_form_model.dart';
import 'package:affiliate_platform/models/manage_contact/contact_view_model.dart';
import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/utils/custom_tools.dart';
import 'package:affiliate_platform/view/common/custom_header.dart';
import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:affiliate_platform/view/common/sidebar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NewProject extends StatefulWidget {
  const NewProject({
    this.projectId,
    super.key,
  });

  final String? projectId;

  @override
  State<NewProject> createState() => _NewProjectState();
}

class _NewProjectState extends State<NewProject> {
  ProjectBloc? projectBloc;

  bool loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // projectBloc ??= Provider.of<ProjectBloc>(context);
      // projectBloc!.clearStreams();
      await projectBloc!.getContactForm();
      if (widget.projectId == null) {
        projectBloc!.getProjectViewStream.add(null);
        setState(() {
          loading = false;
        });
      } else {
        await projectBloc!.viewProject(projectId: widget.projectId!).then(
              (value) => setState(() {
                loading = false;
              }),
            );
      }
      // if (widget.contactId != null) {
      //   await manageContactBloc!.getEachContact(contactId: widget.contactId!);
      // }
    });
  }

  @override
  void didChangeDependencies() {
      projectBloc ??= Provider.of<ProjectBloc>(context);
      projectBloc!.clearStreams();

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   await projectBloc!.getContactForm();
    //   if (widget.projectId == null) {
    //     projectBloc!.getProjectViewStream.add(null);
    //     setState(() {
    //       loading = false;
    //     });
    //   } else {
    //     await projectBloc!.viewProject(projectId: widget.projectId!).then(
    //           (value) => setState(() {
    //             loading = false;
    //           }),
    //         );
    //   }
    //   // if (widget.contactId != null) {
    //   //   await manageContactBloc!.getEachContact(contactId: widget.contactId!);
    //   // }
    // });

    // setState(() {
    //   loading = false;
    // });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<ProjectBloc>(context);

    return CustomScaffold(
      haveFloatingButton: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomHeader(isBackButtonNeeded: true, heading: 'Add New Project'),
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
                    stream: bloc.getProjectFormStream,
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

                      ProjectForm? projectFormModel;

                      if (snapshot.hasData) {
                        projectFormModel = snapshot.data;
                        // if (projectFormModel!.data![0].contactType != null) {
                        //   // print('22222222222222222222222222222222222 ${projectFormModel.data![0].contactType!.values.toList(growable: false)}');
                        // }
                      }

                      return StreamBuilder(
                        stream: bloc.getProjectViewStream,
                        builder: (context, getContactViewStreamsnapshot) {
                          // if (!getContactViewStreamsnapshot.hasData && !loading) {
                          //   // Loader.hide();
                          //   return SizedBox(
                          //     height: MediaQuery.of(context).size.height - 60,
                          //     child: Column(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         Container(),
                          //         Text(
                          //           'Something went wrong',
                          //           style: TextStyle(fontSize: 16.w),
                          //         ),
                          //         SizedBox(height: 30.h),
                          //         Container(
                          //           padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 8.h),
                          //           decoration: BoxDecoration(
                          //             border: Border.all(color: Colors.purple[100]!),
                          //             borderRadius: BorderRadius.circular(15.r),
                          //           ),
                          //           child: Row(
                          //             mainAxisSize: MainAxisSize.min,
                          //             mainAxisAlignment: MainAxisAlignment.center,
                          //             children: [
                          //               Icon(Icons.refresh, size: 17.w),
                          //               SizedBox(width: 5.w),
                          //               Text('Refresh', style: TextStyle(fontSize: 15.w)),
                          //             ],
                          //           ),
                          //         ).ripple(
                          //           context,
                          //           () async {
                          //             // customLoader(context);
                          //             // if (widget.contactId != null) {
                          //             //   await bloc.viewContact(contactId: widget.contactId!).then((value) => Loader.hide());
                          //             // }
                          //           },
                          //           borderRadius: BorderRadius.circular(15.r),
                          //           overlayColor: Colors.purple.withOpacity(.15),
                          //         ),
                          //       ],
                          //     ),
                          //   );
                          // }

                          ProjectView? contactViewRespModel;

                          // if (getContactViewStreamsnapshot.connectionState == ConnectionState.waiting) {
                          //   return CircularProgressIndicator();
                          //

                          if (getContactViewStreamsnapshot.hasData) {
                            contactViewRespModel = getContactViewStreamsnapshot.data;
                            // print('3333333333333333333333333333 ${contactViewRespModel}');

                            if (contactViewRespModel != null && contactViewRespModel.data != null && contactViewRespModel.data!.isNotEmpty) {
                              final project = contactViewRespModel.data?[0].projects;

                              if (project != null) {
                                // if (bloc.projectNameStream.value == '' && project.name != null && project.name != '') {
                                if (project.name != null && project.name != '') {
                                  bloc.projectNameStream.add(project.name ?? '');
                                } else {
                                  bloc.projectNameStream.add('');
                                }

                                if (project.contactName != null && (project.contactName != '')) {
                                  final clientList = snapshot.data!.data![0].contactList ?? [];
                                  var clientId = '0';

                                  final oneItem = clientList.firstWhereOrNull((e) => e.contactName == project.contactName);
                                  if (oneItem != null) {
                                    clientId = oneItem.contactID ?? '';
                                  }

                                  var client = '';

                                  if (project.contactName != '') {
                                    client = project.contactName ?? '';
                                  }

                                  bloc.clientStream.add(client);
                                  bloc.clientIdStream.add(clientId);
                                }

                                if (project.quotationRefr != null && (project.quotationRefr != '')) {
                                  final quotationList = snapshot.data!.data![0].quotationList ?? [];

                                  var quotationId = '0';

                                  var quotation = '';

                                  final oneItem = quotationList.firstWhereOrNull((e) => e.quoteRefr == project.quotationRefr);
                                  if (project.quotationRefr != '') {
                                    quotation = project.quotationRefr ?? '';
                                  }

                                  if (oneItem != null) {
                                    quotationId = oneItem.quoteID ?? '';
                                  }

                                  bloc.quotationRefereneceStream.add(quotation);
                                  bloc.quotationIdStream.add(quotationId);
                                }

                                if (project.status != null && (project.status != '')) {
                                  final statusList = snapshot.data!.data![0].projectStatus ?? [];

                                  var statusId = '0';

                                  var status = '';

                                  // final oneItem = statusList.firstWhereOrNull((e) => e == getStatusId(status: project.status ?? '') );
                                  final oneItem = statusList[int.parse(project.status ?? '0')];
                                  if (project.quotationRefr != '') {
                                    status = oneItem;
                                  }

                                  if (oneItem != null) {
                                    statusId = getStatusId(status: oneItem);
                                    // print('11111111111111111111 ${statusId}');
                                  }

                                  bloc.statusStream.add(status);
                                  bloc.statusIdStream.add(statusId);
                                }

                                // if (bloc.projectNameStream.value == '' && project.name != null && project.name != '') {
                                if (project.startDate != null && project.startDate != '') {
                                  bloc.startDateStream.add(project.startDate ?? '');
                                }

                                // if (bloc.projectNameStream.value == '' && project.name != null && project.name != '') {
                                if (project.endDate != null && project.endDate != '') {
                                  bloc.endDateStream.add(project.endDate ?? '');
                                }

                                // if (bloc.projectNameStream.value == '' && project.name != null && project.name != '') {
                                if (project.description != null && project.description != '') {
                                  bloc.descriptionStream.add(project.description ?? '');
                                }
                              } else {
                                bloc.projectNameStream.add('');
                              }
                            }
                          }

                          return Skeletonizer(
                            enabled: loading,
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
                                        heading: 'Project Name',
                                        hintText: 'Project',
                                        textStream: bloc.projectNameStream,
                                        onChanged: bloc.projectNameStream.add,
                                      ),
                                      NewContactDropDown(
                                        projectFormModel: projectFormModel,
                                        textStream: bloc.clientStream,

                                        heading: 'Client',
                                        hint: 'Select Client',
                                        // items:projectFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                        items:
                                            (projectFormModel != null && projectFormModel.data != null && projectFormModel.data!.isNotEmpty && projectFormModel.data?[0].contactList != null)
                                                ? ['', ...projectFormModel.data![0].contactList!.map((e) => e.contactName ?? '')]
                                                : [''],
                                        label: 'Client',
                                        // initialValue: projectFormModel == null ? '' : projectFormModel.data![0].contactType!.entries.map((e) => e as String).toList().first,
                                        // initialValue: widget.model?.type ?? '',
                                      ), //dropdown
                                      NewContactDropDown(
                                        projectFormModel: projectFormModel,
                                        textStream: bloc.quotationRefereneceStream,
                                        heading: 'Quotation',
                                        hint: 'Select Quotation',
                                        // items:projectFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                        items: (projectFormModel != null &&
                                                projectFormModel.data != null &&
                                                projectFormModel.data!.isNotEmpty &&
                                                projectFormModel.data?[0].quotationList != null)
                                            ? ['', ...projectFormModel.data![0].quotationList!.map((e) => e.quoteRefr ?? '')]
                                            : [''],
                                        label: 'Quotation',
                                        // initialValue: projectFormModel == null ? '' : projectFormModel.data![0].contactType!.entries.map((e) => e as String).toList().first,
                                        // initialValue: widget.model?.type ?? '',
                                      ), //dropdown
                                      NewContactDropDown(
                                        projectFormModel: projectFormModel,
                                        textStream: bloc.statusStream,
                                        heading: 'Status',
                                        hint: 'Select Status',
                                        // items:projectFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                        items: (projectFormModel != null &&
                                                projectFormModel.data != null &&
                                                projectFormModel.data!.isNotEmpty &&
                                                projectFormModel.data?[0].projectStatus != null)
                                            ? ['', ...projectFormModel.data![0].projectStatus ?? []]
                                            : [''],
                                        label: 'Status',
                                        // initialValue: projectFormModel == null ? '' : projectFormModel.data![0].contactType!.entries.map((e) => e as String).toList().first,
                                        // initialValue: widget.model?.type ?? '',
                                      ), //dropdown
                                      NewContactField(
                                        heading: 'Start Date',
                                        hintText: '',
                                        textInputType: TextInputType.text,
                                        textStream: bloc.startDateStream,
                                        onChanged: bloc.startDateStream.add,
                                      ),
                                      NewContactField(
                                        heading: 'End Date',
                                        hintText: '',
                                        textInputType: TextInputType.text,
                                        textStream: bloc.endDateStream,
                                        onChanged: bloc.endDateStream.add,
                                      ),
                                      NewContactLargeField(
                                        heading: 'Description',
                                        hintText: '-- NOTE --',
                                        textStream: bloc.descriptionStream,
                                        onChanged: bloc.descriptionStream.add,
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
                                      customLoader(context);
                                      // if new project
                                      if (widget.projectId == null && projectFormModel != null && projectFormModel.data != null && projectFormModel.data!.isNotEmpty) {
                                        final customerId = projectFormModel.data?[0].contactList?.firstWhereOrNull((e) => e.contactName == bloc.clientStream.value)?.contactID;
                                        final quotationId = projectFormModel.data?[0].quotationList?.firstWhereOrNull((e) => e.quoteRefr == bloc.quotationRefereneceStream.value)?.quoteID;

                                        final resp = await bloc.submitProjectForm(context, customerId: customerId, quotationId: quotationId);

                                        if (resp != null && resp['status'] == 'SUCCESS' && resp['response'] == 'OK') {
                                          Navigator.pop(context);
                                          await successMotionToastInfo(context, msg: resp['message'] as String);
                                          await bloc.getAllProjects();
                                          Loader.hide();
                                        } else {
                                          await erroMotionToastInfo(context, msg: 'Submission Failed !!');
                                          Loader.hide();
                                        }
                                        // }
                                      }
                                      // else existing project
                                      else if (widget.projectId != null && projectFormModel != null && projectFormModel.data != null && projectFormModel.data!.isNotEmpty) {
                                        final customerId = projectFormModel.data?[0].contactList?.firstWhereOrNull((e) => e.contactName == bloc.clientStream.value)?.contactID;
                                        final quotationId = projectFormModel.data?[0].quotationList?.firstWhereOrNull((e) => e.quoteRefr == bloc.quotationRefereneceStream.value)?.quoteID;

                                        print('211231223213212323 $customerId');
                                        print('211231223213212323 $quotationId');

                                        final resp = await bloc.projectEdit(projectId: widget.projectId ?? '', customerId: customerId, quotationId: quotationId);

                                        if (resp != null && resp['status'] == 'SUCCESS' && resp['response'] == 'OK') {
                                          Navigator.pop(context);
                                          await successMotionToastInfo(context, msg: (resp['message'] as String?) ?? 'Project updated successfully');
                                          await bloc.getAllProjects();
                                          Loader.hide();
                                        } else {
                                          await erroMotionToastInfo(context, msg: 'Updation Failed !!');
                                          Loader.hide();
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

String getStatusId({required String status}) {
  if (status == 'Inactive') {
    return '0';
  } else if (status == 'Active') {
    return '1';
  } else if (status == 'Completed') {
    return '2';
  } else if (status == 'On Hold') {
    return '3';
  } else {
    return '-1';
  }
}

class NewContactDropDown extends StatefulWidget {
  const NewContactDropDown({
    // required this.controller,
    required this.textStream,
    required this.heading,
    required this.hint,
    required this.label,
    // required this.initialValue,
    required this.items,
    super.key,
    this.projectFormModel,
  });

  final BehaviorSubject<String> textStream;
  final String heading;
  final String hint;
  final String label;
  // final String initialValue;
  final List<String> items;
  final ProjectForm? projectFormModel;

  @override
  State<NewContactDropDown> createState() => _NewContactDropDownState();
}

class _NewContactDropDownState extends State<NewContactDropDown> {
  // final items = ['', 'a', 'b', 'c'];

  // String selectedValue = '';

  @override
  void initState() {
    super.initState();
    // selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.items);
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
                // print('44444444444444444444444 $data');
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

                        // print('9898988999898989898988 $item1');
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
                          // selectedValue = '';
                          widget.textStream.add('');
                        } else {
                          // selectedValue = value!;
                          widget.textStream.add(value!);
                          // if (widget.heading == 'Client') {

                          // }else  if (widget.heading == 'Quotation') {

                          // }else if (widget.heading == 'Status'){}
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
                height: 150.h,
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
