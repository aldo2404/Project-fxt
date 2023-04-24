// ignore_for_file: avoid_print

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:fx_project/layout/buttonfield.dart';
import 'package:fx_project/layout/dropdownui.dart';
import 'package:fx_project/layout/input_field.dart';
import 'package:fx_project/layout/photobuttons.dart';
import 'package:fx_project/layout/snackbar.dart';
import 'package:fx_project/models/createjobmodel.dart';
import 'package:fx_project/screens/environmentpage.dart';
import 'package:fx_project/services/createjodservices.dart';
import 'package:image_picker/image_picker.dart';

class CreateJobsScreen extends StatefulWidget {
  const CreateJobsScreen({super.key});

  @override
  State<CreateJobsScreen> createState() => _CreateJobsScreenState();
}

class _CreateJobsScreenState extends State<CreateJobsScreen> {
  File? image;
  dynamic serData;
  dynamic proData;
  dynamic locData;
  dynamic cateData;
  String printService = '';
  String printProperty = '';
  String printLocation = '';
  String printCategory = '';
  String locationName = '';
  String locTenantName = '';
  List<dynamic>? propertyData = [];
  List<dynamic>? locationData = [];
  List<dynamic>? serviceData = [];
  List<dynamic>? locatData = [];
  List<dynamic>? locatTenant = [];
  final bool _isChecked = true;

  List<dynamic>? categoryData = [];
  late bool isListSelect = false;
  final TextEditingController serviceController = TextEditingController();
  final TextEditingController propertyController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController briefDescripController = TextEditingController();
  final TextEditingController detailDescripController = TextEditingController();
  final TextEditingController searchEditingController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();
  final TextEditingController _datePicker = TextEditingController();

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

