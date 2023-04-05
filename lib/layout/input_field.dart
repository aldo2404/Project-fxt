// ignore_for_file: must_be_immutable
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';

class ReuseTextFields extends StatefulWidget {
  List<SelectedListItem>? data;
  final bool? isSearchVisible;
  Function(List<dynamic>)? selectedItems;
  String text;
  Color inputfieldcolor;
  bool? password;
  bool? readOnly;
  bool autocorrect;
  int maxLines;
  final bool? isListSelect;
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

  ReuseTextFields({
    Key? key,
    this.data,
    this.isSearchVisible,
    this.selectedItems,
    required this.text,
    required this.inputfieldcolor,
    this.controller,
    this.password,
    this.isListSelect,
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
    required this.textAlign,
  }) : super(key: key);
  @override
  State<ReuseTextFields> createState() => ReuseTextFieldsState();
}

class ReuseTextFieldsState extends State<ReuseTextFields> {
  void onTextFieldTap() {
    print('datalist');
    DropDownState(DropDown(
      bottomSheetTitle: const Text(
        'Service Type',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      data: widget.data ?? [],
      isSearchVisible: widget.isSearchVisible!,
      selectedItems: (List<dynamic> selectedList) {
        for (var itemList in selectedList) {
          if (itemList is SelectedListItem) {
            print("name- ${itemList.name}");
            return Text(itemList.name);
          }
        }
      },
    )).showModal(context);
  }

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
          onTap: widget.isListSelect!
              ? () {
                  FocusScope.of(context).unfocus();
                  onTextFieldTap();
                }
              : null,
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
            hintText: widget.text,
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
