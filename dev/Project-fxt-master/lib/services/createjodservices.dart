// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fx_project/screens/environmentpage.dart';
import 'package:fx_project/services/loginservice.dart';

class CreateJobServices {
  final Dio? service;

  CreateJobServices({this.service});

  //Future<CreateJobResponseModel?> createJobService() async {
  Future<List<dynamic>?> createJobService() async {
    dynamic token = await LoginService.getToken();

    bool validateStatus(status) {
      return status! <= 500;
    }

    final options = Options(
        validateStatus: validateStatus,
        headers: {"Authorization": "Bearer $token", "source": "android"});

    final response = await service!.get(
      '',
      options: options,
    );

    if (response.statusCode == 200) {
      print('success');
    } else {
      print(response.statusCode);
    }

    return (response.data);
  }

//image file upload use post method ......

  Future<dynamic> uploadFile(uploadFile) async {
    try {
      dynamic token = await LoginService.getToken();
      print('load file $uploadFile');

      dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;
      print(baseurl1);
      final Dio serv = Dio(BaseOptions(baseUrl: 'https://$baseurl1'));

      bool validateStatus(status) {
        return status! <= 500;
      }

      final options = Options(
          validateStatus: validateStatus,
          headers: {"Authorization": "Bearer $token", "source": "android"});
      FormData formData = FormData();

      for (var i = 0; i < uploadFile.length; i++) {
        print(uploadFile[i].path);
        formData.files.add(MapEntry(
          'file',
          await MultipartFile.fromFile(
            uploadFile[i].path.toString(),
          ),
        ));
        formData.fields.add(const MapEntry('mime_type', 'image/png'));
        formData.fields.add(const MapEntry('description', 'photo'));
        formData.fields.add(const MapEntry('source', 'job'));
        formData.fields.add(const MapEntry('type', 'Pro Completion'));
      }

      var response = await serv.post(
        '/v1/photos/',
        data: formData,
        options: options,
      );
      if (response.statusCode == 201) {
        print('success');
        print(response.data);
        return (response.data);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print('error $e');
    }
  }

  Future<dynamic> deleteFiles(imageId) async {
    try {
      dynamic token = await LoginService.getToken();
      dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;
      final Dio service = Dio(BaseOptions(baseUrl: 'https://$baseurl1'));

      bool validateStatus(status) {
        return status! <= 500;
      }

      final options = Options(
          validateStatus: validateStatus,
          headers: {"Authorization": "Bearer $token", "source": "android"});

      final response = await service.delete(
        '/v1/photos/$imageId/',
        options: options,
      );
      if (response.statusCode == 201) {
        print('success');
        return (response.data);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print('error $e');
    }
  }

  Future<dynamic> createJobPost({
    dynamic priority,
    dynamic service_type,
    dynamic property,
    dynamic category,
    dynamic target_date,
    dynamic manager,
    dynamic description,
    dynamic access_instruction,
    List<dynamic>? photos,
    dynamic unitloc,
    dynamic engineers,
    dynamic issue_type,
  }) async {
    try {
      dynamic token = await LoginService.getToken();
      dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;
      final Dio service = Dio(BaseOptions(baseUrl: 'https://$baseurl1'));
      bool validateStatus(status) {
        return status! <= 500;
      }

      var data = {
        "service_type": service_type,
        "type": "Regular",
        "request_type": "In Unit",
        "property": property,
        "category": category,
        "target_date": target_date,
        "description": description,
        "access_instruction": access_instruction,
        "unit_entry_permission": false,
        "property_entry_permission": false,
        "skip_site_visit": false,
        "request_feedback_on_close": false,
        "request_auto_response": false,
        "skip_bid": false,
        "courtesy_job": false,
        "request_completion_photos": false,
        "_vendors": [],
        "followers": [],
        "engineers_required": false,
        "engineers": [engineers],
        "photos": photos,
        "pm_assignee": manager,
        "issue_type": issue_type,
        "priority": priority,
        "unit": unitloc,
      };
      final options = Options(
          validateStatus: validateStatus,
          headers: {"Authorization": "Bearer $token", "source": "android"});

      var response = await service.post(
        '/v1/jobs/',
        data: data,
        options: options,
      );

      if (response.statusCode == 201) {
        print('job Created');

        print(response.statusCode);
        return response.data;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print('e$e');
    }
  }

  Future<dynamic> uploadCreateJob(uploadFile) async {
    try {
      dynamic token = await LoginService.getToken();
      FormData formData = uploadFile;

      bool validateStatus(status) {
        return status! <= 500;
      }

      final options = Options(
          validateStatus: validateStatus,
          headers: {"Authorization": "Bearer $token", "source": "android"});

      final response = await service!.post(
        '',
        data: formData,
        options: options,
      );
      if (response.statusCode == 200) {
        print('success');
        return (response.data);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print('error $e');
    }
  }
}
