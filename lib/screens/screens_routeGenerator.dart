// // ignore: file_names
// // ignore_for_file: prefer_const_constructors, file_names, duplicate_ignore

// import 'package:flutter/material.dart';
// import 'package:fx_project/repositories/repositories.dart';
// import 'package:fx_project/screens/environmentpage.dart';
// import 'package:fx_project/screens/forgotpasspage.dart';
// import 'package:fx_project/screens/loginpage.dart';

// class ScreenRouteGenerator {
//   late final userRepositories = UserRepositories();
//   static Route<dynamic> routeGenerator(RouteSettings settings) {
//     settings.arguments;

//     switch (settings.name) {
//       case '/loginpage':
//         return MaterialPageRoute(
//             builder: (_) => LoginPage(userRepositories: userRepositories));
//       case '/passwordforgotpage':
//         return MaterialPageRoute(builder: (_) => PasswordForgotPage());
//       case '/environmentpage':
//         return MaterialPageRoute(builder: (_) => EnvironmentPage());
//       default:
//         return MaterialPageRoute(
//             builder: (_) => LoginPage(userRepositories: userRepositories));
//     }
//   }
// }
