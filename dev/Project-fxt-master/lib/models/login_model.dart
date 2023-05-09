import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LoginModel {
  String? email;
  String? password;

  LoginModel({this.email, this.password});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      email: json['email'] as String?,
      password: json['password'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }
}
