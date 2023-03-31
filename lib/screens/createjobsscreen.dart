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
      //backgroundColor: Colors.grey.shade200,
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
      body: Theme(
        data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
                primary: Color.fromARGB(255, 230, 81, 0))),
        child: Stepper(
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
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            final isLastStep = currentStep == getSteps().length - 1;

            return Container(
              margin: const EdgeInsets.only(top: 50),
              child: Row(
                children: [
                  Expanded(
                    child: ClickButton(
                      onpressed: details.onStepContinue,
                      child: Text(isLastStep ? 'CONFIRM' : 'NEXT'),
                    ),
                  ),
                  if (currentStep != 0)
                    Expanded(
                      child: ClickButton(
                        onpressed: details.onStepCancel,
                        child: const Text('BACK'),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 0,
            title: const Text('1st step'),
            content: SafeArea(
              maintainBottomViewPadding: true,
              child: Container(
                color: Colors.white,
                child: Expanded(
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
              ),
            )),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text('2st step'),
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
