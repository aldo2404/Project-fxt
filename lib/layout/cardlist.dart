import 'package:flutter/material.dart';

Widget cardListContainer() {
  return Container(
    padding: const EdgeInsets.all(10),
    child: Row(children: [
      Row(children: [
        Column(children: [
          ListTile(
            title: Text('name'),
            subtitle: Text('data1'),
            trailing: Container(
              padding: EdgeInsets.only(right: 10),
              width: 80,
              height: 40,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: TextField(
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
          ),
          // Row(children: const [Text('name')]),
          // const SizedBox(height: 15),
          // Row(children: const [Text('data1')]),
        ]),
        // Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        //   Container(
        //     padding: EdgeInsets.only(right: 10),
        //     width: 80,
        //     height: 40,
        //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        //     child: TextField(
        //       decoration: InputDecoration(
        //           suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
        //           border: OutlineInputBorder(
        //               borderRadius: BorderRadius.circular(10))),
        //     ),
        //   )
        // ])
      ]),
      const SizedBox(height: 15),
      Row(children: const [Text('second name')]),
      const SizedBox(height: 15),
      Row(children: [
        Column(children: [
          Row(children: const [Text('priority')]),
          Row(children: const [Text('p-data1')])
        ]),
        Column(children: [
          Row(children: const [Text('location')]),
          Row(children: const [Text('Loc-data1')])
        ]),
        Column(children: [
          Row(children: const [Text('Category')]),
          Row(children: const [Text('Cat-data')])
        ]),
      ]),
    ]),
  );
}
