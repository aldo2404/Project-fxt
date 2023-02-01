import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LoginAuthentication {
  Future getres(String email, pass) async {
    try {
      Response response = await post(
          Uri.parse('https://qaapifyxt.com/v1/login/'),
          body: {"email": email, "password": pass});
      print(response.statusCode);

      var data = jsonDecode(response.body.toString());
      print(data);
      if (response.statusCode == 200) {
        print('authentication success');
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
