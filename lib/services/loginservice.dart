// import 'package:dio/dio.dart';
// import 'package:fx_project/authentication/loginmodels.dart';

// class LoginService {
//   final Dio service;
//   LoginService({required this.service});

//   Future<LoginResponseModel?> loginService(loginModel) async {
//     final data = {
//       'email': loginModel.email,
//       'password': loginModel.password,
//     };

//     bool validateStatus(status) {
//       return status! <= 500;
//     }

//     final options = Options(validateStatus: validateStatus);

//     final response = await service.post(
//       '/v1/login/',
//       options: options,
//       data: data,
//     );

//     return LoginResponseModel.fromJson(response.data);
//   }
// }
