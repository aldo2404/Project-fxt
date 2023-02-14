import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_project/blocpattern/auth_bloc/auth.dart';
import 'package:fx_project/blocpattern/login_bloc/login_bloc.dart';
import 'package:fx_project/repositories/repositories.dart';
import 'package:fx_project/screens/loginpage.dart';

class LoginBlocProviderPage extends StatelessWidget {
  final UserRepositories userRepositories;
  const LoginBlocProviderPage({super.key, required this.userRepositories})
      : assert(userRepositories != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
              userRepositories: userRepositories);
        },
        child: LoginPage(userRepositories: userRepositories),
      ),
    );
  }
}
