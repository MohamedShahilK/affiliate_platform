// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/models/employee/checkout/get_allcheckout.dart';
import 'package:affiliate_platform/services/employee/checkout/checkout_services.dart';
import 'package:rxdart/rxdart.dart';

class CheckOutBloc {
  CheckOutBloc() {
    initDetails();
  }

  final getAllCheckOutsStream = BehaviorSubject<GetAllCheckouts?>();

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
    final respModel = await CheckOutServices().getAllCheckouts();
    getAllCheckOutsStream.add(respModel);
  }

  void clearStreams() {}

  void dispose() {
    getAllCheckOutsStream.close();
  }
}
