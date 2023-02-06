import 'package:flutter/material.dart';
import 'package:fx_project/layout/background_screen.dart';
import 'package:fx_project/layout/buttonfield.dart';
import 'package:fx_project/layout/environment_box.dart';

class EnvironmentPage extends StatefulWidget {
  const EnvironmentPage({super.key});

  @override
  State<EnvironmentPage> createState() => _EnvironmentPageState();
}

class _EnvironmentPageState extends State<EnvironmentPage> {
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
            ),
          ),
          Center(
            child: Column(
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
                SizedBox(height: 10),
                Container(
                  width: 300,
                  child: const Text(
                    "Choose which environment you want to enter",
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 300,
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      EnvironmentBox().environmentBox("hello"),
                      SizedBox(width: 20),
                      EnvironmentBox().environmentBox("hello"),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Buttonfield().clickButton(
                  "Enter",
                  () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
