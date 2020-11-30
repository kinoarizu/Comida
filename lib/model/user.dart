part of 'model.dart';

class User extends Equatable {
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

  @override
  List<Object> get props => [
    id,
    name,
    email,
    phoneNumber,
    addresses,
  ];

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    phoneNumber: json['phone_number'],
    addresses: List<UserAddress>.from(json['addresses'].map((x) => UserAddress.fromJson(x))),
  );
}