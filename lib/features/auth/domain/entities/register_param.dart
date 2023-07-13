// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RegisterParam {
  final String email;
  final String password;
  final String fullName;
  RegisterParam({
    required this.email,
    required this.password,
    required this.fullName,
  });

  RegisterParam copyWith({
    String? email,
    String? password,
    String? fullName,
  }) {
    return RegisterParam(
      email: email ?? this.email,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'fullName': fullName,
    };
  }

  factory RegisterParam.fromMap(Map<String, dynamic> map) {
    return RegisterParam(
      email: map['email'] as String,
      password: map['password'] as String,
      fullName: map['fullName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterParam.fromJson(String source) =>
      RegisterParam.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RegisterValue(email: $email, password: $password, fullName: $fullName)';

  @override
  bool operator ==(covariant RegisterParam other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.password == password &&
        other.fullName == fullName;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode ^ fullName.hashCode;
}
