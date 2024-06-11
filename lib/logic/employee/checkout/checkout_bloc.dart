// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/app.dart';
import 'package:affiliate_platform/models/employee/checkout/get_allcheckout.dart';
import 'package:affiliate_platform/models/employee/checkout/get_checkout_form_model.dart';
import 'package:affiliate_platform/models/employee/checkout/get_checkout_view.dart';
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
    await getAllCheckouts();
    // await getContactForm();
  }

  Future<void> getAllCheckouts() async {
    // getAllCheckOutsStream.add(GetAllCheckouts(status: 'Loading', response: null, data: null));
    blocOficialLoaderNotifier.value = true;
    // getAllCheckOutsStream.add(null);
    final respModel = await CheckOutServices().getAllCheckouts();
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
