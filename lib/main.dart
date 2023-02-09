import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:fx_project/blocpattern/auth_bloc/auth.dart';
import 'package:fx_project/screens/environmentpage.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_project/repositories/repositories.dart';
import 'package:fx_project/screens/loginpage.dart';
// import 'package:fx_project/screens/materialpage_route.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print(error);
  }
}

void main() async {
  await Hive.initFlutter();
  //BlocSupervisor().Observer = SimpleBlocObserver();
  final userRepositories = UserRepositories();

  runApp(
    BlocProvider(
      create: (context) {
        return AuthenticationBloc(userRepositories: userRepositories)
          ..add(AppStarted());
      },
      child: MyApp(userRepositories: userRepositories),
    ),
  );
}

class MyApp extends StatelessWidget {
  final UserRepositories userRepositories;
  MyApp({Key? key, required this.userRepositories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nixon-fx',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            return const EnvironmentPage();
          }
          if (state is AuthenticationUnauthenticated) {
            return SplashScreen(userRepositories: userRepositories);
          }
          if (state is AuthenticationLoading) {
            return const Scaffold(
              body: CircularProgressIndicator(),
            );
          }
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  final UserRepositories userRepositories;
  const SplashScreen({super.key, required this.userRepositories})
      : assert(userRepositories != null);

  @override
  State<SplashScreen> createState() => _SplashScreenState(userRepositories);
}

class _SplashScreenState extends State<SplashScreen> {
  final UserRepositories userRepositories;
  _SplashScreenState(this.userRepositories);
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  LoginPage(userRepositories: userRepositories)),
          //  const MaterialPageRoutes()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/background.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Image.asset(
        "assets/image/splashlogo.png",
        scale: 0.6,
      ),
    );
  }
}
