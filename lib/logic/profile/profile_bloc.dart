// ignore_for_file: lines_longer_than_80_chars

import 'package:affiliate_platform/models/profile/profile_model.dart';
import 'package:affiliate_platform/services/profile/profile_services.dart';
import 'package:rxdart/rxdart.dart';

class ProfileBloc {
  ProfileBloc() {
    initDetails();
  }

  final getAllProfileViewStream = BehaviorSubject<GetProfileView?>();

  Future<void> initDetails() async {
    await getAllContacts();
  }

  Future<void> getAllContacts() async {
    final respModel = await ProfileServices().getProfileView();
    getAllProfileViewStream.add(respModel);
  }

  void clearStreams() {}

  void dispose() {
    getAllProfileViewStream.close();
  }
}
