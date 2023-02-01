import 'package:flutter/material.dart';

class Buttonfield {
  Function()? onpressed;

  clickButton(String text, onpressed) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        //   height: 45,
        width: 300,
        child: ElevatedButton(
          // ignore: sort_child_properties_last
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              //fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.orange[900]),
              padding: const MaterialStatePropertyAll(
                  EdgeInsets.only(top: 10, bottom: 10))),
          onPressed: onpressed,
        ),
      ),
    );
  }
}
