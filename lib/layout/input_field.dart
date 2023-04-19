// ignore_for_file: must_be_immutable
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:fx_project/controller/deletedpage.dart';

class ReuseTextFields extends StatefulWidget {
  List<SelectedListItem>? data;
  final bool? isSearchVisible;
  Function(List<dynamic>)? selectedItems;
  Widget Function(int)? listBuilder;
  String hinttext;
  Color inputfieldcolor;
  bool? password;
  bool? readOnly;
  bool autocorrect;
  bool? showCursor;
  int maxLines;
  TextEditingController? controller;
  final FormFieldValidator? validate;
  TextInputType? keyboardtypes;
  Function(String?)? onsaved;
  Function()? onTap;
  Widget? suffixs;
  double? height;
  double? width;
  String? helperText;
  TextAlign? textAlign;
  String? labelText;

  ReuseTextFields({
    Key? key,
    this.data,
    this.listBuilder,
    this.isSearchVisible,
    this.selectedItems,
    required this.hinttext,
    required this.inputfieldcolor,
    this.controller,
    this.password,
    this.autocorrect = false,
    required this.maxLines,
    this.validate,
    this.readOnly,
    this.keyboardtypes,
    this.onsaved,
    this.onTap,
    this.suffixs,
    this.height,
    this.width,
    this.helperText,
    this.labelText,
    this.showCursor,
    required this.textAlign,
  }) : super(key: key);
  @override
  State<ReuseTextFields> createState() => ReuseTextFieldsState();
}

class ReuseTextFieldsState extends State<ReuseTextFields> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: TextFormField(
          keyboardType: widget.keyboardtypes,
          controller: widget.controller,
          obscureText: widget.password!,
          readOnly: widget.readOnly!,
          maxLines: widget.maxLines,
          validator: widget.validate,
          onSaved: widget.onsaved,
          autocorrect: widget.autocorrect,
          textAlign: widget.textAlign!,
          showCursor: widget.showCursor,
          onTap: widget.onTap,
          decoration: InputDecoration(
            isCollapsed: true,
            isDense: true,
            filled: true,
            fillColor: widget.inputfieldcolor,
            border: const OutlineInputBorder(),
            contentPadding:
                const EdgeInsets.only(bottom: 10, top: 10, left: 10),
            helperText: widget.helperText,
            hintTextDirection: TextDirection.ltr,
            labelText: widget.labelText,
            hintText: widget.hinttext,
            hintStyle: const TextStyle(fontSize: 14, color: Colors.black45),
            suffixIcon: widget.suffixs,
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
  // void onTextFieldTap() {
  //   print('datalist');
  //   DropDownState(DropDown(
  //     bottomSheetTitle: const Text(
  //       'Service Type',
  //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
  //     ),
  //     listBuilder: widget.listBuilder,
  //     data: widget.data ?? [],
  //     isSearchVisible: widget.isSearchVisible!,
  //     selectedItems: widget.selectedItems,
  //   )).showModal(context);
  // }

  // void onTextFieldList() {
  //   const DropDownListExample(
  //     key: Key("name"),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
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
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
