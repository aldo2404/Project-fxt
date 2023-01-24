import 'package:flutter/material.dart';
import 'package:fx_project/screens/screens_routeGenerator.dart';

void main() {
  runApp(MaterialPage_Route());
}

class MaterialPage_Route extends StatelessWidget {
  const MaterialPage_Route({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: ScreenRouteGenerator.routeGenerator,
    );
  }
}
