import 'package:flutter/material.dart';

class TextFields {
  inputLine(String text, Color inputfieldcolor) {
    return Container(
      height: 40,
      width: 300,
      // margin: EdgeInsets.all(8),
      // padding: EdgeInsets.all(5),

      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(5.0),
      // ),

      // color: Colors.white,
      child: TextField(
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            filled: true,
            fillColor: inputfieldcolor,
            border: OutlineInputBorder(),
            hintText: text,
            hintStyle: TextStyle(fontSize: 14)),
      ),
    );
  }
}
