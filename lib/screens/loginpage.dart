import 'package:flutter/material.dart';
import 'package:fx_project/layout/buttonfield.dart';
import 'package:fx_project/layout/input_field.dart';

import '../layout/background_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            BackGroundImg().Images(),
            SizedBox(
              height: 17,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("Welcome back!",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFields().inputLine("Username", Colors.white),
                  SizedBox(
                    height: 17,
                  ),
                  TextFields().inputLine("Password", Colors.white),
                  SizedBox(
                    height: 17,
                  ),
                  Container(
                    height: 40,
                    width: 300,
                    child: Text(
                      "Remeber me",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Buttonfield().clickButton("Log In"),
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  Container(
                    height: 40,
                    width: 300,
                    child: Text(
                      "or",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Buttonfield().clickButton("Log In with SSO"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
