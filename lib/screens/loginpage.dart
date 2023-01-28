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
  late String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          BackGroundImg().Images(),
          Center(
            heightFactor: MediaQuery.of(context).size.width,
            child: Form(
              key: formfield,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 65),
                  Container(
                    height: 100,
                    width: 110,
                    child: Image.asset(
                      "assets/image/splashlogo.png",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  const Text("Welcome back!",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                  SizedBox(height: 20),
                  ReuseTextFields(
                    keyboardtypes: TextInputType.emailAddress,
                    text: "Username",
                    inputfieldcolor: Colors.white,
                    password: false,
                    controller: emailcontroller,
                    validate: ((value) {
                      if (value!.isEmpty) {
                        return "Enter the mail id";
                      } else if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]")
                          .hasMatch(value)) {
                        return "Enter valid email";
                      }
                      return null;
                    }),
                    onsaved: (value) {
                      email = value!;
                    },
                  ),

                  ReuseTextFields(
                    keyboardtypes: TextInputType.visiblePassword,
                    text: "Password",
                    inputfieldcolor: Colors.white,
                    password: true,
                    controller: passcontroller,
                    validate: ((value) {
                      if (value!.isEmpty) {
                        return "required *";
                      } else if (value.length < 6) {
                        return 'password length too short';
                      } else if (value.length > 15) {
                        return "password length too long";
                      } else {
                        return null;
                      }
                    }),
                  ),

                  SizedBox(
                    height: 35,
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
                          const Text(
                            "Remember me",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      onTap: () => setState(() {
                        _isChecked = !_isChecked;
                      }),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (formfield.currentState!.validate()) {}
                      });
                    },
                    child: Buttonfield().clickButton(
                      "Log In",
                    ),
                  ),
                  //SizedBox(height: 13),
                  const SizedBox(
                    height: 25,
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
                  const SizedBox(height: 120),
                  SizedBox(
                    height: 40,
                    width: 300,
                    child: GestureDetector(
                      onTap: (() {
                        setState(() {
                          Navigator.of(context)
                              .pushNamed('/passwordforgotpage');
                        });
                      }),
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
