import 'package:flutter/material.dart';
import 'package:fx_project/layout/buttonfield.dart';
import 'package:fx_project/layout/input_field.dart';

class CreateJobsScreen extends StatefulWidget {
  const CreateJobsScreen({super.key});

  @override
  State<CreateJobsScreen> createState() => _CreateJobsScreenState();
}

class _CreateJobsScreenState extends State<CreateJobsScreen> {
  MyFormState() {
    selectItem = serviceTypeList[0];
  }

  int currentStep = 0;

  final serviceTypeList = [
    "Repair",
    "Service",
    "Inspection",
    "Other",
    "Preventive",
    "Replacement"
  ];
  String selectItem = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 48, 92),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_sharp)),
        centerTitle: true,
        title: const Text("Create Jobs Request"),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                "cancel",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Stepper(
        type: StepperType.horizontal,
        steps: getSteps(),
        currentStep: currentStep,
        onStepContinue: () {
          final isLastStep = currentStep == getSteps().length - 1;
          if (isLastStep) {
            print('Steps Completed');
          } else {
            setState(() => currentStep += 1);
          }
        },
        onStepCancel:
            currentStep == 0 ? null : () => setState(() => currentStep -= 1),
      ),
      // SafeArea(
      //     maintainBottomViewPadding: true,
      //     child:
      // ),
    );
  }

  List<Step> getSteps() => [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 0,
            title: const Text('1st step'),
            content: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Service*",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      //const SizedBox(height: 10),
                      SelectionOptionField(
                        items: serviceTypeList
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChange: (value) {
                          setState(() {
                            selectItem = value as String;
                          });
                        },
                      ),

                      const Text("Property*",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.bold)),

                      SelectionOptionField(
                        items: serviceTypeList
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChange: (value) {
                          setState(() {
                            selectItem = value as String;
                          });
                        },
                      ),
                      const Text("Location*",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.bold)),

                      SelectionOptionField(
                        items: serviceTypeList
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChange: (value) {
                          setState(() {
                            selectItem = value as String;
                          });
                        },
                      ),
                      const Text("Brief Description",
                          style: TextStyle(fontWeight: FontWeight.bold)),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ReuseTextFields(
                          textAlign: TextAlign.left,
                          text: "Description",
                          inputfieldcolor: Colors.white,
                          maxLines: 4,
                          password: false,
                          readOnly: false,
                        ),
                      ),

                      const Text("Detailed Description",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none)),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ReuseTextFields(
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: clickButton(
                      () {},
                      child: const Text("Next"),
                    ),
                  ),
                )
              ],
            )),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text('2st step'),
          content: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Service*",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                //const SizedBox(height: 10),
                SelectionOptionField(
                  items: serviceTypeList
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChange: (value) {
                    setState(() {
                      selectItem = value as String;
                    });
                  },
                ),

                const Text("Property*",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold)),

                SelectionOptionField(
                  items: serviceTypeList
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChange: (value) {
                    setState(() {
                      selectItem = value as String;
                    });
                  },
                ),
                const Text("Location*",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold)),

                SelectionOptionField(
                  items: serviceTypeList
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChange: (value) {
                    setState(() {
                      selectItem = value as String;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        Step(
            isActive: currentStep >= 2,
            title: const Text('3st step'),
            content: Container()),
      ];
}
