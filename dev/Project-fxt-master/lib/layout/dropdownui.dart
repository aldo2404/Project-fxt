import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class DropDownUiScreen extends StatefulWidget {
  List<dynamic> listData;
  Widget? Function(BuildContext, int) itemBuilder;
  String? titleText;

  DropDownUiScreen(
      {required this.listData,
      required this.itemBuilder,
      this.titleText,
      super.key});

  @override
  State<DropDownUiScreen> createState() => _DropDownUiScreenState();
}

class _DropDownUiScreenState extends State<DropDownUiScreen> {
  final TextEditingController searchEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.13,
        maxChildSize: 0.9,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return FutureBuilder(
              //future: ,
              builder: (context, snapshot) {
            return Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListTile(
                      leading: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back_ios_new_sharp)),
                      title: Text(
                        widget.titleText!,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: searchEditingController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(31, 207, 200, 200),
                      contentPadding: EdgeInsets.only(
                          left: 5.0, top: 5.0, bottom: 5.0, right: 15.0),
                      hintText: "Search",
                      border: OutlineInputBorder(
                        gapPadding: 3,
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: widget.listData.length,
                    itemBuilder: widget.itemBuilder,
                    // (context, index) {
                    //   return Container(
                    //     decoration: const BoxDecoration(
                    //         border: Border(
                    //             bottom: BorderSide(color: Colors.black26))),
                    //     child: ListTile(
                    //       title: Text(widget.listData![index]['name'].toString()),
                    //       subtitle:
                    //           Text(widget.listData![index]['address'].toString()),
                    //       onTap: () {
                    //         setState(() {
                    //           dummyData =
                    //               widget.listData![index]['name'].toString();
                    //         });
                    //         Navigator.of(context).pop();
                    //       },
                    //     ),
                    //   );
                    // }
                  ),
                ),
              ],
            );
          });
        });
  }
}
