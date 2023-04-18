import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fx_project/models/createjobmodel.dart';
import 'package:fx_project/services/loginservice.dart';

class CreateJobServices {
  final Dio service;

  CreateJobServices({required this.service});

  //Future<CreateJobResponseModel?> createJobService() async {
  Future<List<dynamic>?> createJobService() async {
    dynamic token = await LoginService.getToken();

    bool validateStatus(status) {
      return status! <= 500;
    }

    final options = Options(
        validateStatus: validateStatus,
        headers: {"Authorization": "Bearer $token", "source": "android"});

    final response = await service.get(
      '',
      options: options,
    );

    if (response.statusCode == 200) {
      print("response in createjobservice: $response");
      // print("response in createjobservice data: ${response.data}");
    } else {
      print(response.statusCode);
    }
    // Map<String, Map<String, dynamic>> mapresponse = Map.fromIterable(
    //     response.data,
    //     key: (item) => item["id"],
    //     value: (item) => {"name": item["name"], "address": item["address"]});
    // print("map data : $mapresponse");
    // List<dynamic> respon = jsonDecode(response.data.toString());
    //print(response.data);
    //return CreateJobResponseModel.fromJson(response.data);
    return (response.data);
  }
}
