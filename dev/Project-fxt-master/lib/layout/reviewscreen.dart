import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ReviewScreen extends StatelessWidget {
  String? titleText;
  String? editableText;
  Function()? onPressed;
  bool iconVisiable;

  ReviewScreen(
      {this.editableText,
      this.titleText,
      this.onPressed,
      required this.iconVisiable,
      super.key});
  @override
  Widget build(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          child: Text(
            titleText!,
            style: const TextStyle(fontSize: 12),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 90,
              child: Text(
                editableText!,
                overflow: TextOverflow.clip,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SizedBox(
          child: iconVisiable
              ? IconButton(
                  icon: const Icon(
                    Icons.mode_edit_outline,
                    size: 18,
                  ),
                  onPressed: onPressed,
                )
              : Container(
                  width: 25,
                  padding: const EdgeInsets.all(18),
                ),
        )
      ],
    );
  }
}
