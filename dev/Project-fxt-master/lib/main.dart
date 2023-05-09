import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fx_project/screens/loginpage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

//import 'dart:js';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Hive.initFlutter();

  WidgetsFlutterBinding.ensureInitialized();
  // final cameras = await availableCameras();
  // final firstCamera = cameras.first;

  runApp(const MyApp());
}

//My App class......
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 3)).then((value) {
        FlutterNativeSplash.remove();
      });
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => const LoginPage())
      //     //  const MaterialPageRoutes()),
      //     );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nixon-fx',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: const LoginPage(),
    );
  }
}





// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Nixon-fx',
//       debugShowCheckedModeBanner: false,
//       darkTheme: ThemeData(brightness: Brightness.dark),
//       home: const SplashScreen(),
//     );
//   }
// }

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       Future.delayed(const Duration(seconds: 3)).then((value) {
//         FlutterNativeSplash.remove();
//       });
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => const LoginPage())
//           //  const MaterialPageRoutes()),
//           );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     throw UnimplementedError();
//   }
// }
