import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_project/controller/login_controller.dart';
import 'package:fx_project/layout/alertbox.dart';
import 'package:fx_project/layout/background_screen.dart';
import 'package:fx_project/layout/buttonfield.dart';
import 'package:fx_project/layout/environment_box.dart';

class EnvironmentPage extends StatefulWidget {
  const EnvironmentPage({super.key});

  @override
  State<EnvironmentPage> createState() => _EnvironmentPageState();
}

class _EnvironmentPageState extends State<EnvironmentPage> {
  //late LoginState state;

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
            ),
          ),
          Center(
            child: BlocConsumer<LoginCubit, LoginState>(
              listener: buildBlocListener,
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Environment",
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(
                      width: 300,
                      child: Text(
                        "Choose which environment you want to enter",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 300,
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          EnvironmentBox().environmentBox("hello"),
                          const SizedBox(width: 20),
                          EnvironmentBox().environmentBox("hello"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    //Buttonfield().
                    clickButton(
                      "Enter",
                      () {},
                    ),
                  ],
                );
              },
            ),
          )
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
