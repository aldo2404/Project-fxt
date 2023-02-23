import 'package:flutter/material.dart';

Widget clickButton(onpressed, {required child}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: Container(
      width: 300,
      child: ElevatedButton(
        child: child,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.orange[900]),
            padding: const MaterialStatePropertyAll(
                EdgeInsets.only(top: 10, bottom: 10))),
        onPressed: onpressed,
      ),
    ),
  );
}
