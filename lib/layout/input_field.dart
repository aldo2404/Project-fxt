import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReuseTextFields extends StatelessWidget {
  String text;
  Color inputfieldcolor;
  bool? password;
  bool autocorrect;
  TextEditingController? controller;
  final FormFieldValidator<String> validate;
  List<TextInputFormatter>? inputformatters;
  TextInputType keyboardtypes;
  Function(String?)? onsaved;

  ReuseTextFields({
    Key? key,
    required this.text,
    required this.inputfieldcolor,
    this.controller,
    this.password,
    this.autocorrect = true,
    required this.validate,
    this.inputformatters,
    required this.keyboardtypes,
    this.onsaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Container(
        width: 300,
        child: TextFormField(
          keyboardType: keyboardtypes,
          controller: controller,
          obscureText: password!,
          inputFormatters: inputformatters,
          validator: validate,
          //enableSuggestions: password,
          onSaved: onsaved,
          autocorrect: autocorrect,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              filled: true,
              fillColor: inputfieldcolor,
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 4),
              helperText: '',
              hintText: text,
              hintStyle: TextStyle(fontSize: 14)),
        ),
      ),
    );
  }
}
