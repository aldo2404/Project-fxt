import 'package:flutter/material.dart';

Widget DashBoardBox(
    color, IconData icon, iconcolor, String text1, String text2) {
  return Container(
    decoration:
        BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
    child: Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: iconcolor, size: 40),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text1,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text2,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25)),
            ],
          ),
        ],
      ),
    ),
  );
}
