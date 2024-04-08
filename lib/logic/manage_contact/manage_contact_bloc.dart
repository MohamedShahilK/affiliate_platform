import 'package:affiliate_platform/models/manage_contact/all_contacts.dart';
import 'package:affiliate_platform/models/manage_contact/contact_form_model.dart';
import 'package:affiliate_platform/services/manage_contact/manage_contact_services.dart';
import 'package:rxdart/rxdart.dart';

class ManageContactBloc {
  ManageContactBloc() {
    initDetails();
  }

  final getAllContactsStream = BehaviorSubject<GetAllContactsAndUsers?>();
  final getContactFormStream = BehaviorSubject<ContactFormModel?>();

  Future<void> initDetails() async {
    await getAllContacts();
  }

  Future<void> getAllContacts() async {
    final respModel = await ManageContactSevices().getAllContacts();
    getAllContactsStream.add(respModel);
  }

  Future<void> getContactForm() async {
    final respModel = await ManageContactSevices().getContactForm();
    getContactFormStream.add(respModel);
  }

  void dispose() {
    getAllContactsStream.close();
  }
}
