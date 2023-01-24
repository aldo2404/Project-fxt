import 'package:flutter/material.dart';

class Buttonfield {
  clickButton(String text) {
    return Container(
      height: 40,
      width: 300,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: Colors.orange[900],
      ),
      // color: Colors.orange[900],
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
