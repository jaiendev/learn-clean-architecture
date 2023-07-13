// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class AccountModel extends Equatable {
  final String id;
  final String email;
  final String fullName;
  const AccountModel({
    required this.id,
    required this.email,
    required this.fullName,
  });

  @override
  List<Object> get props => [id, email, fullName];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'fullName': fullName,
    };
  }

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      id: map['id'] as String,
      email: map['email'] as String,
      fullName: map['fullName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountModel.fromJson(String source) =>
      AccountModel.fromMap(json.decode(source) as Map<String, dynamic>);

  AccountModel copyWith({
    String? id,
    String? email,
    String? fullName,
  }) {
    return AccountModel(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
    );
  }

  @override
  bool get stringify => true;
}
