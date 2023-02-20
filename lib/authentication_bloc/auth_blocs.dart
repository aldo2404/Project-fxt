// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:fx_project/repository/repository.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'auth.dart';

// class AuthBloc extends Bloc<AuthEvents, AuthState> {
//   AuthRepository repo;
//   AuthBloc(AuthState initialState, this.repo) : super(initialState);
//   @override
// //   on<LoginButtonPressed>((event,emit)async{
// // });
//   Stream<AuthState> mapEventToState(AuthEvents event) async* {
//     final storage = FlutterSecureStorage();
//     var pref = await SharedPreferences.getInstance();
//     if (event is StartEvent) {
//       yield LoginInitState();
//     } else if (event is LoginButtonPressed) {
//       yield LoginLogingState();
//       try {
//         final token = await AuthRepository().login(event.email, event.password);
//         await storage.write(key: 'token', value: token);
//         print(token);
//       } catch (error) {
//         // yield LoginErrorState(error: error.toString());
//       }
//       yield UserLoginSuccessState();
//     } else if (['types'] == 'Manager') {
//       yield AdminLoginSuccessState();
//     } else {
//       // yield LoginErrorState(message: 'auth err');
//     }
//   }
// }
