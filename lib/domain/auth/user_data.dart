// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  final String name;
  final String phone;
  final String dateOfBirth;
  final String age;
  final String gender;
  const UserData({
    required this.name,
    required this.phone,
    required this.dateOfBirth,
    required this.age,
    required this.gender,
  });

  UserData copyWith({
    String? name,
    String? phone,
    String? dateOfBirth,
    String? age,
    String? gender,
  }) {
    return UserData(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      age: age ?? this.age,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'dateOfBirth': dateOfBirth,
      'age': age,
      'gender': gender,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      dateOfBirth: map['dateOfBirth'] ?? '',
      age: map['age'] as String,
      gender: map['gender'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      name,
      phone,
      dateOfBirth,
      age,
      gender,
    ];
  }

  factory UserData.init() =>
      const UserData(name: '', phone: '', dateOfBirth: '', age: '', gender: '');
}
