import 'package:flutter/material.dart';

Widget environmentBox(String text) {
  return Container(
    //height: 120,
    width: 200,
    padding: const EdgeInsets.all(50),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
