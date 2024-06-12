// ignore_for_file: lines_longer_than_80_chars, use_build_context_synchronously

import 'package:affiliate_platform/config/extra_extensions.dart';
import 'package:affiliate_platform/config/ripple.dart';
import 'package:affiliate_platform/logic/employee/checkin/checkin_bloc.dart';
import 'package:affiliate_platform/logic/employee/checkout/checkout_bloc.dart';
import 'package:affiliate_platform/models/employee/checkin/get_checkin_form.dart';
import 'package:affiliate_platform/models/employee/checkout/get_checkout_form_model.dart';
import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/utils/custom_tools.dart';
import 'package:affiliate_platform/utils/utility_functions.dart';
import 'package:affiliate_platform/view/common/custom_header.dart';
import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:affiliate_platform/view/employee/project/new_project.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NewCheckOut extends StatefulWidget {
  const NewCheckOut({
    required this.checkoutDateTimeStr,
    super.key,
  });

  final String checkoutDateTimeStr;

  @override
  State<NewCheckOut> createState() => _NewCheckOutState();
}

class _NewCheckOutState extends State<NewCheckOut> {
  CheckOutBloc? checkOutBloc;

  bool loading = true;

  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await checkOutBloc!.getCheckOutForm(dateTimeStr: widget.checkoutDateTimeStr).then(
            (value) => setState(() {
              loading = false;
            }),
          );
    });
  }

  @override
  void didChangeDependencies() {
    checkOutBloc ??= Provider.of<CheckOutBloc>(context);
    checkOutBloc!.clearStreams();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<CheckOutBloc>(context);
    // ignore: cascade_invocations
    // bloc.clearStreams();
    print('3333333333333333333333333333 ${bloc.descriptionStream2.value}');

    return CustomScaffold(
      haveFloatingButton: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomHeader(isBackButtonNeeded: true, heading: 'Check-Out Details'),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
                  child: StreamBuilder(
                    stream: bloc.getCheckOutFormStream,
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
                                  await bloc.getCheckOutForm(dateTimeStr: widget.checkoutDateTimeStr);
                                },
                                borderRadius: BorderRadius.circular(15.r),
                                overlayColor: Colors.purple.withOpacity(.15),
                              ),
                            ],
                          ),
                        );
                      }

                      GetCheckOutFormModel? checkinFormModel;

                      if (snapshot.hasData) {
                        checkinFormModel = snapshot.data;
                        if (checkinFormModel!.data![0].userID != null && checkinFormModel.data![0].employeeList != null && checkinFormModel.data![0].employeeList!.isNotEmpty) {
                          final employeeName = checkinFormModel.data![0].employeeList!.firstWhere((e) => e.id == checkinFormModel?.data?[0].userID).firstName;
                          bloc.employeeStream.add(employeeName ?? '');
                        }

                        if (checkinFormModel.data![0].userID != null && checkinFormModel.data![0].checkOutProjectData != null && checkinFormModel.data![0].checkOutProjectData!.isNotEmpty) {
                          final checkIndatetime = checkinFormModel.data![0].checkIndatetime;
                          // print('sdlsakdksadkasdl $datetime');
                          bloc.checkinTimeStream.add(checkIndatetime ?? '');
                        }

                        bloc.workFromStream.add('Office');

                        final date = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
                        // print('asdsadasdasd $date');
                        bloc.checkoutTimeStream.add(date);

                        bloc.breakHrsStream.add('01:00');

                        if (checkinFormModel.data![0].checkOutProjectData != null &&
                            checkinFormModel.data![0].checkOutProjectData!.isNotEmpty &&
                            checkinFormModel.data![0].checkOutProjectData?[0].remarks != '') {
                          // final employeeName = checkinFormModel.data![0].employeeList!.firstWhere((e) => e.id == checkinFormModel?.data?[0].userID).firstName;
                          bloc.commentsStream.add(checkinFormModel.data![0].checkOutProjectData?[0].remarks ?? '');
                        }

                        if (checkinFormModel.data![0].checkOutProjectData != null &&
                            checkinFormModel.data![0].checkOutProjectData!.isNotEmpty &&
                            checkinFormModel.data![0].checkOutProjectData?[0].projectname != '') {
                          // final employeeName = checkinFormModel.data![0].employeeList!.firstWhere((e) => e.id == checkinFormModel?.data?[0].userID).firstName;
                          final streams = [
                            bloc.projectStream1,
                            bloc.projectStream2,
                            bloc.projectStream3,
                            bloc.projectStream4,
                            bloc.projectStream5,
                            bloc.projectStream6,
                          ];
                          for (var i = 0; i < checkinFormModel.data![0].checkOutProjectData!.length; i++) {
                            final projName = checkinFormModel.data?[0].checkOutProjectData?[i].projectname;
                            streams[i].add(projName ?? '');

                            // print(' adasdadsadsadsadsadsadsads ${projName}');
                          }

                          print('12121212121212112 ${bloc.projectStream1.value}');
                        }

                        if (checkinFormModel.data![0].checkOutProjectData != null &&
                            checkinFormModel.data![0].checkOutProjectData!.isNotEmpty &&
                            checkinFormModel.data![0].checkOutProjectData?[0].checkinProjects != '') {
                          // final employeeName = checkinFormModel.data![0].employeeList!.firstWhere((e) => e.id == checkinFormModel?.data?[0].userID).firstName;
                          final streams = [
                            bloc.descriptionStream1,
                            bloc.descriptionStream2,
                            bloc.descriptionStream3,
                            bloc.descriptionStream4,
                            bloc.descriptionStream5,
                            bloc.descriptionStream6,
                          ];
                          for (var i = 0; i < checkinFormModel.data![0].checkOutProjectData!.length; i++) {
                            final description = checkinFormModel.data?[0].checkOutProjectData?[i].checkinProjects;
                            streams[i].add(description ?? '');

                            // print(' adasdadsadsadsadsadsadsads ${projName}');
                          }
                        }

                        // if (checkinFormModel.data![0].checkOutProjectData != null &&
                        //     checkinFormModel.data![0].checkOutProjectData!.isNotEmpty &&
                        //     checkinFormModel.data![0].checkOutProjectData?[0].reqHoursMin != '') {
                        //   // final employeeName = checkinFormModel.data![0].employeeList!.firstWhere((e) => e.id == checkinFormModel?.data?[0].userID).firstName;
                        //   final reqHourStreams = [
                        //     bloc.reqHourStream1,
                        //     bloc.reqHourStream2,
                        //     bloc.reqHourStream3,
                        //     bloc.reqHourStream4,
                        //     bloc.reqHourStream5,
                        //     bloc.reqHourStream6,
                        //   ];

                        //   final reqMinStreams = [
                        //     bloc.reqMinStream1,
                        //     bloc.reqMinStream2,
                        //     bloc.reqMinStream3,
                        //     bloc.reqMinStream4,
                        //     bloc.reqMinStream5,
                        //     bloc.reqMinStream6,
                        //   ];
                        //   for (var i = 0; i < checkinFormModel.data![0].checkOutProjectData!.length; i++) {
                        //     final reqHours = checkinFormModel.data?[0].checkOutProjectData?[i].reqHoursMin?.split(':');

                        //     final hour = reqHours?[0];
                        //     final min = reqHours?[1];

                        //     reqHourStreams[i].add(
                        //       hour != null
                        //           ? hour.startsWith('0')
                        //               ? hour.substring(1)
                        //               : hour
                        //           : '',
                        //     );
                        //     reqMinStreams[i].add(
                        //       min != null
                        //           ? min.startsWith('0')
                        //               ? min.substring(1)
                        //               : min
                        //           : '',
                        //     );

                        //     // print(' adasdadsadsadsadsadsadsads ${projName}');
                        //   }
                        // }
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: NewContactDropDown(
                                          checkinFormModel: checkinFormModel,
                                          textStream: bloc.employeeStream,

                                          heading: 'Employee',
                                          hint: 'Select Employee',
                                          // items:checkinFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                          items: (checkinFormModel != null &&
                                                  checkinFormModel.data != null &&
                                                  checkinFormModel.data!.isNotEmpty &&
                                                  checkinFormModel.data?[0].employeeList != null)
                                              ? ['', ...checkinFormModel.data![0].employeeList!.map((e) => e.firstName ?? '')]
                                              : [''],
                                          label: 'Employee',
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      Flexible(
                                        child: NewContactDropDown(
                                          checkinFormModel: checkinFormModel,
                                          textStream: bloc.workFromStream,
                                          heading: 'Work From',
                                          hint: 'Select Work From',
                                          // items:checkinFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                          items: const ['', 'Home', 'Office'],
                                          label: 'Work From',
                                        ),
                                      ),
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      Expanded(
                                        child: NewContactField(
                                          enabled: false,
                                          // isForDateField: true,
                                          heading: 'Check In Time',
                                          hintText: 'Select Check In Time',
                                          textStream: bloc.checkinTimeStream,
                                          // onChanged: bloc.checkinTimeStream.add,
                                          onTap: () async {
                                            // print('132131231231232113 ${DateFormat('yyyy-MM-dd').parse(bloc.leaveStartDateStream.value)}');

                                            final date = await _selectDate(context);

                                            if (date != null) {
                                              bloc.checkinTimeStream.add(date);
                                            }
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      Expanded(
                                        child: NewContactField(
                                          enabled: false,
                                          // isForDateField: true,
                                          heading: 'Check Out Time',
                                          hintText: 'Select Check Out Time',
                                          textStream: bloc.checkoutTimeStream,
                                          // onChanged: bloc.checkoutTimeStream.add,
                                          onTap: () async {
                                            // print('132131231231232113 ${DateFormat('yyyy-MM-dd').parse(bloc.leaveStartDateStream.value)}');

                                            final date = await _selectDate(context);

                                            if (date != null) {
                                              bloc.checkoutTimeStream.add(date);
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),

                                  // NewContactDropDown(
                                  //   checkinFormModel: checkinFormModel,
                                  //   textStream: bloc.workFromStream,
                                  //   heading: 'Work From',
                                  //   hint: 'Select Work From',
                                  //   // items:checkinFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                  //   items: const ['', 'Home', 'Office'],
                                  //   label: 'Work From',
                                  // ), //dropdown

                                  Row(
                                    children: [
                                      Expanded(
                                        child: NewContactField(
                                          enabled: false,
                                          textAlign: TextAlign.center,
                                          heading: 'Break',
                                          hintText: 'Break',
                                          textStream: bloc.breakHrsStream,
                                          // onChanged: bloc.breakHrsStream.add,
                                          onTap: () async {
                                            final time = await showTimePicker(
                                              builder: (BuildContext context, Widget? child) {
                                                return MediaQuery(
                                                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                                                  child: child!,
                                                );
                                              },
                                              // onEntryModeChanged: (mode) => ,
                                              context: context,
                                              initialTime: const TimeOfDay(hour: 1, minute: 0),
                                            );
                                            // final time = TimeOfDay(hour: 1, minute: 0);
                                            if (time != null) {
                                              final formattedTime = time.formatToString();
                                              bloc.breakHrsStream.add(formattedTime);
                                            }
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      Expanded(
                                        flex: 5,
                                        child: NewContactField(
                                          autoEnlarge: true,
                                          heading: 'Break Remark',
                                          hintText: 'Break Remark',
                                          textStream: bloc.breakRemarkStream,
                                          onChanged: bloc.breakRemarkStream.add,
                                        ),
                                      ),
                                    ],
                                  ),

                                  NewContactField(
                                    autoEnlarge: true,
                                    heading: 'Comments',
                                    hintText: 'Comments',
                                    textStream: bloc.commentsStream,
                                    onChanged: bloc.commentsStream.add,
                                  ),

                                  // Text('Project #1', style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800])),

                                  // NewContactDropDown(
                                  //   checkinFormModel: checkinFormModel,
                                  //   textStream: bloc.projectStream,
                                  //   heading: 'Project',
                                  //   hint: 'Select Project',
                                  //   // items:checkinFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                  //   items: (checkinFormModel != null && checkinFormModel.data != null && checkinFormModel.data!.isNotEmpty && checkinFormModel.data?[0].projectList != null)
                                  //       ? ['', ...checkinFormModel.data![0].projectList!.map((e) => e.name ?? '')]
                                  //       : [''],
                                  //   label: 'Project',
                                  // ), //dropdown

                                  // NewContactField(
                                  //   // enabled: false,
                                  //   // isForDateField: true,
                                  //   autoEnlarge: true,
                                  //   heading: 'Description',
                                  //   hintText: 'Description',
                                  //   textStream: bloc.descriptionStream,
                                  //   onChanged: bloc.descriptionStream.add,
                                  // ),

                                  // Row(
                                  //   children: [
                                  //     Flexible(
                                  //       child: NewContactDropDown(
                                  //         checkinFormModel: checkinFormModel,
                                  //         textStream: bloc.reqHourStream,

                                  //         heading: 'Hour',
                                  //         hint: 'Select Hour',
                                  //         // items:checkinFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                  //         items: ['', ...List.generate(8, (index) => '${index + 1}')],
                                  //         label: 'Hour',
                                  //       ),
                                  //     ),
                                  //     SizedBox(width: 5.w),
                                  //     Flexible(
                                  //       child: NewContactDropDown(
                                  //         checkinFormModel: checkinFormModel,
                                  //         textStream: bloc.reqMinStream,
                                  //         heading: 'Minutes',
                                  //         hint: 'Select Minutes',
                                  //         // items:checkinFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                  //         items: ['', ...List.generate(60, (index) => '$index')],
                                  //         label: 'Minutes',
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),

                                  SizedBox(
                                    height: 240.h,
                                    child: PageView(
                                      controller: _controller,
                                      children: [
                                        // Project 1
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Project #1', style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800])),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: NewContactDropDown(
                                                    checkinFormModel: checkinFormModel,
                                                    textStream: bloc.projectStream1,
                                                    heading: 'Project',
                                                    hint: 'Select Project',
                                                    // items:checkinFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                                    items: (checkinFormModel != null &&
                                                            checkinFormModel.data != null &&
                                                            checkinFormModel.data!.isNotEmpty &&
                                                            checkinFormModel.data?[0].projectList != null)
                                                        ? ['', ...checkinFormModel.data![0].projectList!.map((e) => e.name ?? '')]
                                                        : [''],
                                                    label: 'Project',
                                                  ),
                                                ),
                                                const Icon(Icons.add).ripple(context, () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const NewProject(isFromCheckInPage1: true)));
                                                }),
                                              ],
                                            ),
                                            NewContactField(
                                              // enabled: false,    required String dateTimeIdForCheckOut,
                                              // isForDateField: true,
                                              autoEnlarge: true,
                                              heading: 'Description',
                                              hintText: 'Description',
                                              textStream: bloc.descriptionStream1,
                                              onChanged: bloc.descriptionStream1.add,
                                            ),
                                            Row(
                                              children: [
                                                Flexible(
                                                  child: NewContactDropDown(
                                                    checkinFormModel: checkinFormModel,
                                                    textStream: bloc.reqHourStream1,

                                                    heading: 'Hour',
                                                    hint: 'Select Hour',
                                                    // items:checkinFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                                    items: ['', ...List.generate(8, (index) => '${index + 1}')],
                                                    label: 'Hour',
                                                  ),
                                                ),
                                                SizedBox(width: 5.w),
                                                Flexible(
                                                  child: NewContactDropDown(
                                                    checkinFormModel: checkinFormModel,
                                                    textStream: bloc.reqMinStream1,
                                                    heading: 'Minutes',
                                                    hint: 'Select Minutes',
                                                    // items:checkinFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                                    items: ['', ...List.generate(60, (index) => '$index')],
                                                    label: 'Minutes',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        // Project 2
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Project #2', style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800])),

                                            Row(
                                              children: [
                                                Expanded(
                                                  child: NewContactDropDown(
                                                    checkinFormModel: checkinFormModel,
                                                    textStream: bloc.projectStream2,
                                                    heading: 'Project',
                                                    hint: 'Select Project',
                                                    // items:checkinFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                                    items: (checkinFormModel != null &&
                                                            checkinFormModel.data != null &&
                                                            checkinFormModel.data!.isNotEmpty &&
                                                            checkinFormModel.data?[0].projectList != null)
                                                        ? ['', ...checkinFormModel.data![0].projectList!.map((e) => e.name ?? '')]
                                                        : [''],
                                                    label: 'Project',
                                                  ),
                                                ),
                                                const Icon(Icons.add).ripple(context, () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const NewProject(isFromCheckInPage2: true)));
                                                }),
                                              ],
                                            ), //dropdown

                                            NewContactField(
                                              // enabled: false,
                                              // isForDateField: true,
                                              autoEnlarge: true,
                                              heading: 'Description',
                                              hintText: 'Description',
                                              textStream: bloc.descriptionStream2,
                                              onChanged: bloc.descriptionStream2.add,
                                            ),

                                            Row(
                                              children: [
                                                Flexible(
                                                  child: NewContactDropDown(
                                                    checkinFormModel: checkinFormModel,
                                                    textStream: bloc.reqHourStream2,

                                                    heading: 'Hour',
                                                    hint: 'Select Hour',
                                                    // items:checkinFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                                    items: ['', ...List.generate(8, (index) => '${index + 1}')],
                                                    label: 'Hour',
                                                  ),
                                                ),
                                                SizedBox(width: 5.w),
                                                Flexible(
                                                  child: NewContactDropDown(
                                                    checkinFormModel: checkinFormModel,
                                                    textStream: bloc.reqMinStream2,
                                                    heading: 'Minutes',
                                                    hint: 'Select Minutes',
                                                    // items:checkinFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                                    items: ['', ...List.generate(60, (index) => '$index')],
                                                    label: 'Minutes',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        // Project 3
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Project #3', style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800])),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: NewContactDropDown(
                                                    checkinFormModel: checkinFormModel,
                                                    textStream: bloc.projectStream3,
                                                    heading: 'Project',
                                                    hint: 'Select Project',
                                                    // items:checkinFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                                    items: (checkinFormModel != null &&
                                                            checkinFormModel.data != null &&
                                                            checkinFormModel.data!.isNotEmpty &&
                                                            checkinFormModel.data?[0].projectList != null)
                                                        ? ['', ...checkinFormModel.data![0].projectList!.map((e) => e.name ?? '')]
                                                        : [''],
                                                    label: 'Project',
                                                  ),
                                                ),
                                                const Icon(Icons.add).ripple(context, () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const NewProject(isFromCheckInPage3: true)));
                                                }),
                                              ],
                                            ),
                                            NewContactField(
                                              // enabled: false,
                                              // isForDateField: true,
                                              autoEnlarge: true,
                                              heading: 'Description',
                                              hintText: 'Description',
                                              textStream: bloc.descriptionStream3,
                                              onChanged: bloc.descriptionStream3.add,
                                            ),
                                            Row(
                                              children: [
                                                Flexible(
                                                  child: NewContactDropDown(
                                                    checkinFormModel: checkinFormModel,
                                                    textStream: bloc.reqHourStream3,

                                                    heading: 'Hour',
                                                    hint: 'Select Hour',
                                                    // items:checkinFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                                    items: ['', ...List.generate(8, (index) => '${index + 1}')],
                                                    label: 'Hour',
                                                  ),
                                                ),
                                                SizedBox(width: 5.w),
                                                Flexible(
                                                  child: NewContactDropDown(
                                                    checkinFormModel: checkinFormModel,
                                                    textStream: bloc.reqMinStream3,
                                                    heading: 'Minutes',
                                                    hint: 'Select Minutes',
                                                    // items:checkinFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                                    items: ['', ...List.generate(60, (index) => '$index')],
                                                    label: 'Minutes',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        // Project 4
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Project #4', style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800])),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: NewContactDropDown(
                                                    checkinFormModel: checkinFormModel,
                                                    textStream: bloc.projectStream4,
                                                    heading: 'Project',
                                                    hint: 'Select Project',
                                                    // items:checkinFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                                    items: (checkinFormModel != null &&
                                                            checkinFormModel.data != null &&
                                                            checkinFormModel.data!.isNotEmpty &&
                                                            checkinFormModel.data?[0].projectList != null)
                                                        ? ['', ...checkinFormModel.data![0].projectList!.map((e) => e.name ?? '')]
                                                        : [''],
                                                    label: 'Project',
                                                  ),
                                                ),
                                                const Icon(Icons.add).ripple(context, () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const NewProject(isFromCheckInPage4: true)));
                                                }),
                                              ],
                                            ),
                                            NewContactField(
                                              // enabled: false,
                                              // isForDateField: true,
                                              autoEnlarge: true,
                                              heading: 'Description',
                                              hintText: 'Description',
                                              textStream: bloc.descriptionStream4,
                                              onChanged: bloc.descriptionStream4.add,
                                            ),
                                            Row(
                                              children: [
                                                Flexible(
                                                  child: NewContactDropDown(
                                                    checkinFormModel: checkinFormModel,
                                                    textStream: bloc.reqHourStream4,

                                                    heading: 'Hour',
                                                    hint: 'Select Hour',
                                                    // items:checkinFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                                    items: ['', ...List.generate(8, (index) => '${index + 1}')],
                                                    label: 'Hour',
                                                  ),
                                                ),
                                                SizedBox(width: 5.w),
                                                Flexible(
                                                  child: NewContactDropDown(
                                                    checkinFormModel: checkinFormModel,
                                                    textStream: bloc.reqMinStream4,
                                                    heading: 'Minutes',
                                                    hint: 'Select Minutes',
                                                    // items:checkinFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                                    items: ['', ...List.generate(60, (index) => '$index')],
                                                    label: 'Minutes',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        // Project 5
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Project #5', style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800])),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: NewContactDropDown(
                                                    checkinFormModel: checkinFormModel,
                                                    textStream: bloc.projectStream5,
                                                    heading: 'Project',
                                                    hint: 'Select Project',
                                                    // items:checkinFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                                    items: (checkinFormModel != null &&
                                                            checkinFormModel.data != null &&
                                                            checkinFormModel.data!.isNotEmpty &&
                                                            checkinFormModel.data?[0].projectList != null)
                                                        ? ['', ...checkinFormModel.data![0].projectList!.map((e) => e.name ?? '')]
                                                        : [''],
                                                    label: 'Project',
                                                  ),
                                                ),
                                                const Icon(Icons.add).ripple(context, () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const NewProject(isFromCheckInPage5: true)));
                                                }),
                                              ],
                                            ),
                                            NewContactField(
                                              // enabled: false,
                                              // isForDateField: true,
                                              autoEnlarge: true,
                                              heading: 'Description',
                                              hintText: 'Description',
                                              textStream: bloc.descriptionStream5,
                                              onChanged: bloc.descriptionStream5.add,
                                            ),
                                            Row(
                                              children: [
                                                Flexible(
                                                  child: NewContactDropDown(
                                                    checkinFormModel: checkinFormModel,
                                                    textStream: bloc.reqHourStream5,

                                                    heading: 'Hour',
                                                    hint: 'Select Hour',
                                                    // items:checkinFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                                    items: ['', ...List.generate(8, (index) => '${index + 1}')],
                                                    label: 'Hour',
                                                  ),
                                                ),
                                                SizedBox(width: 5.w),
                                                Flexible(
                                                  child: NewContactDropDown(
                                                    checkinFormModel: checkinFormModel,
                                                    textStream: bloc.reqMinStream5,
                                                    heading: 'Minutes',
                                                    hint: 'Select Minutes',
                                                    // items:checkinFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                                    items: ['', ...List.generate(60, (index) => '$index')],
                                                    label: 'Minutes',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        // Project 6
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Project #6', style: AppStyles.poppins.copyWith(fontSize: 11.w, color: Colors.grey[800])),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: NewContactDropDown(
                                                    checkinFormModel: checkinFormModel,
                                                    textStream: bloc.projectStream6,
                                                    heading: 'Project',
                                                    hint: 'Select Project',
                                                    // items:checkinFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                                    items: (checkinFormModel != null &&
                                                            checkinFormModel.data != null &&
                                                            checkinFormModel.data!.isNotEmpty &&
                                                            checkinFormModel.data?[0].projectList != null)
                                                        ? ['', ...checkinFormModel.data![0].projectList!.map((e) => e.name ?? '')]
                                                        : [''],
                                                    label: 'Project',
                                                  ),
                                                ),
                                                const Icon(Icons.add).ripple(context, () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const NewProject(isFromCheckInPage6: true)));
                                                }),
                                              ],
                                            ),
                                            NewContactField(
                                              // enabled: false,
                                              // isForDateField: true,
                                              autoEnlarge: true,
                                              heading: 'Description',
                                              hintText: 'Description',
                                              textStream: bloc.descriptionStream6,
                                              onChanged: bloc.descriptionStream6.add,
                                            ),
                                            Row(
                                              children: [
                                                Flexible(
                                                  child: NewContactDropDown(
                                                    checkinFormModel: checkinFormModel,
                                                    textStream: bloc.reqHourStream6,

                                                    heading: 'Hour',
                                                    hint: 'Select Hour',
                                                    // items:checkinFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                                    items: ['', ...List.generate(8, (index) => '${index + 1}')],
                                                    label: 'Hour',
                                                  ),
                                                ),
                                                SizedBox(width: 5.w),
                                                Flexible(
                                                  child: NewContactDropDown(
                                                    checkinFormModel: checkinFormModel,
                                                    textStream: bloc.reqMinStream6,
                                                    heading: 'Minutes',
                                                    hint: 'Select Minutes',
                                                    // items:checkinFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                                    items: ['', ...List.generate(60, (index) => '$index')],
                                                    label: 'Minutes',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    height: 30,
                                    width: double.infinity,
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 5.h),
                                        child: SmoothPageIndicator(
                                          controller: _controller,
                                          count: 6,
                                          effect: const ExpandingDotsEffect(
                                            dotHeight: 8,
                                            dotWidth: 8,
                                            spacing: 16,
                                            dotColor: Colors.grey,
                                            activeDotColor: Colors.purple,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Container(
                                //   padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                                //   decoration: BoxDecoration(
                                //     color: Colors.orange,
                                //     borderRadius: BorderRadius.circular(15.r),
                                //   ),
                                //   child: Text('Reset', style: AppStyles.poppins.copyWith(fontSize: 14.w, color: Colors.white)),
                                // ),
                                // SizedBox(width: 10.w),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                                  decoration: BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  child: Text('Submit', style: AppStyles.poppins.copyWith(fontSize: 14.w, color: Colors.white)),
                                ).ripple(context, () async {
                                  customLoader(context);
                                  final employeeId = checkinFormModel?.data?[0].employeeList?.firstWhere((e) => e.firstName == bloc.employeeStream.value).id ?? '0';
                                  var projectId1 = '';
                                  var projectId2 = '';
                                  var projectId3 = '';
                                  var projectId4 = '';
                                  var projectId5 = '';
                                  var projectId6 = '';
                                  if (bloc.projectStream1.value == '' &&
                                      bloc.projectStream2.value == '' &&
                                      bloc.projectStream3.value == '' &&
                                      bloc.projectStream4.value == '' &&
                                      bloc.projectStream5.value == '' &&
                                      bloc.projectStream6.value == '') {
                                    await erroMotionToastInfo(context, msg: 'Atleast select one project');
                                    Loader.hide();
                                    return;
                                  }
                                  if (bloc.projectStream1.value != '') {
                                    projectId1 = checkinFormModel?.data?[0].projectList?.firstWhere((e) => e.name == bloc.projectStream1.value).id ?? '';
                                  }
                                  // else {
                                  //   await erroMotionToastInfo(context, msg: 'Atleast select one project');
                                  //   Loader.hide();
                                  //   return;
                                  // }
                                  if (bloc.projectStream2.value != '') {
                                    projectId2 = checkinFormModel?.data?[0].projectList?.firstWhere((e) => e.name == bloc.projectStream2.value).id ?? '';
                                  }
                                  if (bloc.projectStream3.value != '') {
                                    projectId3 = checkinFormModel?.data?[0].projectList?.firstWhere((e) => e.name == bloc.projectStream3.value).id ?? '';
                                  }
                                  if (bloc.projectStream4.value != '') {
                                    projectId4 = checkinFormModel?.data?[0].projectList?.firstWhere((e) => e.name == bloc.projectStream4.value).id ?? '';
                                  }
                                  if (bloc.projectStream5.value != '') {
                                    projectId5 = checkinFormModel?.data?[0].projectList?.firstWhere((e) => e.name == bloc.projectStream5.value).id ?? '';
                                  }
                                  if (bloc.projectStream6.value != '') {
                                    projectId6 = checkinFormModel?.data?[0].projectList?.firstWhere((e) => e.name == bloc.projectStream6.value).id ?? '';
                                  }
                                  final workFromId = bloc.workFromStream.value == 'Home' ? '1' : '2';

                                  final Map<String, String?> subIds = {
                                    '1': null,
                                    '2': null,
                                    '3': null,
                                    '4': null,
                                    '5': null,
                                    '6': null,
                                  };

                                  final Map<String, String?> mainIds = {
                                    '1': null,
                                    '2': null,
                                    '3': null,
                                    '4': null,
                                    '5': null,
                                    '6': null,
                                  };

                                  if (checkinFormModel?.data![0].checkOutProjectData != null &&
                                      checkinFormModel!.data![0].checkOutProjectData!.isNotEmpty &&
                                      checkinFormModel.data![0].checkOutProjectData?[0].reqHoursMin != '') {
                                    for (var i = 0; i < checkinFormModel.data![0].checkOutProjectData!.length; i++) {
                                      final checkInSubId = checkinFormModel.data?[0].checkOutProjectData?[i].checkInSubId;
                                      final checkInMainId = checkinFormModel.data?[0].checkOutProjectData?[i].checkInMainId;

                                      subIds['${i + 1}'] = checkInSubId ?? '';
                                      mainIds['${i + 1}'] = checkInMainId ?? '';
                                    }
                                  }

                                  final checkInId = checkinFormModel?.data?[0].checkInId;
                                  // final checkInMainId = checkinFormModel?.data?[0].checkOutProjectData?[0].checkInMainId;

                                  // print('22222222222222222222222222222 ${mainIds['1']}');
                                  // print('33333333333333333333333333333 ${subIds['1']}');
                                  // print('22222222222222222222222222222 ${mainIds['2']}');
                                  // print('33333333333333333333333333333 ${subIds['2']}');
                                  // print('22222222222222222222222222222 ${mainIds['3']}');
                                  // print('33333333333333333333333333333 ${subIds['3']}');

                                  final resp = await bloc.formSubmitCheckOut(
                                    dateTimeIdForCheckOut: widget.checkoutDateTimeStr,
                                    employeeId: employeeId,
                                    workFromId: workFromId,
                                    checkInId: checkInId ?? '',
                                    projectId1: projectId1,
                                    refMain1: mainIds['1'] ?? '',
                                    refSub1: subIds['1'] ?? '',
                                    projectId2: projectId2 == '' ? null : projectId2,
                                    refMain2: mainIds['2'],
                                    refSub2: subIds['2'],
                                    projectId3: projectId2 == '' ? null : projectId3,
                                    refMain3: mainIds['3'],
                                    refSub3: subIds['3'],
                                    projectId4: projectId2 == '' ? null : projectId4,
                                    refMain4: mainIds['4'],
                                    refSub4: subIds['4'],
                                    projectId5: projectId2 == '' ? null : projectId5,
                                    refMain5: mainIds['5'],
                                    refSub5: subIds['5'],
                                    projectId6: projectId2 == '' ? null : projectId6,
                                    refMain6: mainIds['6'],
                                    refSub6: subIds['6'],
                                  );

                                  if (resp != null && resp['status'] == 'SUCCESS' && resp['response'] == 'OK') {
                                    Navigator.pop(context);
                                    await successMotionToastInfo(context, msg: 'Check Out Successfully Done');
                                    await context.read<CheckInBloc>().getAllCheckins();
                                    Loader.hide();
                                  } else {
                                    // print('111111111111111111111111 $resp');
                                    await erroMotionToastInfo(context, msg: 'Submission Failed !!');
                                    Loader.hide();
                                  }
                                }),
                              ],
                            ),

                            SizedBox(height: 160.h),
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
    );
  }
}

