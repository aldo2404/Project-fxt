// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class PhotoButton extends StatelessWidget {
  Function()? onPressed;
  IconData? icon;
  String? buttonName;
  PhotoButton({
    super.key,
    this.onPressed,
    this.buttonName,
    this.icon,
  });
  @override
  Widget build(context) {
    return SizedBox(
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 1, 30, 54))),
        onPressed: onPressed,
        child: Row(
          children: [
            const SizedBox(width: 8),
            Icon(
              icon,
              size: 22,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Text(
              buttonName!,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
