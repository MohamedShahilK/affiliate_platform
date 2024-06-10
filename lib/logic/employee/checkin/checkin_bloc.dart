// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/app.dart';
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

  // final projectIdStream = BehaviorSubject<String>.seeded('');

  final projectStream1 = BehaviorSubject<String>.seeded('');
  final descriptionStream1 = BehaviorSubject<String>.seeded('');
  final reqHourStream1 = BehaviorSubject<String>.seeded('');
  final reqMinStream1 = BehaviorSubject<String>.seeded('');
  final projectStream2 = BehaviorSubject<String>.seeded('');
  final descriptionStream2 = BehaviorSubject<String>.seeded('');
  final reqHourStream2 = BehaviorSubject<String>.seeded('');
  final reqMinStream2 = BehaviorSubject<String>.seeded('');
  final projectStream3 = BehaviorSubject<String>.seeded('');
  final descriptionStream3 = BehaviorSubject<String>.seeded('');
  final reqHourStream3 = BehaviorSubject<String>.seeded('');
  final reqMinStream3 = BehaviorSubject<String>.seeded('');
  final projectStream4 = BehaviorSubject<String>.seeded('');
  final descriptionStream4 = BehaviorSubject<String>.seeded('');
  final reqHourStream4 = BehaviorSubject<String>.seeded('');
  final reqMinStream4 = BehaviorSubject<String>.seeded('');
  final projectStream5 = BehaviorSubject<String>.seeded('');
  final descriptionStream5 = BehaviorSubject<String>.seeded('');
  final reqHourStream5 = BehaviorSubject<String>.seeded('');
  final reqMinStream5 = BehaviorSubject<String>.seeded('');
  final projectStream6 = BehaviorSubject<String>.seeded('');
  final descriptionStream6 = BehaviorSubject<String>.seeded('');
  final reqHourStream6 = BehaviorSubject<String>.seeded('');
  final reqMinStream6 = BehaviorSubject<String>.seeded('');

  final latitudeStream = BehaviorSubject<String>.seeded('');
  final longitudeStream = BehaviorSubject<String>.seeded('');

  // final reqHourStream = BehaviorSubject<String>.seeded('');
  // final reqMinStream = BehaviorSubject<String>.seeded('');

  final workFromStream = BehaviorSubject<String>.seeded('Office');
  final commentsStream = BehaviorSubject<String>.seeded('');

  Future<void> initDetails() async {
    await getAllCheckins();
    await getCheckinForm();
  }

  Future<void> getAllCheckins() async {
    blocOficialLoaderNotifier.value = true;
    final respModel = await CheckInServices().getAllCheckins();
    getAllCheckInsStream.add(respModel);
    blocOficialLoaderNotifier.value = false;
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
    required String workFromId,
    required String projectId1,
    String? projectId2,
    String? projectId3,
    String? projectId4,
    String? projectId5,
    String? projectId6,
  }) async {
    print('222222222222222222 ${checkinTimeStream.value}');
    final respModel = CheckInServices().formSubmitCheckin(
      employee: employeeId,
      dateTime: checkinTimeStream.value,
      // dateTime: '2024-06-18 10:00:00',
      workForm: workFromId,
      comments: commentsStream.value,
      latitude: latitudeStream.valueOrNull,
      longitude: longitudeStream.valueOrNull,
      projects_1: projectId1,
      remarks_1: descriptionStream1.value,
      reqHours_1: '${reqHourStream1.value}:${reqMinStream1.value}:00',
      projects_2: projectId2,
      remarks_2: descriptionStream2.value,
      reqHours_2: '${reqHourStream2.value}:${reqMinStream2.value}:00',
      projects_3: projectId3,
      remarks_3: descriptionStream3.value,
      reqHours_3: '${reqHourStream3.value}:${reqMinStream3.value}:00',
      projects_4: projectId4,
      remarks_4: descriptionStream4.value,
      reqHours_4: '${reqHourStream4.value}:${reqMinStream4.value}:00',
      projects_5: projectId5,
      remarks_5: descriptionStream5.value,
      reqHours_5: '${reqHourStream5.value}:${reqMinStream5.value}:00',
      projects_6: projectId6,
      remarks_6: descriptionStream6.value,
      reqHours_6: '${reqHourStream6.value}:${reqMinStream6.value}:00',
    );

    return respModel;
  }

  void clearStreams() {
    employeeStream.add('');
    employeeIdStream.add('');
    checkinTimeStream.add('');
    // projectIdStream.add('');

    projectStream1.add('');
    reqHourStream1.add('');
    reqMinStream1.add('');
    descriptionStream1.add('');
    projectStream2.add('');
    reqHourStream2.add('');
    reqMinStream2.add('');
    descriptionStream2.add('');
    projectStream3.add('');
    reqHourStream3.add('');
    reqMinStream3.add('');
    descriptionStream3.add('');
    projectStream4.add('');
    reqHourStream4.add('');
    reqMinStream4.add('');
    descriptionStream4.add('');
    projectStream5.add('');
    reqHourStream5.add('');
    reqMinStream5.add('');
    descriptionStream5.add('');
    projectStream6.add('');
    reqHourStream6.add('');
    reqMinStream6.add('');
    descriptionStream6.add('');

    latitudeStream.add('');
    longitudeStream.add('');

    workFromStream.add('');
    commentsStream.add('');
  }

  void dispose() {
    getAllCheckInsStream.close();
  }
}
