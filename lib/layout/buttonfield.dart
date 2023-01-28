import 'package:flutter/material.dart';

class Buttonfield {
  clickButton(String text) {
    return SizedBox(
      height: 45,
      width: 300,
      // margin: const EdgeInsets.all(8),
      // padding: const EdgeInsets.all(6),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(3),
      //   // color: Colors.orange[900],
      // ),
      child: ElevatedButton(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.orange[900])),
        onPressed: (() {}),
      ),
    );
  }
}
