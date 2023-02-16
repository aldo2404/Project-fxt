import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fx_project/models/login_response_model.dart';

class LoginService {
  final Dio service;
  static final storage = FlutterSecureStorage();
  LoginService({required this.service});

  Future<LoginResponseModel?> loginService(loginModel) async {
    final data = {
      'email': loginModel.email,
      'password': loginModel.password,
    };

    bool validateStatus(status) {
      return status! <= 500;
    }

    final options = Options(validateStatus: validateStatus);

    final response = await service.post(
      '/v1/login/',
      options: options,
      data: data,
    );

    return LoginResponseModel.fromJson(response.data);
  }

  static void storeToken(String token) async {
    await storage.write(key: "token", value: token);
  }

  static Future<String?> getToken(String token) async {
    return await storage.read(key: "token");
  }
}
