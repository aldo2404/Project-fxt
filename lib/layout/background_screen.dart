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
        const SizedBox(
          height: 30,
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Container(
        //       height: 210,
        //       width: 99,
        //       child: Image.asset(
        //         "assets/image/splashlogo.png",
        //         fit: BoxFit.fitWidth,
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
