import 'package:flutter/material.dart';

Widget DashBoardBox(color) {
  return Container(
    width: 100,
    height: 180,
    color: color,
    child: Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("data"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("data1"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("data2"),
            ],
          ),
        ],
      ),
    ),
  );
}
