import 'package:flutter/material.dart';
import 'package:fx_project/layout/background_screen.dart';
import 'package:fx_project/layout/buttonfield.dart';

import '../layout/input_field.dart';

class PasswordForgotPage extends StatefulWidget {
  const PasswordForgotPage({super.key});

  @override
  State<PasswordForgotPage> createState() => _PasswordForgotPageState();
}

class _PasswordForgotPageState extends State<PasswordForgotPage> {
  final formfield = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  late String mail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          BackGroundImg().Images(),
          Positioned(
              child: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          )),
          Center(
            child: Form(
              key: formfield,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    width: 110,
                    child: Image.asset(
                      "assets/image/splashlogo.png",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  SizedBox(height: 155),
                  const Text(
                    "Forgot Password?",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  SizedBox(height: 17),
                  const Text(
                    "Enter your email and we'll send you a link to reset your \npassword",
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 48),
                  ReuseTextFields(
                    keyboardtypes: TextInputType.emailAddress,
                    text: "Email",
                    inputfieldcolor: Colors.white,
                    password: false,
                    controller: emailcontroller,
                    validate: ((value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]")
                              .hasMatch(value)) {
                        return 'Enter correct email id';
                      }
                      return null;
                    }),
                    onsaved: (value) {
                      mail = value!;
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {});
                    },
                    child: Buttonfield().clickButton("submit"),
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
