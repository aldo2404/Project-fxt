import 'package:flutter/material.dart';
import 'package:fx_project/layout/dashboardbox.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 48, 92),
        leading: Image.asset('assets/image/splashlogo.png'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.power_settings_new, color: Colors.orange[900]))
        ],
      ),
      body: ListView(children: [
        Stack(
          children: [DashBoardBox(Colors.amber[200])],
        ),
      ]),
    );
  }
}
