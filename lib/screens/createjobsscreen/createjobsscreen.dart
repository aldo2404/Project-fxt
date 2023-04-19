import 'package:dio/dio.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:fx_project/layout/buttonfield.dart';
import 'package:fx_project/layout/dropdownui.dart';
import 'package:fx_project/layout/input_field.dart';
import 'package:fx_project/layout/owndropdownlist.dart';
import 'package:fx_project/layout/owndropdownlist.dart';
import 'package:fx_project/layout/owndropdownlist.dart';
import 'package:fx_project/models/createjobmodel.dart';
import 'package:fx_project/screens/environmentpage.dart';
import 'package:fx_project/services/createjodservices.dart';

class CreateJobsScreen extends StatefulWidget {
  const CreateJobsScreen({super.key});

  @override
  State<CreateJobsScreen> createState() => _CreateJobsScreenState();
}

class _CreateJobsScreenState extends State<CreateJobsScreen> {
  dynamic serData;
  dynamic proData;
  dynamic locData;
  dynamic cateData;
  String printService = '';
  String printProperty = '';
  String printLocation = '';
  String printCategory = '';
  List<dynamic>? propertyData = [];
  List<dynamic>? locationData = [];
  List<dynamic>? serviceData = [];
  List<dynamic>? locatData = [];
  final bool _isChecked = true;

  List<dynamic>? categoryData = [];
  late bool isListSelect = false;
  final TextEditingController serviceController = TextEditingController();
  final TextEditingController propertyController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController briefDescripController = TextEditingController();
  final TextEditingController detailDescripController = TextEditingController();
  final TextEditingController searchEditingController = TextEditingController();

  int currentStep = 0;
  String? selectionData;

  String? selectionOption;
  String? data1;
  String? data2;

  dynamic id;
  String? name;
  String? printData;

  @override
  void initState() {
    super.initState();
    serviceGetData();
    propetyGetData();

    categoryGetData();
  }
// service drop down list URL data........

  Future<void> serviceGetData() async {
    dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;
    serData = (await (CreateJobServices(
            service: Dio(BaseOptions(
                baseUrl: 'https://$baseurl1/v1/jobs/service-type/')))
        .createJobService()));

    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
    print("service data : ${serData.toString()}");
    serviceData = serData;
    //serListData = serviceData as List<SelectedListItem>;
    name = serviceData!.whereType<Map>().first.toString();

//     List<SelectedListItem> propertyTypeList =
//   mapData.entries.map( (entry) => SelectedListItem(entry.key, entry.value)).toList();
//     if (!name.moveNext()) {
//     final map = name.current();
//     print(map['name']);
// }
    // for (var map in serData!) {
    //   if (map?.containsKey("name") ?? false) {
    //     if (map!["name"] == serData.toString()) {
    //       print('septreted data : ${map!["name"]} ');
    //       // your list of map contains key "id" which has value 3
    //     }
    //   }
    // }
  }

// property drop down list URL data........

  Future<void> propetyGetData() async {
    dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;
    proData = (await (CreateJobServices(
            service: Dio(BaseOptions(
                baseUrl: 'https://$baseurl1/v1/properties/dropdown/')))
        .createJobService()));

    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
    print("property data : ${proData.toString()}");
    propertyData = proData;
    print('single data: ${propertyData![1]}');
    //data1 = propertyData![index]['name'].toString();
    //data2 = propertyData![index]['address'].toString();
  }

// Location drop down list URL data........

  Future<void> locationGetData(id) async {
    dynamic baseurl2 = await EnvironmentPageState.getBaseurl() as dynamic;
    locData = (await (CreateJobServices(
            service: Dio(BaseOptions(
                baseUrl: 'https://$baseurl2/v1/properties/$id/units/')))
        .createJobService()));

    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
    print('location data : ${locData.toString()}');
    locationData = locData;
  }
// maintenance category drop down list URL data........

  Future<void> categoryGetData() async {
    dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;
    cateData = (await (CreateJobServices(
            service: Dio(
                BaseOptions(baseUrl: 'https://$baseurl1/v1/fyxt-categories/')))
        .createJobService()));

    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
    print("category data : ${cateData.toString()}");
    categoryData = cateData;
  }

