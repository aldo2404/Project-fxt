import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepositories {
  static String mainUrl = "https://devapifyxt.com";
  var baseUrl = "$mainUrl/v1/login/";

  final FlutterSecureStorage storage = FlutterSecureStorage();
  final Dio _dio = Dio();

  Future<bool> hasToken() async {
    var value = await storage.read(key: 'token');
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> persisteToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async {
    storage.delete(key: 'token');
    storage.deleteAll();
  }

  Future<String> login(String email, String password) async {
    Response response =
        await _dio.post(baseUrl, data: {"email": email, "password": password});
    return response.data["token"];
  }
}
