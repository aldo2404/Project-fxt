import 'dart:js';

import 'package:flutter/material.dart';

class Buttonfield {
  clickButton(String text) {
    return Container(
      height: 40,
      width: 300,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: Colors.orange[900],
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
    );
    // ignore: dead_code
    // AlertDialog(

    //   content: Text(
    //       'please enter email'),
    //   actions: [
    //     FlatButton(

    //       textColor: Colors.blue,
    //       onPressed:
    //           () {},
    //       child: Text('ok'),
    //     ),
    //   ],
    // );
  }
}
