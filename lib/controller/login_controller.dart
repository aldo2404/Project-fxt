import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fx_project/models/login_model.dart';
import 'package:fx_project/models/login_response_model.dart';
import 'package:fx_project/services/loginservice.dart';
part 'State/login_state_git.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.service}) : super(const LoginInitial());

  LoginService service;

  Future<void> onPressedLogin(TextEditingController emailcontroller,
      TextEditingController passcontroller) async {
    emit(LoginLoading());

    final model = LoginModel(
      email: emailcontroller.text,
      password: passcontroller.text,
    );

    final response = await service.loginService(model);

    print(json.encode(response));

    if (response is LoginResponseModel) {
      emit(LoginCompleted(response));
    } else {
      // emit(LoginError('Error'));
      emit(LoginInitial());
    }
  }
}
