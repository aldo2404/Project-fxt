import 'package:flutter/material.dart';
import 'package:fx_project/layout/background_screen.dart';
import 'package:fx_project/layout/bottomnavigation.dart';
import 'package:fx_project/layout/buttonfield.dart';
import 'package:fx_project/layout/environment_box.dart';
import 'package:fx_project/models/login_response_model.dart';

class EnvironmentPage extends StatefulWidget {
  final List<DomainModel> domains;
  const EnvironmentPage({super.key, required this.domains});

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
                icon: const Icon(
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
                SingleChildScrollView(
                  child: Container(
                    width: 300,
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        environmentBox("hello"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                //Buttonfield().
                clickButton(
                  child: const Text("submit"),
                  () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (_) => const BottomNaviBar()));
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
