import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_project/authentication_bloc/auth.dart';
import 'package:fx_project/repository/repository.dart';
import 'package:fx_project/screens/loginpagecopy.dart';
//import 'package:fx_project/repositories/repositories.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

// class SimpleBlocObserver extends BlocObserver {
//   @override
//   void onEvent(Bloc bloc, Object? event) {
//     super.onEvent(bloc, event);
//     print(event);
//   }

//   @override
//   void onTransition(Bloc bloc, Transition transition) {
//     super.onTransition(bloc, transition);
//     print(transition);
//   }

//   @override
//   void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
//     super.onError(bloc, error, stackTrace);
//     print(error);
//   }
// }

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Hive.initFlutter();
  // Bloc.observer = SimpleBlocObserver();
  // final userRepositories = UserRepositories();

  runApp(
      // BlocProvider<AuthenticationBloc>(
      //   create: (context) {
      //     return AuthenticationBloc(userRepositories: userRepositories)
      //       ..add(AppStarted());
      //   },
      //   child: MyApp(),
      // ),
      const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //final userRepositories = UserRepositories();
    return MaterialApp(
      title: 'Nixon-fx',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: const SplashScreen(),
      // BlocBuilder<AuthenticationBloc, AuthenticationState>(
      //   builder: (context, state) {
      //     if (state is AuthenticationUninitialized) {
      //       return SplashScreen();
      //     }
      //     if (state is AuthenticationAuthenticated) {
      //       return const EnvironmentPage();
      //     }
      //     if (state is AuthenticationUnauthenticated) {
      //       return LoginBlocProviderPage(userRepositories: userRepositories);
      //     }
      //     if (state is AuthenticationLoading) {
      //       return const Scaffold(
      //         body: CircularProgressIndicator(),
      //       );
      //     }
      //     return const Scaffold(
      //       body: CircularProgressIndicator(),
      //     );
      //   },
      // ),
    );
  }
}

class Authentication extends StatelessWidget {
  const Authentication({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: ((context) => AuthBloc(LoginInitState(), AuthRepository())))
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPageCopy(),
        // routes: {
        //   '/': (context) => LoginView(),
        //   '/forgotScreen': (context) => ForgotScreen(),
        //   '/environmentScreen': (context) => EnvironmentScreen(),
        // },
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //final userRepositories = UserRepositories();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 3)).then((value) {
        FlutterNativeSplash.remove();
      });

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const Authentication())
          //  const MaterialPageRoutes()),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    //TODO: implement build
    //throw UnimplementedError();
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
