import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_project/layout/alertbox.dart';
import 'package:fx_project/layout/background_screen.dart';
import 'package:fx_project/layout/buttonfield.dart';

import '../controller/login_controller.dart';
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

  // LoginState? state;
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
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          )),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Align(
          //         alignment: Alignment(0.0, -0.7),
          //         child: Image.asset(
          //           "assets/image/splashlogo.png",
          //         )),
          //     Container(
          //       // height: 100,
          //       // width: 110,
          //       child: Image.asset(
          //         "assets/image/splashlogo.png",
          //         // fit: BoxFit.fitWidth,
          //       ),
          //     ),
          //   ],
          // ),
          Center(
            child: BlocConsumer<LoginCubit, LoginState>(
              listener: buildBlocListener,
              builder: (context, state) {
                return Form(
                  key: formfield,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        "Forgot Password?",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 17),
                      const SizedBox(
                        width: 300,
                        child: Text(
                          "Enter your email and we'll send you a link to reset your password",
                          style: TextStyle(
                            color: Colors.white38,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 48),
                      ReuseTextFields(
                        keyboardtypes: TextInputType.emailAddress,
                        text: "Email",
                        inputfieldcolor: Colors.white,
                        password: false,
                        controller: emailcontroller,
                        validate: ((value) {
                          if (value!.isEmpty ||
                              !RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2}")
                                  .hasMatch(value)) {
                            return 'Enter correct email id';
                          }
                          return null;
                        }),
                        // onsaved: (value) {
                        //   mail = value!;
                        // },
                      ),
                      GestureDetector(
                        // onTap: () {
                        //   setState(() {});
                        // },
                        child: Buttonfield().clickButton(
                          context,
                          state,
                          "submit",
                          () {},
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void buildBlocListener(context, state) {
  if (state is LoginCompleted) {
    final data = state.loginModel;
    if (data.error != null) {
      ReuseAlertDialogBox()
          .alertDialog(context, "Alert", "please enter valid data");
    } else {
      ReuseAlertDialogBox().alertDialog(context, "_", "Login Success");
    }
  }
}
