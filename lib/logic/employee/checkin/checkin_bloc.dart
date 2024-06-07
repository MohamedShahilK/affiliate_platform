// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/models/employee/checkin/get_checkin_form.dart';
import 'package:affiliate_platform/models/employee/checkin/get_checkin_view.dart';
import 'package:affiliate_platform/models/employee/checkin/getall_checkins.dart';
import 'package:affiliate_platform/services/employee/checkin/checkin_services.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class CheckInBloc {
  CheckInBloc() {
    initDetails();
  }

  final getAllCheckInsStream = BehaviorSubject<GetAllCheckIns?>();
  final getCheckInFormStream = BehaviorSubject<GetCheckinForm?>();
  final getCheckinViewStream = BehaviorSubject<GetCheckInView?>();

  final employeeStream = BehaviorSubject<String>.seeded('');
  final employeeIdStream = BehaviorSubject<String>.seeded('');

  final checkinTimeStream = BehaviorSubject<String>.seeded('');

  final projectStream = BehaviorSubject<String>.seeded('');
  final projectIdStream = BehaviorSubject<String>.seeded('');

  final descriptionStream = BehaviorSubject<String>.seeded('');

  final latitudeStream = BehaviorSubject<String>.seeded('');
  final longitudeStream = BehaviorSubject<String>.seeded('');

  final reqHourStream = BehaviorSubject<String>.seeded('');
  final reqMinStream = BehaviorSubject<String>.seeded('');

  final workFromStream = BehaviorSubject<String>.seeded('Office');
  final commentsStream = BehaviorSubject<String>.seeded('');

  Future<void> initDetails() async {
    await getAllCheckins();
    await getCheckinForm();
  }

  Future<void> getAllCheckins() async {
    final respModel = await CheckInServices().getAllCheckins();
    getAllCheckInsStream.add(respModel);
  }

  Future<void> getCheckinForm() async {
    final respModel = await CheckInServices().getCheckinForm();
    getCheckInFormStream.add(respModel);
  }

  Future<void> viewCheckin({required String checkInID}) async {
    getCheckinViewStream.add(null);
    final respModel = await CheckInServices().viewCheckin(checkInID: checkInID);
    getCheckinViewStream.add(respModel);
  }

  Future<bool> deleteContact({required String checkInID}) async {
    var isDeleted = false;

    final jsonData = await CheckInServices().deleteCheckin(checkInID: checkInID);

    if (jsonData != null && jsonData['status'] == 'SUCCESS' && jsonData['response'] == 'OK') {
      isDeleted = true;
    }

    return isDeleted;
  }

  Future<Map<String, dynamic>?> formSubmitCheckin({
    required String employeeId,
    required String projectId,
    required String workFromId,
  }) async {
    print('222222222222222222 ${checkinTimeStream.value}');
    final respModel = CheckInServices().formSubmitCheckin(
      employee: employeeId,
      dateTime: checkinTimeStream.value,
      // dateTime: '2024-06-18 10:00:00',
      workForm: workFromId,
      remarks: descriptionStream.value,
      latitude: latitudeStream.valueOrNull,
      longitude: longitudeStream.valueOrNull,
      projects_1: projectId,
      remarks_1: descriptionStream.value,
      reqHours_1: '${reqHourStream.value}:${reqMinStream.value}:00',
    );

    return respModel;
  }

  void clearStreams() {
    employeeStream.add('');
    employeeIdStream.add('');
    checkinTimeStream.add('');
    projectStream.add('');
    projectIdStream.add('');
    descriptionStream.add('');
    latitudeStream.add('');
    longitudeStream.add('');
    reqHourStream.add('');
    reqMinStream.add('');
    workFromStream.add('');
    commentsStream.add('');
  }

  void dispose() {
    getAllCheckInsStream.close();
  }
}
