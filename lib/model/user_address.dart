import 'package:equatable/equatable.dart';

class UserAddress extends Equatable {
  final String type;
  final String address;

  UserAddress({
    this.type,
    this.address,
  });

  @override
  List<Object> get props => [
    type,
    address,
  ];

  factory UserAddress.fromJson(Map<String, dynamic> json) => UserAddress(
    type: json['type'],
    address: json['address'],
  );
}