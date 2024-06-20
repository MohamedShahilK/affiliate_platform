// ignore_for_file: lines_longer_than_80_chars, argument_type_not_assignable_to_error_handler

import 'package:affiliate_platform/config/ripple.dart';
import 'package:affiliate_platform/logic/attendance/attendance_bloc.dart';
import 'package:affiliate_platform/models/attendance/attendance_model.dart';
import 'package:affiliate_platform/utils/constants/styles.dart';
import 'package:affiliate_platform/utils/custom_tools.dart';
import 'package:affiliate_platform/utils/utility_functions.dart';
import 'package:affiliate_platform/view/common/custom_header.dart';
import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:affiliate_platform/view/common/sidebar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  var _refreshKey = UniqueKey();

  // To update or hot reload
  void _handleLocaleChanged() => setState(() {
        _refreshKey = UniqueKey();
      });

  AttendanceBloc? attendanceBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    attendanceBloc ??= Provider.of<AttendanceBloc>(context);
    attendanceBloc!.clearStreams();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await attendanceBloc!.getAttendaceDetails();
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<AttendanceBloc>(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        await appExitDialog(context);
      },
      child: CustomScaffold(
        key: _refreshKey,
        // floatingActionButtonIcon: FontAwesomeIcons.userPen,
        // onTapFloatingButton: () {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => const EditProfile(),
        //     ),
        //   );
        // },
        body: SafeArea(
          child: GestureDetector(
            // onTap: _handleLocaleChanged,
            onTap: () {
              // _handleLocaleChanged();
              menuVisibility.value = false;
              menuVisibility.notifyListeners();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // const CustomHeader(
                  //   heading: 'Profile',
                  //   isBackButtonNeeded: true,
                  //   isTrailingButtonNeeded: true,
                  // ),

                  const CustomHeader(),

                  //

                  SizedBox(height: 10.h),
                  StreamBuilder(
                    stream: bloc.getAttendanceStream,
                    builder: (context, getAttendanceStreamsnapshot) {
                      if ((!getAttendanceStreamsnapshot.hasData && getAttendanceStreamsnapshot.connectionState != ConnectionState.waiting) || getAttendanceStreamsnapshot.hasError) {
                        Loader.hide();
                        return Column(
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
                                  Text('Refresh', style: TextStyle(fontSize: 15.w)),
                                ],
                              ),
                            ).ripple(
                              context,
                              () async {
                                await bloc.getAttendaceDetails();
                              },
                              borderRadius: BorderRadius.circular(15.r),
                              overlayColor: Colors.purple.withOpacity(.15),
                            ),
                          ],
                        );
                      }

                      GetAttendanceModel? attendanceRespModel;

                      List<AttendanceSummary>? attendanceSummary = [];

                      List<AttendanceDataList>? attendanceDataList = [];

                      if (getAttendanceStreamsnapshot.hasData) {
                        attendanceRespModel = getAttendanceStreamsnapshot.data;
                        if (attendanceRespModel!.data != null && attendanceRespModel.data!.isNotEmpty) {
                          attendanceSummary = attendanceRespModel.data?[0].attendanceSummary ?? [];
                          attendanceDataList = attendanceRespModel.data?[0].attendanceDataList ?? [];
                        }
                        // bloc.dateStream.add(attendanceRespModel.data?[0].filterDate ?? 'May 2024');
                      }

                      return Skeletonizer(
                        enabled: getAttendanceStreamsnapshot.connectionState == ConnectionState.waiting,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: AttendanceDropDown(
                                          attendanceModel: attendanceRespModel,
                                          textStream: bloc.employeeNameStream,
                                          heading: 'Employee',
                                          hint: 'Select Employee',
                                          // items:leaveFormModel != null ? ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'] : ['', 'Qtn2016', 'Qtn2017', 'Qtn2018'],
                                          items: (attendanceRespModel != null &&
                                                  attendanceRespModel.data != null &&
                                                  attendanceRespModel.data!.isNotEmpty &&
                                                  attendanceRespModel.data?[0].employee != null)
                                              ? ['', ...attendanceRespModel.data![0].employee!.map((e) => e.firstName ?? '')]
                                              : [''],
                                          label: 'Employee',
                                        ),
                                      ),
                                      SizedBox(width: 20.w),
                                      Expanded(
                                        child: AttendanceField(
                                          enabled: false,
                                          heading: 'Apply Date',
                                          hintText: 'Select Apply Date',
                                          textStream: bloc.dateStream,
                                          // onChanged: bloc.dateStream.add,
                                          onTap: () async {
                                            final date = await _selectMonthYear(context);
                                            bloc.dateStream.add(date ?? '');
                                          },
                                        ),
                                      ),
                                    ],
                                  ),

                                  //
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                      margin: EdgeInsets.only(bottom: 15.h),
                                      decoration: BoxDecoration(
                                        color: Colors.purple,
                                        borderRadius: BorderRadius.circular(10.r),
                                      ),
                                      child: Text('Filter', style: AppStyles.poppins.copyWith(fontSize: 10.w, color: Colors.white)),
                                    ).ripple(context, () async {
                                      customLoader(context);
                                      try {
                                        await bloc.getAttendaceDetails(filterDate: bloc.dateStream.valueOrNull);
                                        Loader.hide();
                                      } catch (e) {
                                        Loader.hide();
                                      } finally {
                                        Loader.hide();
                                      }
                                    }),
                                  ),
                                ],
                              ),
                            ), //dropdown
                            // _body(),

                            if (attendanceSummary.isEmpty)
                              const SizedBox.shrink()
                            else
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 12.w),
                                  child: DataTable(
                                    border: TableBorder.all(
                                      color: Colors.purple[100]!,
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    columnSpacing: 10,

                                    dividerThickness: .4,
                                    // dataRowColor: MaterialStateProperty.all(Colors.red),
                                    // Datatable widget that have the property columns and rows.
                                    columns: [
                                      // Set the name of the column
                                      DataColumn(label: Flexible(child: Center(child: Text('Name', style: TextStyle(fontSize: 10.w))))),
                                      DataColumn(label: Flexible(child: Center(child: Text('No. Of\nPresent', style: TextStyle(fontSize: 10.w))))),
                                      DataColumn(label: Flexible(child: Center(child: Text('No. Of\nFullday Leave', style: TextStyle(fontSize: 10.w))))),
                                      DataColumn(label: Flexible(child: Center(child: Text('No. Of\nHalfday Morning', style: TextStyle(fontSize: 10.w))))),
                                      DataColumn(label: Flexible(child: Center(child: Text('No. Of\nHalfday Afternoon', style: TextStyle(fontSize: 10.w))))),
                                      DataColumn(label: Flexible(child: Center(child: Text('Total\nLeaves Taken', style: TextStyle(fontSize: 10.w))))),
                                      DataColumn(label: Flexible(child: Center(child: Text('No. Of\nHours Off', style: TextStyle(fontSize: 10.w))))),
                                      DataColumn(label: Flexible(child: Center(child: Text('No. Of\nHoliday', style: TextStyle(fontSize: 10.w))))),
                                    ],
                                    rows: [
                                      // Set the values to the columns
                                      DataRow(
                                        cells: [
                                          DataCell(Center(child: Text('${attendanceSummary[0].firstName} ${attendanceSummary[0].lastName}', style: TextStyle(fontSize: 10.w)))),
                                          DataCell(Center(child: Text('${attendanceSummary[0].isPresent}', style: TextStyle(fontSize: 10.w)))),
                                          DataCell(Center(child: Text('${attendanceSummary[0].isFullday}', style: TextStyle(fontSize: 10.w)))),
                                          DataCell(Center(child: Text('${attendanceSummary[0].isHalfdayMorning}', style: TextStyle(fontSize: 10.w)))),
                                          DataCell(Center(child: Text('${attendanceSummary[0].isHalfdayAfternoon}', style: TextStyle(fontSize: 10.w)))),
                                          DataCell(Center(child: Text('${attendanceSummary[0].isLeave}', style: TextStyle(fontSize: 10.w)))),
                                          DataCell(Center(child: Text('${attendanceSummary[0].isHoursOff}', style: TextStyle(fontSize: 10.w)))),
                                          DataCell(Center(child: Text('${attendanceSummary[0].isHoliday}', style: TextStyle(fontSize: 10.w)))),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            if (attendanceSummary.isEmpty) const SizedBox.shrink() else SizedBox(height: 15.h),

                            if (attendanceSummary.isEmpty)
                              const Center(child: Text('No Data Found'))
                            else
                              SingleChildScrollView(
                                // scrollDirection: Axis.vertical,
                                child: DataTable(
                                  // headingRowColor: MaterialStateProperty.all(Colors.purple),
                                  dividerThickness: .4,
                                  border: TableBorder.all(
                                    color: Colors.purple[100]!,
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  dataRowMaxHeight: 25.h,
                                  dataRowMinHeight: 15.h,
                                  headingRowHeight: 35.h,
                                  // dataRowColor: MaterialStateProperty.all(Colors.red),
                                  // Datatable widget that have the property columns and rows.
                                  columns: [
                                    // Set the name of the column
                                    DataColumn(label: Flexible(child: Center(child: Text('Date', style: TextStyle(fontSize: 10.w))))),
                                    DataColumn(label: Flexible(child: Center(child: Text('Day', style: TextStyle(fontSize: 10.w))))),
                                    DataColumn(label: Flexible(child: Center(child: Text('Shahil', style: TextStyle(fontSize: 10.w))))),
                                  ],
                                  rows: List.generate(
                                    attendanceDataList.length,
                                    (index) => DataRow(
                                      cells: [
                                        DataCell(Flexible(child: Center(child: Text((index + 1).toString(), style: TextStyle(fontSize: 10.w))))),
                                        DataCell(
                                          Flexible(
                                            child: Center(child: Text(UtilityFunctions().getDayOfWeek(attendanceDataList?[index].date ?? '10-05-2024'), style: TextStyle(fontSize: 10.w))),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            alignment: Alignment.center,
                                            width: 70.w,
                                            // color: Colors.green,
                                            color: _presentOrNotColor(presentStatus: attendanceDataList?[index].attendance ?? 'H'),
                                            child: Text('${attendanceDataList?[index].attendance}', style: TextStyle(color: Colors.white, fontSize: 11.w, fontWeight: FontWeight.w900)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> _selectMonthYear(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    int selectedYear = initialDate.year;
    int selectedMonth = initialDate.month;

    final picked = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title:  Text('Select Month and Year',style: TextStyle(fontSize: 13.w)),
              content: SizedBox(
                height: 120.h,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text('Year:'),
                        DropdownButton<int>(
                          dropdownColor: Colors.white,
                          value: selectedYear,
                          items: List.generate(100, (index) {
                            int year = initialDate.year - 50 + index;
                            return DropdownMenuItem<int>(
                              value: year,
                              child: Text('$year'),
                            );
                          }),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                selectedYear = value;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text('Month:'),
                        DropdownButton<int>(
                          dropdownColor: Colors.white,
                          value: selectedMonth,
                          items: List.generate(12, (index) {
                            int month = index + 1;
                            return DropdownMenuItem<int>(
                              value: month,
                              child: Text(DateFormat.MMMM().format(DateTime(0, month))),
                            );
                          }),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                selectedMonth = value;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(DateTime(selectedYear, selectedMonth));
                  },
                ),
              ],
            );
          },
        );
      },
    );

    if (picked != null) {
      final dateStr = DateFormat('MMMM yyyy').format(picked);
      return dateStr;
    }

    return null;
  }
}

Color _presentOrNotColor({required String presentStatus}) {
  var color = Colors.grey[200]!;
  if (presentStatus == 'P') {
    color = Colors.green;
  } else if (presentStatus == 'H') {
    color = Colors.orange[400]!;
  } else if (presentStatus == 'P / WFH') {
    color = const Color(0xFF666ee8);
  } else if (presentStatus == 'L') {
    color = Colors.red;
  } else if (presentStatus == 'P-H') {
    color = Colors.blue;
  }
  return color;
}

class AttendanceDropDown extends StatefulWidget {
  const AttendanceDropDown({
    // required this.controller,
    required this.textStream,
    required this.heading,
    required this.hint,
    required this.label,
    // required this.initialValue,
    required this.items,
    super.key,
    this.attendanceModel,
  });

  final BehaviorSubject<String> textStream;
  final String heading;
  final String hint;
  final String label;
  // final String initialValue;
  final List<String> items;
  final GetAttendanceModel? attendanceModel;

  @override
  State<AttendanceDropDown> createState() => _NewContactDropDownState();
}

class _NewContactDropDownState extends State<AttendanceDropDown> {
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
              borderRadius: BorderRadius.circular(8),
              // border: Border.all(color: const Color.fromARGB(139, 103, 51, 137)),
              border: Border.all(color: Colors.grey[200]!),
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
                              fontSize: 10.w,
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
                      fontSize: 10.w,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // value: selectedValue == '' ? null : selectedValue,
                    value: data == '' ? null : data,
                    onChanged: (value) {
                      // setState(() {
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
                      // });
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 35.h,
                      // width: 160,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
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

class AttendanceField extends StatefulWidget {
  const AttendanceField({
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
  State<AttendanceField> createState() => _AttendanceFieldState();
}

class _AttendanceFieldState extends State<AttendanceField> {
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
          return InkWell(
            onTap: widget.onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(heading, style: AppStyles.poppins.copyWith(fontSize: 12.w, color: Colors.purple)),
                // SizedBox(height: 7.h),
                SizedBox(
                  // height: widget.isLargeField ? null : 50.h,
                  height: 35.h,
                  child: TextFormField(
                    // initialValue: widget.initialValue,
                    scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom + 15.w * 6, // Adjust the value as needed
                    ),
                    // controller: controller,
                    style: AppStyles.poppins.copyWith(
                      color: Colors.purple,
                      fontSize: 10.w,
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
                        fontSize: 10.w,
                      ),
                      contentPadding: EdgeInsets.only(left: 15.w),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color.fromARGB(139, 103, 51, 137)),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color.fromARGB(139, 103, 51, 137)),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color.fromARGB(255, 152, 102, 185)),
                        borderRadius: BorderRadius.circular(8.r),
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
