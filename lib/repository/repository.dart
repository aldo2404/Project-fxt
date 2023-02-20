// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;

// class AuthRepository {
//   //static final client = http.Client();
//   static final storage = FlutterSecureStorage();
//   Future login(String email, String password) async {
//     var res = await http.post(Uri.parse("https://devapifyxt.com/v1/login/"),
//         headers: {}, body: {"email": email, "password": password});
//     final data = json.decode(res.body);
//     print(res.body);
//     // print(data['token']);
//     final List<String> dataList = data['domains'];
//     var token = data['token'];
//     if (res.statusCode == 200) {
//       print('auth success');
//     } else {
//       print('failed');
//       //return Scaffold().bottomSheet;
//     }
//   }
// }
