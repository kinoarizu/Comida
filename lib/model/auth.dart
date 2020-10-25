part of 'model.dart';

class Auth {
  String name;
  String email;
  String password;
  String confirmPassword;
  String countryCode;
  String phoneNumber;
  String address;

  Auth({
    this.name,
    this.email,
    this.password,
    this.confirmPassword,
    this.countryCode,
    this.phoneNumber,
    this.address,
  });
}