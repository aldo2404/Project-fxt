// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ReuseTextFields extends StatelessWidget {
  String text;
  Color inputfieldcolor;
  bool? password;
  bool? readOnly;
  bool autocorrect;
  int maxLines;
  TextEditingController? controller;
  final FormFieldValidator? validate;
  TextInputType? keyboardtypes;
  Function(String?)? onsaved;
  Widget? suffixs;
  double? height;
  double? width;
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
    this.keyboardtypes,
    this.onsaved,
    this.suffixs,
    this.height,
    this.width,
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
          validator: validate,
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
            helperText: helperText,
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

class SelectionOptionField extends StatelessWidget {
  final List<DropdownMenuItem<String>>? items;
  Function(String?) onChange;

  SelectionOptionField({
    super.key,
    required this.items,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: DropdownButtonFormField(
        items: items,
        onChanged: onChange,
        hint: const Text("select"),
        icon: const Icon(
          Icons.keyboard_arrow_down_sharp,
          size: 24,
        ),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        borderRadius: BorderRadius.circular(7),
      ),
    );
  }
}
