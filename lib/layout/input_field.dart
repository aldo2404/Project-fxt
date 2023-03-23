import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class ReuseTextFields extends StatelessWidget {
  String text;
  Color inputfieldcolor;
  bool? password;
  bool? readOnly;
  bool autocorrect;
  int maxLines;
  TextEditingController? controller;
  final FormFieldValidator? validate;
  //List<TextInputFormatter>? inputformatters;
  TextInputType? keyboardtypes;
  Function(String?)? onsaved;
  Widget? suffixs;
  double? height;
  double width;
  String? helperText;
  TextAlign? textAlign;

  ReuseTextFields({
    Key? key,
    required this.text,
    required this.inputfieldcolor,
    this.controller,
    this.password,
    this.autocorrect = false,
    required this.maxLines,
    this.validate,
    this.readOnly,
    //this.inputformatters,
    this.keyboardtypes,
    this.onsaved,
    this.suffixs,
    this.height,
    required this.width,
    this.helperText,
    required this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: SizedBox(
        width: width,
        height: height,
        child: TextFormField(
          keyboardType: keyboardtypes,
          controller: controller,
          obscureText: password!,
          readOnly: readOnly!,
          maxLines: maxLines,
          // textDirection: TextDirection.ltr,
          //inputFormatters: inputformatters,
          validator: validate,
          //enableSuggestions: password,
          onSaved: onsaved,
          autocorrect: autocorrect,
          textAlign: textAlign!,
          decoration: InputDecoration(
            isCollapsed: true,
            isDense: true,
            filled: true,
            fillColor: inputfieldcolor,
            border: const OutlineInputBorder(),
            contentPadding:
                const EdgeInsets.only(bottom: 10, top: 10, left: 10),
            helperText: '',
            hintTextDirection: TextDirection.ltr,
            hintText: text,
            hintStyle: const TextStyle(fontSize: 14, color: Colors.black45),
            suffix: suffixs,
          ),
        ),
      ),
    );
  }
}
