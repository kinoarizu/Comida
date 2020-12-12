import 'package:comida/model/user_address.dart';
import 'package:flutter/material.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final List<UserAddress> addresses;

  User({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.phoneNumber,
    @required this.addresses,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    phoneNumber: json['phone_number'],
    addresses: List<UserAddress>.from(json['addresses'].map((x) => UserAddress.fromJson(x))),
  );
}