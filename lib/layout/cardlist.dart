import 'dart:js';

import 'package:flutter/material.dart';

Widget cardListContainer(
    String property,
    String serviceType,
    String id,
    //String text,
    String issueType,
    String priority,
    String unit,
    String category) {
  return Container(
      width: 340,
      height: 155,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide()), color: Colors.white),
      child: Column(
        children: [
          Column(
            children: [
              ListTile(
                title: Text(property),
                subtitle: Text('$serviceType - $id'),
                trailing: Container(
                  width: 90,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.blue)),
                  child: TextField(
                    decoration: InputDecoration(
                        //prefixText: text,
                        suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.keyboard_arrow_down_sharp)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6))),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Row(
              children: [
                Text(issueType, textAlign: TextAlign.start),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            'priority',
                            textAlign: TextAlign.left,
                          )
                        ]),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Text(
                        priority,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ])
                  ]),
                  Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [Text('Location')]),
                    Row(children: [
                      Text(
                        'Unit: $unit',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ])
                  ]),
                  Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [Text('Category')]),
                    Row(children: [
                      Text(
                        category,
                        style: TextStyle(fontWeight: FontWeight.w100),
                      )
                    ])
                  ]),
                ]),
          )
        ],
      ));
}
