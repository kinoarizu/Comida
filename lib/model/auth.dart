part of 'model.dart';

/// Declaring Auth Model
/// Using to passsing user auth data when authentication like sign up, sign in, and verification.

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