import 'package:flutter/material.dart';
import 'package:fx_project/layout/buttonfield.dart';
import 'package:fx_project/layout/input_field.dart';

class CreateJobsScreen extends StatefulWidget {
  const CreateJobsScreen({super.key});

  @override
  State<CreateJobsScreen> createState() => _CreateJobsScreenState();
}

class _CreateJobsScreenState extends State<CreateJobsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 48, 92),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_sharp)),
        centerTitle: true,
        title: const Text("Create Jobs"),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                "cancel",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: SafeArea(
          maintainBottomViewPadding: true,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [Text("1----2----3")],
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(4.0),
                child: Align(
                  //alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Service*",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      // Container(
                      //   width: 333,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(5),
                      //     border: Border.all(color: Colors.black),
                      //   ),
                      //   child: TextField(
                      //     decoration: InputDecoration(
                      //       hintText: "select",
                      //       filled: true,
                      //       contentPadding: const EdgeInsets.only(
                      //           top: 6, bottom: 6, left: 10),
                      //     ),
                      //   ),
                      // ),
                      ReuseTextFields(
                        width: 333,
                        textAlign: TextAlign.left,
                        text: "select",
                        inputfieldcolor: Colors.white,
                        password: false,
                        readOnly: false,
                        maxLines: 1,
                      ),

                      const Text("Property*",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      // Container(
                      //   width: 333,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(5),
                      //     border: Border.all(color: Colors.black),
                      //   ),
                      //   child: TextField(
                      //     //textInputAction: AboutDialog,
                      //     decoration: InputDecoration(
                      //       hintText: "select",
                      //       contentPadding: const EdgeInsets.only(
                      //           top: 6, bottom: 6, left: 10),
                      //     ),
                      //   ),
                      // ),
                      ReuseTextFields(
                        width: 333,
                        textAlign: TextAlign.left,
                        text: "select",
                        inputfieldcolor: Colors.white,
                        password: false,
                        readOnly: false,
                        maxLines: 1,
                      ),

                      const Text("Location*",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      // Container(
                      //   width: 333,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(5),
                      //     border: Border.all(color: Colors.black),
                      //   ),
                      //   child: TextField(
                      //     decoration: InputDecoration(
                      //       hintText: "select",
                      //       contentPadding: const EdgeInsets.only(
                      //           top: 6, bottom: 6, left: 10),
                      //       suffixIcon: IconButton(
                      //           onPressed: () {},
                      //           icon: const Icon(
                      //               Icons.keyboard_arrow_down_sharp)),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 10),
                      ReuseTextFields(
                        width: 333,
                        textAlign: TextAlign.left,
                        text: "select",
                        inputfieldcolor: Colors.white,
                        password: false,
                        readOnly: false,
                        maxLines: 1,
                      ),

                      const Text("Brief Description",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),

                      ReuseTextFields(
                        width: 333,
                        textAlign: TextAlign.left,
                        text: "Description",
                        inputfieldcolor: Colors.white,
                        maxLines: 4,
                        password: false,
                        readOnly: false,
                      ),

                      const Text("Detailed Description",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none)),
                      const SizedBox(height: 10),

                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: ReuseTextFields(
                          width: 333,
                          textAlign: TextAlign.left,
                          text: "Description",
                          inputfieldcolor: Colors.white,
                          maxLines: 4,
                          password: false,
                          readOnly: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: clickButton(
                  () {},
                  child: const Text("Next"),
                ),
              )
            ],
          )),
    );
  }
}
