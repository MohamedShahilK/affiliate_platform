// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/app.dart';
import 'package:affiliate_platform/models/employee/checkin/get_checkin_form.dart';
import 'package:affiliate_platform/models/employee/checkout/get_allcheckout.dart';
import 'package:affiliate_platform/models/employee/checkout/get_checkout_form_model.dart';
import 'package:affiliate_platform/models/employee/checkout/get_checkout_view.dart';
import 'package:affiliate_platform/services/employee/checkin/checkin_services.dart';
import 'package:affiliate_platform/services/employee/checkout/checkout_services.dart';
import 'package:rxdart/rxdart.dart';

class CheckOutBloc {
  CheckOutBloc() {
    initDetails();
  }

  final getAllCheckOutsStream = BehaviorSubject<GetAllCheckouts?>();
  final getCheckOutFormStream = BehaviorSubject<GetCheckOutFormModel?>();
  final getCheckOutViewStream = BehaviorSubject<GetCheckOutView?>();

  final employeeStream = BehaviorSubject<String>.seeded('');
  final employeeIdStream = BehaviorSubject<String>.seeded('');

  final checkinTimeStream = BehaviorSubject<String>.seeded('');
  final checkoutTimeStream = BehaviorSubject<String>.seeded('');

  // final projectIdStream = BehaviorSubject<String>.seeded('');

  final projectStream1 = BehaviorSubject<String>.seeded('');
  final descriptionStream1 = BehaviorSubject<String>.seeded('');
  final reqHourStream1 = BehaviorSubject<String>.seeded('');
  final reqMinStream1 = BehaviorSubject<String>.seeded('');
  final projectStatusStream1 = BehaviorSubject<String>.seeded('');
  final projectStream2 = BehaviorSubject<String>.seeded('');
  final descriptionStream2 = BehaviorSubject<String>.seeded('');
  final reqHourStream2 = BehaviorSubject<String>.seeded('');
  final reqMinStream2 = BehaviorSubject<String>.seeded('');
  final projectStatusStream2 = BehaviorSubject<String>.seeded('');
  final projectStream3 = BehaviorSubject<String>.seeded('');
  final descriptionStream3 = BehaviorSubject<String>.seeded('');
  final reqHourStream3 = BehaviorSubject<String>.seeded('');
  final reqMinStream3 = BehaviorSubject<String>.seeded('');
  final projectStream4 = BehaviorSubject<String>.seeded('');
  final projectStatusStream3 = BehaviorSubject<String>.seeded('');
  final descriptionStream4 = BehaviorSubject<String>.seeded('');
  final reqHourStream4 = BehaviorSubject<String>.seeded('');
  final reqMinStream4 = BehaviorSubject<String>.seeded('');
  final projectStatusStream4 = BehaviorSubject<String>.seeded('');
  final projectStream5 = BehaviorSubject<String>.seeded('');
  final descriptionStream5 = BehaviorSubject<String>.seeded('');
  final reqHourStream5 = BehaviorSubject<String>.seeded('');
  final reqMinStream5 = BehaviorSubject<String>.seeded('');
  final projectStatusStream5 = BehaviorSubject<String>.seeded('');
  final projectStream6 = BehaviorSubject<String>.seeded('');
  final descriptionStream6 = BehaviorSubject<String>.seeded('');
  final reqHourStream6 = BehaviorSubject<String>.seeded('');
  final reqMinStream6 = BehaviorSubject<String>.seeded('');
  final projectStatusStream6 = BehaviorSubject<String>.seeded('');

  final latitudeStream = BehaviorSubject<String>.seeded('');
  final longitudeStream = BehaviorSubject<String>.seeded('');

  // final reqHourStream = BehaviorSubject<String>.seeded('');
  // final reqMinStream = BehaviorSubject<String>.seeded('');

  final workFromStream = BehaviorSubject<String>.seeded('Office');
  final commentsStream = BehaviorSubject<String>.seeded('');
  final breakHrsStream = BehaviorSubject<String>.seeded('');
  final breakRemarkStream = BehaviorSubject<String>.seeded('');

  // Filtering
  final employeeFilterStream = BehaviorSubject<String>.seeded('');
  final projectFilterStream = BehaviorSubject<String>.seeded('');
  final checkOutFromDateFilterStream = BehaviorSubject<String>.seeded('');
  final checkOutToDateFilterStream = BehaviorSubject<String>.seeded('');
  final checkOutStatusFilterStream = BehaviorSubject<String>.seeded('');

  final getCheckInFormStream = BehaviorSubject<GetCheckinForm?>();

  Future<void> initDetails() async {
    await getAllCheckouts();
    await getCheckinForm();
  }

  Future<void> getCheckinForm() async {
    final respModel = await CheckInServices().getCheckinForm();
    getCheckInFormStream.add(respModel);
  }

  Future<void> getAllCheckouts({
    String? employeeId,
    String? projectId,
    String? outStatusID,
  }) async {
    // getAllCheckOutsStream.add(GetAllCheckouts(status: 'Loading', response: null, data: null));
    blocOficialLoaderNotifier.value = true;
    // getAllCheckOutsStream.add(null);
    final respModel = await CheckOutServices().getAllCheckouts(
      employeeSearch: employeeId,
      projectSearch: projectId,
      checkOutFrom: checkOutFromDateFilterStream.valueOrNull,
      checkOutTo: checkOutToDateFilterStream.valueOrNull,
      checkOutStatus: outStatusID,
    );
    getAllCheckOutsStream.add(respModel);
    blocOficialLoaderNotifier.value = false;
  }

