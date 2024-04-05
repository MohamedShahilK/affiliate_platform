import 'package:json_annotation/json_annotation.dart';

part 'all_contacts.g.dart';

@JsonSerializable()
class GetAllContactsAndUsers {
  GetAllContactsAndUsers({this.status, this.response, this.data});
  final String? status;
  final String? response;
  final List<Data>? data;
}

class Data {
  Data({
    this.tableTitle,
    this.contactTypeSearch,
    this.contactsSearch,
    this.followupDateSearch,
    this.followupDateSearchTo,
    this.createdDateSearch,
    this.createdDateSearchTo,
    this.contactsCompletedPercentageSearch,
    this.createdBySearch,
    this.totalContacts,
    this.contacts,
    this.users,
  });
  final String? tableTitle;
  final String? contactTypeSearch;
  final String? contactsSearch;
  final String? followupDateSearch;
  final String? followupDateSearchTo;
  final String? createdDateSearch;
  final String? createdDateSearchTo;
  final String? contactsCompletedPercentageSearch;
  final String? createdBySearch;
  final int? totalContacts;
  final List<String>? contacts;
  final List<Users>? users;
}

class Users {
  Users({this.id, this.firstName, this.lastName, this.email});
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
}
