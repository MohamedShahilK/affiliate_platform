// ignore_for_file: lines_longer_than_80_chars, use_build_context_synchronously

import 'package:affiliate_platform/config/ripple.dart';
import 'package:affiliate_platform/logic/employee/leave/leave_bloc.dart';
import 'package:affiliate_platform/models/employee/leave/leave_form_model.dart';
import 'package:affiliate_platform/models/employee/leave/leave_model.dart';
import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/utils/custom_tools.dart';
import 'package:affiliate_platform/utils/utility_functions.dart';
import 'package:affiliate_platform/view/common/custom_header.dart';
import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NewLeave extends StatefulWidget {
  const NewLeave({
    this.leaveModel,
    super.key,
  });

  final LeavesList? leaveModel;

  @override
  State<NewLeave> createState() => _NewLeaveState();
}

class _NewLeaveState extends State<NewLeave> {
  LeaveBloc? leaveBloc;

  // bool loading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    leaveBloc ??= Provider.of<LeaveBloc>(context);
    leaveBloc!.clearStreams();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<LeaveBloc>(context);

    return CustomScaffold(
      haveFloatingButton: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomHeader(isBackButtonNeeded: true, heading: 'Add New Leave'),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
                  child: StreamBuilder(
                    stream: bloc.getLeaveFormStream,
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
                                    Text('Refresg', style: TextStyle(fontSize: 15.w)),
                                  ],
                                ),
                              ).ripple(
                                context,
                                () async {
                                  await bloc.getLeaveForm();
                                },
                                borderRadius: BorderRadius.circular(15.r),
                                overlayColor: Colors.purple.withOpacity(.15),
                              ),
                            ],
                          ),
                        );
                      }

                      GetLeaveForm? leaveFormModel;

                      if (snapshot.hasData) {
                        leaveFormModel = snapshot.data;
                        // if (leaveFormModel!.data![0].contactType != null) {
                        //   // print('22222222222222222222222222222222222 ${leaveFormModel.data![0].contactType!.values.toList(growable: false)}');
                        // }
                      }

                      if (widget.leaveModel != null) {
                        if (widget.leaveModel?.firstName != null && widget.leaveModel?.firstName != '') {
                          bloc.employeeNameStream.add(widget.leaveModel?.firstName ?? '');
                        }

                        if (widget.leaveModel?.leaveDate != null && (widget.leaveModel?.leaveDate != '')) {
                          bloc.leaveApplyDateStream.add(widget.leaveModel?.leaveDate ?? '');
                        } else {
                          bloc.leaveApplyDateStream.add('');
                        }

                        if (widget.leaveModel?.leaveStartDate != null && (widget.leaveModel?.leaveStartDate != '')) {
                          bloc.leaveStartDateStream.add(widget.leaveModel?.leaveStartDate ?? '');
                        } else {
                          bloc.leaveStartDateStream.add('');
                        }
                        if (widget.leaveModel?.leaveEndDate != null && (widget.leaveModel?.leaveEndDate != '')) {
                          bloc.leaveEndDateStream.add(widget.leaveModel?.leaveEndDate ?? '');
                        } else {
                          bloc.leaveEndDateStream.add('');
                        }

                        if (widget.leaveModel?.leaveDuration != null && (widget.leaveModel?.leaveDuration != '')) {
                          bloc.leaveDurationStream.add(getLeaveDuration(durationId: widget.leaveModel?.leaveDuration ?? ''));
                        }

                        if (widget.leaveModel?.leavesIntervals != null && (widget.leaveModel?.leavesIntervals != '')) {
                          bloc.noOfHoursStream.add(widget.leaveModel?.leavesIntervals ?? '');
                        } else {
                          bloc.noOfHoursStream.add('');
                        }

                        if (widget.leaveModel?.leavesHouroffText != null && (widget.leaveModel?.leavesHouroffText != '')) {
                          bloc.hourOffStartAndEndDateStream.add(widget.leaveModel?.leavesHouroffText ?? '');
                        } else {
                          bloc.hourOffStartAndEndDateStream.add('');
                        }

                        if (widget.leaveModel?.leavesTypeName != null && (widget.leaveModel?.leavesTypeName != '')) {
                          bloc.leaveTypeStream.add(widget.leaveModel?.leavesTypeName ?? '');
                        }

                        if (widget.leaveModel?.leaveReason != null && (widget.leaveModel?.leaveReason != '')) {
                          bloc.leaveReasonStream.add(widget.leaveModel?.leaveReason ?? '');
                        } else {
                          bloc.leaveReasonStream.add('');
                        }
                      } else {
                        // bloc.projectNameStream.add('');
                      }

                      return Skeletonizer(
                        enabled: snapshot.connectionState == ConnectionState.waiting,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Heading

                            // Form Fields

                            Padding(
                              padding: EdgeInsets.only(top: 7.h),
                              child: Column(
                                children: [
                                  // NewContactField(
                                  //   heading: 'Project Name',
                                  //   hintText: 'Project',
                                  //   textStream: bloc.projectNameStream,
                                  //   onChanged: bloc.projectNameStream.add,
                                  // ),
                                  NewContactDropDown(
                                    leaveFormModel: leaveFormModel,
                                    textStream: bloc.employeeNameStream,
                                    heading: 'Employee',
                                    hint: 'Select Employee',
                                    // items:leaveFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                    items: (leaveFormModel != null && leaveFormModel.data != null && leaveFormModel.data!.isNotEmpty && leaveFormModel.data?[0].employeeList != null)
                                        ? ['', ...leaveFormModel.data![0].employeeList!.map((e) => e.firstName ?? '')]
                                        : [''],
                                    label: 'Employee',
                                  ), //dropdown
                                  NewContactField(
                                    enabled: false,
                                    isForDateField: true,
                                    isNewLeave: widget.leaveModel != null,
                                    heading: 'Apply Date',
                                    hintText: 'Select Apply Date',
                                    textStream: bloc.leaveApplyDateStream,
                                    // onChanged: bloc.leaveApplyDateStream.add,
                                    onTap: () async {
                                      final date = await _selectDate(context);
                                      bloc.leaveApplyDateStream.add(date ?? '');
                                    },
                                  ),
                                  NewContactField(
                                    enabled: false,
                                    isForDateField: true,
                                    isNewLeave: widget.leaveModel != null,
                                    heading: 'Start Date',
                                    hintText: 'Select Start Date',
                                    textStream: bloc.leaveStartDateStream,
                                    // onChanged: bloc.leaveStartDateStream.add,
                                    onTap: () async {
                                      final date = await _selectDate(context);
                                      bloc.leaveStartDateStream.add(date ?? '');
                                    },
                                  ),
                                  NewContactField(
                                    enabled: false,
                                    isForDateField: true,
                                    isNewLeave: widget.leaveModel != null,
                                    heading: 'End Date',
                                    hintText: 'Select End Date',
                                    textStream: bloc.leaveEndDateStream,
                                    // onChanged: bloc.leaveEndDateStream.add,
                                    onTap: () async {
                                      if (bloc.leaveStartDateStream.value == '') {
                                        await erroMotionToastInfo(context, msg: 'Starting Date Is Not Selected');
                                      } else {
                                        // print('132131231231232113 ${DateFormat('yyyy-MM-dd').parse(bloc.leaveStartDateStream.value)}');

                                        final date = await _selectDate(context);

                                        if (date != null) {
                                          bloc.leaveDurationStream.add('Full day');

                                          bloc.leaveEndDateStream.add(date);
                                        }
                                      }
                                    },
                                  ),
                                  NewContactDropDown(
                                    leaveFormModel: leaveFormModel,
                                    textStream: bloc.leaveDurationStream,
                                    heading: 'Leave Duration',
                                    hint: 'Select Duration',
                                    // items:leaveFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                    items: (leaveFormModel != null && leaveFormModel.data != null && leaveFormModel.data!.isNotEmpty && leaveFormModel.data?[0].leavesDuration != null)
                                        ? [
                                            '',
                                            leaveFormModel.data![0].leavesDuration?.hourOff ?? 'Hour Off',
                                            leaveFormModel.data![0].leavesDuration?.hdM ?? 'Half day - Morning',
                                            leaveFormModel.data![0].leavesDuration?.hdE ?? 'Half day - Afternoon',
                                            leaveFormModel.data![0].leavesDuration?.fD ?? 'Full day',
                                          ]
                                        : [''],
                                    label: 'Leave Duration',
                                    // initialValue: leaveFormModel == null ? '' : leaveFormModel.data![0].contactType!.entries.map((e) => e as String).toList().first,
                                    // initialValue: widget.model?.type ?? '',
                                  ), //dropdown
                                  // if (bloc.leaveDurationStream.value != '')
                                  StreamBuilder(
                                    stream: bloc.leaveDurationStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.data == 'Full day') {
                                        if (widget.leaveModel == null) {
                                          final inputS = DateFormat('dd-MM-yyyy').parse(bloc.leaveStartDateStream.value);
                                          final outputFormatS = DateFormat('yyyy-MM-dd');
                                          final outputDateStringS = outputFormatS.format(inputS);


                                          final start = DateTime.parse(outputDateStringS);

                                          final inputE = DateFormat('dd-MM-yyyy').parse(bloc.leaveEndDateStream.value);
                                          final outputFormatE = DateFormat('yyyy-MM-dd');
                                          final outputDateStringE = outputFormatE.format(inputE);


                                          final end = DateTime.parse(outputDateStringE);

                                          // final end = DateTime.parse(date ?? '20-01-2023');

                                          // print('132131231231232113 $end');

                                          final normalizedDate1 = DateTime(start.year, start.month, start.day);
                                          final normalizedDate2 = DateTime(end.year, end.month, end.day);

                                          final differenceInDays = normalizedDate2.difference(normalizedDate1).inDays + 1;

                                          if (differenceInDays < 1 || differenceInDays.isNegative) {
                                            bloc.noOfHoursStream.add('0');
                                          } else {
                                            bloc.noOfHoursStream.add(differenceInDays.toString());
                                          }
                                        } else {
                                         
                                        }

                                        // bloc.noOfHoursStream.add('1');
                                      } else if (snapshot.data == 'Half day - Morning' || snapshot.data == 'Half day - Afternoon') {
                                        bloc.noOfHoursStream.add('4');
                                      } else if (snapshot.data == 'Hour Off') {
                                        bloc.noOfHoursStream.add('');
                                      }
                                      //  else {

                                      // }
                                      return snapshot.data == ''
                                          ? const SizedBox.shrink()
                                          : NewContactField(
                                              enabled: !['Full day', 'Half day - Morning', 'Half day - Afternoon'].contains(snapshot.data),
                                              heading: snapshot.data == 'Full day' ? 'No. of Days' : 'No. of Hours',
                                              hintText: '',
                                              textInputType: TextInputType.number,
                                              textStream: bloc.noOfHoursStream,
                                              onChanged: bloc.noOfHoursStream.add,
                                            );
                                    },
                                  ),
                                  // if (bloc.leaveDurationStream.value != '' && bloc.leaveDurationStream.value == 'Hour Off')
                                  StreamBuilder(
                                    stream: bloc.leaveDurationStream,
                                    builder: (context, snapshot) {
                                      return snapshot.data != '' && snapshot.data == 'Hour Off'
                                          ? NewContactField(
                                              heading: 'Hour off Start and End Time',
                                              hintText: 'Hour off Start and End Time',
                                              textInputType: TextInputType.text,
                                              textStream: bloc.hourOffStartAndEndDateStream,
                                              onChanged: bloc.hourOffStartAndEndDateStream.add,
                                            )
                                          : const SizedBox.shrink();
                                    },
                                  ),
                                  NewContactDropDown(
                                    leaveFormModel: leaveFormModel,
                                    textStream: bloc.leaveTypeStream,
                                    heading: 'Type of leave',
                                    hint: 'Select Type of leave',
                                    // items:leaveFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                    items: (leaveFormModel != null && leaveFormModel.data != null && leaveFormModel.data!.isNotEmpty && leaveFormModel.data?[0].leavesType != null)
                                        ? ['', ...leaveFormModel.data![0].leavesType!.map((e) => e.name ?? '')]
                                        : [''],
                                    label: 'Type of leave',
                                  ), //dropd
                                  NewContactLargeField(
                                    heading: 'Reason for leave',
                                    hintText: 'Reason for leave',
                                    textStream: bloc.leaveReasonStream,
                                    onChanged: bloc.leaveReasonStream.add,
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 20.h),

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
                                  if (widget.leaveModel == null) {
                                    final employeeId = leaveFormModel?.data?[0].employeeList?.firstWhere((e) => e.firstName == bloc.employeeNameStream.value).id ?? '0';
                                    final durationId = getDurationI(status: bloc.leaveDurationStream.value);
                                    final leaveTypeId = leaveFormModel?.data?[0].leavesType?.firstWhere((e) => e.name == bloc.leaveTypeStream.value).id ?? '0';

                                    final resp = await bloc.submitLeaveForm(employeeId: employeeId, durationId: durationId, leaveTypeId: leaveTypeId);

                                    if (resp != null && resp['status'] == 'SUCCESS' && resp['response'] == 'OK') {
                                      Navigator.pop(context);
                                      await successMotionToastInfo(context, msg: resp['message'] as String);
                                      await bloc.getAllLeaves();
                                      Loader.hide();
                                    } else {
                                      await erroMotionToastInfo(context, msg: 'Submission Failed !!');
                                      Loader.hide();
                                    }
                                    // }
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
      date = DateTime(
        picked.year,
        picked.month,
        picked.day,
      );

      // print('77777777777777777777777777777 ${DateFormat('dd/MM/yyyy').format(date)}');
      final dateStr = DateFormat('dd-MM-yyyy').format(date);

      // if (dateStr == '') {
      //   await erroMotionToastInfo(context, msg: 'Something wrong !!');
      //   return null;
      // }

      return dateStr;
    }

    // await erroMotionToastInfo(context, msg: 'Something wrong !!');
    return null;
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

String getDurationI({required String status}) {
  if (status == 'Hour Off') {
    return '1';
  } else if (status == 'Half day - Morning') {
    return '2';
  } else if (status == 'Full day') {
    return '3';
  } else if (status == 'Half day - Afternoon') {
    return '4';
  } else {
    return '-1';
  }
}

String getLeaveDuration({required String durationId}) {
  if (durationId == '1') {
    return 'Hour Off';
  } else if (durationId == '2') {
    return 'Half day - Morning';
  } else if (durationId == '3') {
    return 'Full day';
  } else {
    return 'Half day - Afternoon';
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
    this.leaveFormModel,
  });

  final BehaviorSubject<String> textStream;
  final String heading;
  final String hint;
  final String label;
  // final String initialValue;
  final List<String> items;
  final GetLeaveForm? leaveFormModel;

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
    this.isForDateField = false,
    this.isNewLeave = false,
    super.key,
  });

  final bool isForDateField;
  final bool isNewLeave;
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
        _controller.text = (widget.isForDateField && widget.isNewLeave) ? UtilityFunctions.convertIntoNormalDateStringFromDateTimeString(value) : value;
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
                // height: 150.h,
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
                  minLines: 1,
                  maxLines: 50,
                  maxLength: 500,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  // expands: true,
                  // maxLines: null,
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