  void _onDropDownItemSelected(SelectedListItem newSelectedOption) {
    setState(() {});
  }

  void bottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 48, 92),
        leading: IconButton(
            onPressed: () {
              if (currentStep >= 1) {
                setState(() => currentStep -= 1);
              } else if (currentStep == 0) {
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.arrow_back_sharp)),
        centerTitle: true,
        title: const Text("Create Jobs Request"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
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
          margin: EdgeInsets.zero,
          type: StepperType.horizontal,
          steps: getSteps(),
          currentStep: currentStep,
          onStepContinue: () {
            final isLastStep = currentStep == getSteps().length - 1;
            if (isLastStep) {
              print('Steps Completed');
            } else {
              setState(() {
                currentStep += 1;
              });
            }
          },
          onStepCancel:
              currentStep == 0 ? null : () => setState(() => currentStep -= 1),
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            final isLastStep = currentStep == getSteps().length - 1;

            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                //color: Colors.grey.shade100,
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: ClickButton(
                        onpressed: details.onStepContinue,
                        child: Text(isLastStep ? 'CONFIRM' : 'NEXT'),
                      ),
                    ),
                    if (currentStep == 2)
                      Expanded(
                        child: ClickButton(
                          onpressed: details.onStepCancel,
                          child: const Text('BACK'),
                        ),
                      ),
                  ],
                ),
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
            title: const Text('1st'),
            content: Stack(
              fit: StackFit.loose,
              //color: Colors.white,
              children: [
                Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Service*",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                      child: ReuseTextFields(
                        hinttext: 'Select',
                        inputfieldcolor: Colors.white,
                        maxLines: 1,
                        password: false,
                        readOnly: false,
                        showCursor: false,
                        controller: TextEditingController(text: printService),
                        textAlign: TextAlign.left,
                        onTap: () async {
                          await showModalBottomSheet(
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(15))),
                              context: context,
                              builder: (context) {
                                return DropDownUiScreen(
                                  titleText: 'Service',
                                  listData: serviceData!,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                        decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 248, 246, 246),
                                        ),
                                        child: ListTile(
                                          title: Text(
                                            serviceData![index]['name']
                                                .toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              printService =
                                                  serviceData![index]['name'];
                                            });

                                            Navigator.of(context).pop();
                                          },
                                        ));
                                  },
                                );
                              });
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
                      padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                      child: ReuseTextFields(
                          hinttext: 'Select',
                          inputfieldcolor: Colors.white,
                          maxLines: 1,
                          password: false,
                          readOnly: false,
                          showCursor: false,
                          controller:
                              TextEditingController(text: printProperty),
                          textAlign: TextAlign.left,
                          suffixs: const Icon(
                            Icons.keyboard_arrow_down_sharp,
                            size: 30,
                          ),
                          onTap: () async {
                            await showModalBottomSheet(
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(15))),
                                context: context,
                                builder: (context) {
                                  return DropDownUiScreen(
                                    titleText: 'Property',
                                    listData: propertyData!,
                                    itemBuilder: (context, index) {
                                      return Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02,
                                          decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 248, 246, 246),
                                          ),
                                          child: ListTile(
                                            title: Text(
                                              propertyData![index]['name']
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                            subtitle: Text(
                                              propertyData![index]['address']
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                              maxLines: 1,
                                            ),
                                            onTap: () {
                                              setState(() {
                                                printProperty =
                                                    propertyData![index]
                                                        ['name'];
                                                print(
                                                    "id: ${propertyData![index]['id']}");
                                                id = propertyData![index]['id'];
                                                locationGetData(id);
                                              });

                                              Navigator.of(context).pop();
                                            },
                                          ));
                                    },
                                  );
                                });
                          }),
                    ),
                    const Text("Location*",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                      child: ReuseTextFields(
                        hinttext: 'Select',
                        inputfieldcolor: Colors.white,
                        maxLines: 1,
                        password: false,
                        readOnly: false,
                        showCursor: false,
                        controller: TextEditingController(text: printLocation),
                        textAlign: TextAlign.left,
                        suffixs: const Icon(
                          Icons.keyboard_arrow_down_sharp,
                          size: 30,
                        ),
                        onTap: () async {
                          await showModalBottomSheet(
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(15))),
                              context: context,
                              builder: (context) {
                                return DropDownUiScreen(
                                  titleText: 'Location',
                                  listData: locationData!,
                                  itemBuilder: (context, index) {
                                    locatData = locationData![index]['units'];
                                    for (int index_ = 0;
                                        index_ <= locatData!.length;
                                        index_++) {}

                                    return Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                        decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 248, 246, 246),
                                        ),
                                        child: ListTile(
                                          title: Text(
                                            locationData![index]['address']
                                                .toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                          subtitle: Text(
                                            locatData![index]['name']
                                                .toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                            maxLines: 1,
                                          ),
                                          onTap: () {
                                            setState(() {
                                              printLocation =
                                                  locationData![index]
                                                      ['address'];
                                            });

                                            Navigator.of(context).pop();
                                          },
                                        ));
                                  },
                                );
                              });
                        },
                      ),
                    ),
                    const Text("Brief Description",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                      child: ReuseTextFields(
                        textAlign: TextAlign.left,
                        hinttext: "Description",
                        inputfieldcolor: Colors.white,
                        maxLines: 4,
                        controller: briefDescripController,
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
                      padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                      child: ReuseTextFields(
                        textAlign: TextAlign.left,
                        hinttext: "Description",
                        inputfieldcolor: Colors.white,
                        maxLines: 4,
                        controller: detailDescripController,
                        password: false,
                        readOnly: false,
                      ),
                    ),
                  ],
                ),
              ],
            )),

        //Second Step page.....
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text('2nd'),
          content: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Maintenance Category*",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                //const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                  child: ReuseTextFields(
                    hinttext: 'Select',
                    inputfieldcolor: Colors.white,
                    maxLines: 1,
                    password: false,
                    readOnly: false,
                    showCursor: false,
                    textAlign: TextAlign.left,
                    controller: TextEditingController(text: printCategory),
                    onTap: () async {
                      await showModalBottomSheet(
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15))),
                          context: context,
                          builder: (context) {
                            return DropDownUiScreen(
                              titleText: 'Service',
                              listData: categoryData!,
                              itemBuilder: (context, index) {
                                return Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.02,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 248, 246, 246),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        categoryData![index]['name'].toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          printCategory =
                                              categoryData![index]['name'];
                                        });

                                        Navigator.of(context).pop();
                                      },
                                    ));
                              },
                            );
                          });
                    },
                    suffixs: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ListTile(
                    title: const Text('Courtesy Job',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    trailing: Checkbox(
                        checkColor: Colors.white,
                        activeColor: Colors.orange[900],
                        side: const BorderSide(
                            width: 2, color: Color.fromARGB(255, 230, 81, 0)),
                        value: _isChecked,
                        onChanged: null),
                  ),
                ),

                const Text("Priority",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                  child: ReuseTextFields(
                    hinttext: 'Select',
                    inputfieldcolor: Colors.white,
                    maxLines: 1,
                    password: false,
                    readOnly: false,
                    showCursor: false,
                    textAlign: TextAlign.left,
                    suffixs: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 30,
                    ),
                  ),
                ),

                const Text("Target Completion Date",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                  child: ReuseTextFields(
                    hinttext: 'Select',
                    inputfieldcolor: Colors.white,
                    maxLines: 1,
                    password: false,
                    readOnly: false,
                    showCursor: false,
                    textAlign: TextAlign.left,
                    suffixs: const Icon(
                      Icons.calendar_month_outlined,
                      size: 30,
                    ),
                  ),
                ),
                const Text("Add Photos",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 140,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: const Color.fromARGB(255, 1, 30, 54)),
                          child: Row(
                            children: const [
                              SizedBox(width: 8),
                              Icon(
                                Icons.camera_alt_outlined,
                                size: 22,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Take Photo',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        child: Container(
                          width: 150,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: const Color.fromARGB(255, 1, 30, 54)),
                          child: Row(
                            children: const [
                              SizedBox(width: 8),
                              Icon(
                                Icons.file_upload_outlined,
                                size: 22,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Upload Photo',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                //strutStyle: StrutStyle(leading: 1),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Step(
            isActive: currentStep >= 2,
            title: const Text('3rd'),
            content: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
              ],
            )),
      ];

  void onClearTap() {
    searchEditingController.clear();
  }
}
