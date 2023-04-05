import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fx_project/models/createjobmodel.dart';
import 'package:fx_project/screens/createjobsscreen/createjobsscreen.dart';
import 'package:fx_project/services/loginservice.dart';

class CreateJobServices {
  final Dio service;
  static final storage = FlutterSecureStorage();

  CreateJobServices({required this.service});

  Future<CreateJobResponseModel?> createJobService() async {
    dynamic token = await LoginService.getToken();

    bool validateStatus(status) {
      return status! <= 500;
    }

    final options = Options(
        validateStatus: validateStatus,
        headers: {"Authorization": "Bearer $token", "source": "android"});

    final response = await service.get(
      '/v1/properties/dropdown/',
      options: options,
    );

    if (response.statusCode == 200) {
      print("response in createjobservice: $response");
    } else {
      print(response.statusCode);
    }

    return CreateJobResponseModel.fromJson(response.data);
  }
}
