import 'package:flutter/material.dart';

class TextFields {
  inputLine(String text, Color inputfieldcolor,
      [bool? password, TextEditingController? controller]) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 40,
        width: 300,
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: controller,
          obscureText: password!,
          enableSuggestions: password,
          autocorrect: password,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              filled: true,
              fillColor: inputfieldcolor,
              border: OutlineInputBorder(),
              hintText: text,
              hintStyle: TextStyle(fontSize: 14)),
        ),
      ),
    );
  }
}