Future<String?> _selectDate(BuildContext context) async {
  var date = DateTime.now();
  final now = DateTime.now();

  final picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(3000),
  );

  if (picked != null) {
    final pickedTime = await showTimePicker(
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
      context: context,
      initialTime: TimeOfDay.fromDateTime(picked),
    );

    if (pickedTime != null) {
      date = DateTime(
        picked.year,
        picked.month,
        picked.day,
        pickedTime.hour,
        pickedTime.minute,
        // pickedTime.,
      );
    }

    // print('77777777777777777777777777777 ${DateFormat('dd/MM/yyyy').format(date)}');
    final dateStr = DateFormat('yyyy-MM-dd HH:mm:ss').format(date);

    // if (dateStr == '') {
    //   await erroMotionToastInfo(context, msg: 'Something wrong !!');
    //   return null;
    // }

    return dateStr;
  }

  // await erroMotionToastInfo(context, msg: 'Something wrong !!');
  return null;
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
    this.checkinFormModel,
  });

  final BehaviorSubject<String> textStream;
  final String heading;
  final String hint;
  final String label;
  // final String initialValue;
  final List<String> items;
  final GetCheckOutFormModel? checkinFormModel;

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
    this.textAlign = TextAlign.start,
    this.enabled = true,
    this.validator,
    this.keyboardType,
    this.onTap,
    this.onChanged,
    // this.initialValue = '',
    this.textInputType = TextInputType.name,
    this.isLargeField = false,
    this.isForDateField = false,
    this.autoEnlarge = false,
    super.key,
  });

  final bool isForDateField;
  final bool autoEnlarge;
  final TextAlign textAlign;
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
        _controller.text = widget.isForDateField ? UtilityFunctions.convertIntoNormalDateTimeStringFromDateTimeString(value) : value;
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
          return InkWell(
            onTap: widget.onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(heading, style: AppStyles.poppins.copyWith(fontSize: 12.w, color: Colors.purple)),
                // SizedBox(height: 7.h),
                SizedBox(
                  height: widget.autoEnlarge ? null : 50.h,
                  child: TextFormField(
                    // initialValue: widget.initialValue,
                    scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom + 15.w * 6, // Adjust the value as needed
                    ),
                    // controller: controller,
                    textAlign: widget.textAlign,
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
                    minLines: widget.autoEnlarge ? 1 : null,
                    maxLines: widget.autoEnlarge ? 30 : null,
                    // maxLength: widget.autoEnlarge ? 500 : null,
                    controller: _controller,
                    validator: widget.validator,
                    onChanged: widget.onChanged,
                    // onTap: widget.onTap,
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
                      contentPadding: EdgeInsets.only(left: widget.textAlign == TextAlign.start ? 15.w : 0.w, top: widget.autoEnlarge ? 30.h : 0),
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