    name = serviceData!.whereType<Map>().first.toString();
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
        title:
            Text(currentStep == 2 ? 'Review & Submit' : 'Create Job Request'),
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
                margin: const EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: ClickButton(
                        onpressed: () {
                          if (currentStep == 0) {
                            if (serviceController.text.isEmpty) {
                              ReuseSnackBar().waringField(
                                  context, "Kindly choose a service type");
                            } else if (propertyController.text.isEmpty) {
                              ReuseSnackBar().waringField(
                                  context, "Kindly choose a property");
                            } else if (locationController.text.isEmpty) {
                              ReuseSnackBar().waringField(
                                  context, "Kindly choose a location");
                            } else if (briefDescripController.text.isEmpty) {
                              ReuseSnackBar().waringField(
                                  context, "Kindly choose a brief Description");
                            } else {
                              setState(() {
                                currentStep += 1;
                              });
                            }
                          } else if (currentStep == 1) {
                            if (categoryController.text.isEmpty) {
                              ReuseSnackBar().waringField(
                                  context, "Kindly choose a category");
                            } else {
                              setState(() {
                                currentStep += 1;
                              });
                            }
                          } else {
                            print("Steps Completed");
                          }
                        },
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
            title: const Text(''),
            content: Stack(
              fit: StackFit.loose,
              //color: Colors.white,
              children: [
                Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                          text: "Service",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          children: [
                            TextSpan(
                                text: '*', style: TextStyle(color: Colors.red))
                          ]),
                      textAlign: TextAlign.start,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                      child: ReuseTextFields(
                        hinttext: 'Select',
                        inputfieldcolor: Colors.white,
                        maxLines: 1,
                        password: false,
                        readOnly: true,
                        showCursor: false,
                        controller: serviceController,
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
                                  titleText: 'Service Type',
                                  listData: serviceData!,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black12)),
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
                                              serviceController.text =
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
                    RichText(
                      text: const TextSpan(
                          text: "Property",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          children: [
                            TextSpan(
                                text: '*', style: TextStyle(color: Colors.red))
                          ]),
                      textAlign: TextAlign.start,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                      child: ReuseTextFields(
                          hinttext: 'Select',
                          inputfieldcolor: Colors.white,
                          maxLines: 1,
                          password: false,
                          readOnly: true,
                          showCursor: false,
                          controller: propertyController,
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
                                                propertyController.text =
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
                    RichText(
                      text: const TextSpan(
                          text: "Location",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          children: [
                            TextSpan(
                                text: '*', style: TextStyle(color: Colors.red))
                          ]),
                      textAlign: TextAlign.start,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                      child: ReuseTextFields(
                        hinttext: 'Select',
                        inputfieldcolor: Colors.white,
                        maxLines: 1,
                        password: false,
                        readOnly: true,
                        showCursor: false,
                        controller: locationController,
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
                                    print("locatData: $locatData");
                                    print(locatData!.length);

                                    return SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                        child: ListTile(
                                          title: Container(
                                            decoration: const BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 248, 246, 246),
                                            ),
                                            child: Text(
                                              locationData![index]['address']
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                          ),
                                          subtitle: Column(
                                            children: [
                                              for (int index_ = 0;
                                                  index_ < locatData!.length;
                                                  index_++) ...{
                                                // locationName =
                                                //     locatData![index_]['name'],
                                                GestureDetector(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          //locationName,
                                                          locatData![index_]
                                                                  ['name']
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 12),
                                                        ),
                                                        for (var tenant
                                                            in locationData![
                                                                            index]
                                                                        [
                                                                        'units']
                                                                    [index]
                                                                ['tenant']) ...{
                                                          // Text(
                                                          //   tenant['name']
                                                          //       .toString(),
                                                          //   // locatData![index_]
                                                          //   //         ['tenant']
                                                          //   //     .toString(),
                                                          //   textDirection:
                                                          //       TextDirection
                                                          //           .rtl,
                                                          // ),
                                                        },
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      locationName =
                                                          locatData![index_]
                                                              ['name'];
                                                      print(
                                                          "locationName: ${locatData![index_]['tenant']}");
                                                      locationController.text =
                                                          ' ${locationData![index]['address']},${locatData![index_]['name']},${locatData![index_]['tenant.name']}';
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              }
                                            ],
                                          ),
                                          // onTap: () {
                                          //   setState(() {
                                          //     locationController.text =
                                          //         ' ${locationData![index]['address']},$locationName';
                                          //   });

                                          //   Navigator.of(context).pop();
                                          // },
                                        ));
                                  },
                                );
                              });
                        },
                      ),
                    ),
                    RichText(
                      text: const TextSpan(
                          text: "Brief Description",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          children: [
                            TextSpan(
                                text: '*', style: TextStyle(color: Colors.red))
                          ]),
                      textAlign: TextAlign.start,
                    ),
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
          title: const Text(''),
          content: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                      text: "Maintenance Category",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      children: [
                        TextSpan(text: '*', style: TextStyle(color: Colors.red))
                      ]),
                  textAlign: TextAlign.start,
                ),
                //const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                  child: ReuseTextFields(
                    hinttext: 'Select',
                    inputfieldcolor: Colors.white,
                    maxLines: 1,
                    password: false,
                    readOnly: true,
                    showCursor: false,
                    textAlign: TextAlign.left,
                    controller: categoryController,
                    onTap: () async {
                      await showModalBottomSheet(
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15))),
                          context: context,
                          builder: (context) {
                            return DropDownUiScreen(
                              titleText: 'Category',
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
                                          categoryController.text =
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
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 8.0),
                //   child: ListTile(
                //     title: const Text('Courtesy Job',
                //         textAlign: TextAlign.start,
                //         style: TextStyle(
                //             fontWeight: FontWeight.bold, fontSize: 20)),
                //     trailing: Checkbox(
                //         checkColor: Colors.white,
                //         activeColor: Colors.orange[900],
                //         side: const BorderSide(
                //             width: 2, color: Color.fromARGB(255, 230, 81, 0)),
                //         value: _isChecked,
                //         onChanged: null),
                //   ),
                // ),

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
                    readOnly: true,
                    showCursor: false,
                    textAlign: TextAlign.left,
                    controller: priorityController,
                    onTap: () async {
                      await showModalBottomSheet(
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15))),
                          context: context,
                          builder: (context) {
                            return DropDownUiScreen(
                                titleText: 'Select Priority',
                                listData: categoryData!,
                                itemBuilder: (context, index) {
                                  return Container();
                                });
                          });
                    },
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
                    readOnly: true,
                    showCursor: false,
                    textAlign: TextAlign.left,
                    controller: _datePicker,
                    onTap: () async {
                      DateTime? pickDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2110));

                      if (pickDate != null) {
                        setState(() {
                          _datePicker.text =
                              DateFormat('MM-dd-yyyy').format(pickDate);
                        });
                      }
                    },
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
                      PhotoButton(
                          icon: Icons.camera_alt_outlined,
                          buttonName: "Take Photo",
                          onPressed: () {
                            pickImage(ImageSource.camera);
                          }),
                      const SizedBox(width: 20),
                      PhotoButton(
                        onPressed: () {
                          pickImage(ImageSource.gallery);
                        },
                        buttonName: "Upload Photo",
                        icon: Icons.file_upload_outlined,
                      )
                    ],
                  ),
                ),

                //const FlutterLogo(size: 150),
              ],
            ),
          ),
        ),
        Step(
            isActive: currentStep >= 2,
            title: const Text(''),
            content: Column(
              children: const [
                SizedBox(
                  height: 20,
                ),
              ],
            )),
      ];
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return;
      }
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  void onClearTap() {
    searchEditingController.clear();
  }
}
