import 'package:flutter/material.dart';

class BackGroundImg {
  Images() {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/background.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Align(
            alignment: Alignment(0.0, -0.7),
            child: Image.asset(
              "assets/image/splashlogo.png",
            )),
      ],
    );
  }
}