  Future<void> getCheckOutForm({required String dateTimeStr}) async {
    final respModel = await CheckOutServices().getCheckOutForm(dateTimeStr: dateTimeStr);
    getCheckOutFormStream.add(respModel);
  }

  Future<void> viewCheckOut({required String checkoutId}) async {
    getCheckOutViewStream.add(null);
    final respModel = await CheckOutServices().viewCheckOut(checkoutId: checkoutId);
    getCheckOutViewStream.add(respModel);
  }

  Future<bool> deleteCheckOut({required String checkOutId}) async {
    var isDeleted = false;

    final jsonData = await CheckOutServices().deleteCheckOut(checkOutID: checkOutId);

    if (jsonData != null && jsonData['status'] == 'SUCCESS' && jsonData['response'] == 'OK') {
      isDeleted = true;
    }

    return isDeleted;
  }

  Future<Map<String, dynamic>?> formSubmitCheckOut({
    required String dateTimeIdForCheckOut,
    required String employeeId,
    required String workFromId,
    required String checkInId,
    required String projectId1,
    required String refMain1,
    required String refSub1,
    String? projectId2,
    String? refMain2,
    String? refSub2,
    String? projectId3,
    String? refMain3,
    String? refSub3,
    String? projectId4,
    String? refMain4,
    String? refSub4,
    String? projectId5,
    String? refMain5,
    String? refSub5,
    String? projectId6,
    String? refMain6,
    String? refSub6,
  }) async {
    // print('222222222222222222 ${checkinTimeStream.value}');
    final respModel = CheckOutServices().formSubmitCheckOut(
      dateTimeIdForCheckOut: dateTimeIdForCheckOut,
      breakHours: breakHrsStream.value,
      breakHoursRemarks: breakRemarkStream.value,
      checkInId: checkInId,
      employee: employeeId,
      outTime: checkoutTimeStream.value,
      // dateTime: '2024-06-18 10:00:00',
      workFrom: workFromId,

      comments: commentsStream.value,
      latitude: latitudeStream.valueOrNull,
      longitude: longitudeStream.valueOrNull,
      projects_1: projectId1,
      remarks_1: descriptionStream1.value,
      // reqHours_1: '${reqHourStream1.value}:${reqMinStream1.value}:00',
      reqHours_1: reqHourStream1.value,
      reqMin_1: reqMinStream1.value,
      projectStatus_1: '2',
      refMain1: refMain1,
      refSub1: refSub1,
      projects_2: projectId2,
      remarks_2: descriptionStream2.value,
      // reqHours_2: '${reqHourStream2.value}:${reqMinStream2.value}:00',
      reqHours_2: reqHourStream2.value,
      reqMin_2: reqMinStream2.value,
      projectStatus_2: '2',
      refMain2: refMain2,
      refSub2: refSub2,
      projects_3: projectId3,
      remarks_3: descriptionStream3.value,
      // reqHours_3: '${reqHourStream3.value}:${reqMinStream3.value}:00',
      reqHours_3: reqHourStream3.value,
      reqMin_3: reqMinStream3.value,
      projectStatus_3: '2',
      refMain3: refMain3,
      refSub3: refSub3,
      projects_4: projectId4,
      remarks_4: descriptionStream4.value,
      // reqHours_4: '${reqHourStream4.value}:${reqMinStream4.value}:00',
      reqHours_4: reqHourStream4.value,
      reqMin_4: reqMinStream4.value,
      refMain4: refMain4,
      projectStatus_4: '2',
      refSub4: refSub4,
      projects_5: projectId5,
      remarks_5: descriptionStream5.value,
      // reqHours_5: '${reqHourStream5.value}:${reqMinStream5.value}:00',
      reqHours_5: reqHourStream5.value,
      reqMin_5: reqMinStream5.value,
      projectStatus_5: '2',
      refMain5: refMain5,
      refSub5: refSub5,
      projects_6: projectId6,
      remarks_6: descriptionStream6.value,
      // reqHours_6: '${reqHourStream6.value}:${reqMinStream6.value}:00',
      reqHours_6: reqHourStream6.value,
      reqMin_6: reqMinStream6.value,
      projectStatus_6: '2',
      refMain6: refMain6,
      refSub6: refSub6,
    );

    return respModel;
  }

  void clearStreams() {
    employeeStream.add('');
    employeeIdStream.add('');
    checkinTimeStream.add('');
    projectStream1.add('');
    descriptionStream1.add('');
    reqHourStream1.add('');
    reqMinStream1.add('');
    projectStream2.add('');
    descriptionStream2.add('');
    reqHourStream2.add('');
    reqMinStream2.add('');
    projectStream3.add('');
    descriptionStream3.add('');
    reqHourStream3.add('');
    reqMinStream3.add('');
    projectStream4.add('');
    descriptionStream4.add('');
    reqHourStream4.add('');
    reqMinStream4.add('');
    projectStream5.add('');
    descriptionStream5.add('');
    reqHourStream5.add('');
    reqMinStream5.add('');
    projectStream6.add('');
    descriptionStream6.add('');
    reqHourStream6.add('');
    reqMinStream6.add('');
    latitudeStream.add('');
    longitudeStream.add('');
    workFromStream.add('');
    commentsStream.add('');
  }

  void dispose() {
    getAllCheckOutsStream.close();
  }
}
