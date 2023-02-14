import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReuseTextFields extends StatelessWidget {
  String text;
  Color inputfieldcolor;
  bool? password;
  bool autocorrect;
  TextEditingController? controller;
  final FormFieldValidator? validate;
  List<TextInputFormatter>? inputformatters;
  TextInputType keyboardtypes;
  Function(String?)? onsaved;
  Widget? suffixs;

  ReuseTextFields({
    Key? key,
    required this.text,
    required this.inputfieldcolor,
    this.controller,
    this.password,
    this.autocorrect = false,
    this.validate,
    this.inputformatters,
    required this.keyboardtypes,
    this.onsaved,
    this.suffixs,
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
            isCollapsed: true,
            isDense: true,
            filled: true,
            fillColor: inputfieldcolor,
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.only(bottom: 10, top: 10),
            helperText: '',
            hintText: text,
            hintStyle: const TextStyle(fontSize: 14, color: Colors.black45),
            suffix: suffixs,
          ),
        ),
      ),
    );
  }
}
