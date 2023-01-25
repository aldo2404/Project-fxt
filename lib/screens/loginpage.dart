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
  final formfield = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          BackGroundImg().Images(),
          SizedBox(height: 25),
          Center(
            child: Form(
                key: formfield,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 110,
                      width: 99,
                      child: Image.asset(
                        "assets/image/splashlogo.png",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Container(
                      child: Text("Welcome back!",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                    ),
                    SizedBox(height: 20),
                    TextFields().inputLine(
                      "Username",
                      Colors.white,
                      false,
                      emailcontroller,
                    ),
                    SizedBox(height: 17),
                    TextFields().inputLine(
                        "Password", Colors.white, true, passcontroller),
                    //SizedBox(height: 17),
                    Container(
                        height: 40,
                        width: 300,
                        child: GestureDetector(
                          child: Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                side: BorderSide(width: 2, color: Colors.white),
                                value: _isChecked,
                                onChanged: (value) => setState(() {
                                  _isChecked = !value!;
                                }),
                              ),
                              Text(
                                "Remember me",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          onTap: () => setState(() {
                            _isChecked = !_isChecked;
                          }),
                        )),
                    GestureDetector(
                      onTap: () {},
                      child: Buttonfield().clickButton("Log In"),
                    ),
                    SizedBox(height: 17),
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
                    SizedBox(height: 130),
                    Container(
                      height: 40,
                      width: 300,
                      child: GestureDetector(
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
