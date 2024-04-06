import 'package:json_annotation/json_annotation.dart';

part 'contact_form_model.g.dart';

@JsonSerializable()
class ContactFormModel {
  ContactFormModel({this.status, this.response, this.data});
  String? status;
  String? response;
  List<Data>? data;
}

@JsonSerializable()
class Data {
  Data({this.title, this.contactSources, this.contactType});
  String? title;
  List<ContactSources>? contactSources;
  Map<String, dynamic>? contactType;
}

@JsonSerializable()
class ContactSources {
  String? id;
  String? sourceName;
  String? status;
}
