import 'package:dio/dio.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:fx_project/layout/buttonfield.dart';
import 'package:fx_project/layout/input_field.dart';
import 'package:fx_project/models/createjobmodel.dart';
import 'package:fx_project/screens/environmentpage.dart';
import 'package:fx_project/services/createjodservices.dart';

class CreateJobsScreen extends StatefulWidget {
  const CreateJobsScreen({super.key});

  @override
  State<CreateJobsScreen> createState() => _CreateJobsScreenState();
}

class _CreateJobsScreenState extends State<CreateJobsScreen> {
  CreateJobResponseModel? listData;
  // propertyData = [];
  late bool isListSelect = false;
  final serviceController = TextEditingController();
  final propertyController = TextEditingController();
  final locationController = TextEditingController();
  final briefDescripController = TextEditingController();
  final detailDescripController = TextEditingController();

  int currentStep = 0;

  final List<SelectedListItem> serviceTypeList = [
    SelectedListItem(name: 'Repair'),
    SelectedListItem(name: 'Service'),
    SelectedListItem(name: 'Inspection'),
    SelectedListItem(name: 'Other'),
    SelectedListItem(name: 'Preventive'),
    SelectedListItem(name: 'Replacement'),
  ];
  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    dynamic baseurl2 = await EnvironmentPageState.getBaseurl() as dynamic;
    var propertyData =
        Dio(BaseOptions(baseUrl: 'https://$baseurl2/v1/properties/dropdown/'));

    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          //propertyData = listData as List<CreateJobResponseModel>?;
        }));
    print("property data : ${propertyData}");
  }

  // Future<void> getData() async {
  //   dynamic baseurl2 = await EnvironmentPageState.getBaseurl() as dynamic;
  //   listData = await (CreateJobServices(
  //           service: Dio(BaseOptions(baseUrl: 'https://$baseurl2')))
  //       .createJobService());
  //   Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
  //         propertyData = listData as List<CreateJobResponseModel>?;
  //       }));
  //   print("property data : $propertyData");
  //   //print('${listData!.name}');
  // }

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
          colorScheme:
              const ColorScheme.light(primary: Color.fromARGB(255, 230, 81, 0)),
          iconTheme: Theme.of(context).iconTheme.copyWith(size: 32.0),
        ),
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
              margin: const EdgeInsets.only(top: 20),
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
            content: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Service*",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ReuseTextFields(
                    text: 'Select',
                    inputfieldcolor: Colors.white,
                    maxLines: 1,
                    password: false,
                    readOnly: false,
                    controller: serviceController,
                    isListSelect: true,
                    textAlign: TextAlign.left,
                    data: serviceTypeList,
                    isSearchVisible: false,
                    selectedItems: (List<dynamic> selectedList) {
                      for (var serviceTypeList in selectedList) {
                        if (serviceTypeList is SelectedListItem) {
                          return Text(serviceTypeList.name);
                        }
                      }
                    },
                    suffixs: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 30,
                    ),
                  ),
                ),
                const Text("Property*",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ReuseTextFields(
                    text: 'Select',
                    inputfieldcolor: Colors.white,
                    maxLines: 1,
                    password: false,
                    readOnly: false,
                    controller: propertyController,
                    isListSelect: true,
                    textAlign: TextAlign.left,
                    data: serviceTypeList,
                    isSearchVisible: true,
                    selectedItems: (List<dynamic> selectedList) {
                      for (var serviceTypeList in selectedList) {
                        if (serviceTypeList is SelectedListItem) {
                          return Text(serviceTypeList.name);
                        }
                      }
                    },
                    suffixs: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 30,
                    ),
                  ),
                ),
                const Text("Location*",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ReuseTextFields(
                    text: 'Select',
                    inputfieldcolor: Colors.white,
                    maxLines: 1,
                    password: false,
                    readOnly: false,
                    controller: locationController,
                    isListSelect: true,
                    textAlign: TextAlign.left,
                    data: serviceTypeList,
                    isSearchVisible: true,
                    suffixs: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 30,
                    ),
                  ),
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
                    controller: briefDescripController,
                    password: false,
                    readOnly: false,
                    isListSelect: false,
                    isSearchVisible: false,
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
                    controller: detailDescripController,
                    password: false,
                    readOnly: false,
                    isListSelect: false,
                    isSearchVisible: false,
                  ),
                ),
              ],
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ReuseTextFields(
                    text: 'Select',
                    inputfieldcolor: Colors.white,
                    maxLines: 1,
                    isListSelect: true,
                    password: false,
                    readOnly: false,
                    textAlign: TextAlign.left,
                    data: serviceTypeList,
                    isSearchVisible: false,
                    suffixs: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 30,
                    ),
                  ),
                ),

                const Text("Property*",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ReuseTextFields(
                    text: 'Select',
                    inputfieldcolor: Colors.white,
                    maxLines: 1,
                    isListSelect: true,
                    password: false,
                    readOnly: false,
                    textAlign: TextAlign.left,
                    data: serviceTypeList,
                    isSearchVisible: true,
                    suffixs: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 30,
                    ),
                  ),
                ),

                const Text("Location*",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ReuseTextFields(
                    text: 'Select',
                    inputfieldcolor: Colors.white,
                    maxLines: 1,
                    isListSelect: true,
                    password: false,
                    readOnly: false,
                    textAlign: TextAlign.left,
                    data: serviceTypeList,
                    isSearchVisible: true,
                    suffixs: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 30,
                    ),
                  ),
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

  //     void onTextFieldTap() {
  //   print('datalist');
  //   DropDownState(DropDown(
  //     bottomSheetTitle: const Text(
  //       'Service Type',
  //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
  //     ),
  //     data: serviceTypeList,
  //   )).showModal(context);
  // }
}
