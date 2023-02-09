// // ignore_for_file: avoid_print

// import 'dart:convert';
// import 'package:http/http.dart';

// class LoginAuthentication {
//   Future getres(String email, password) async {
//     try {
//       Response response = await post(
//           Uri.parse('https://qaapifyxt.com/v1/login/'),
//           body: {"email": email, "password": password});
//       print(response.statusCode);

//       var data = jsonDecode(response.body.toString());
//       print(data);
//       if (response.statusCode == 200) {
//         print('authentication success');
//       } else {
//         print('failed');
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }
