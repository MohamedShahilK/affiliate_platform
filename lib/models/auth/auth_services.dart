import 'package:affiliate_platform/api/api.dart';

class AuthServices {

  factory  AuthServices() => _instance ??= AuthServices();
  // ignore: unused_element
  AuthServices._();
  static AuthServices? _instance;

  final api = Api();
  
}
