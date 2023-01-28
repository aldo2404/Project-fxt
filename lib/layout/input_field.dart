import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFields extends StatelessWidget {
  String text;
  Color inputfieldcolor;
  bool? password;
  bool autocorrect;
  TextEditingController? controller;
  final FormFieldValidator<String> validate;
  List<TextInputFormatter>? inputformatters;

  TextFields({
    Key? key,
    required this.text,
    required this.inputfieldcolor,
    this.controller,
    this.password,
    this.autocorrect = true,
    required this.validate,
    this.inputformatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: 300,
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: controller,
          obscureText: password!,
          inputFormatters: inputformatters,
          validator: validate,
          //enableSuggestions: password,
          autocorrect: autocorrect,
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
