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
import 'package:fx_project/layout/reviewscreen.dart';
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
  final List<File> _imageFiles = [];
  dynamic baseUrl;
  dynamic serData;
  dynamic proData;
  dynamic locData;
  dynamic cateData;
  dynamic prioData;
  dynamic manData;
  dynamic engData;
  dynamic imageId;
  String printService = '';
  String printProperty = '';
  String printLocation = '';
  String printCategory = '';
  String printPriority = '';
  String locationName = '';
  String locTenantName = '';
  String locatAddress = '';
  List<dynamic>? propertyData = [];
  List<dynamic>? locationData = [];
  List<dynamic>? serviceData = [];
  List<Map<String, dynamic>>? locatData = [];
  List<dynamic>? categoryData = [];
  List<dynamic>? priorityData = [];
  List<dynamic>? engineerData = [];
  List<dynamic>? managerData = [];
  List<String> imgId = [];

  final bool _isChecked = true;

  final step1FormKey = GlobalKey<FormState>();
  final step2FormKey = GlobalKey<FormState>();
  final step3FormKey = GlobalKey<FormState>();

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
  final TextEditingController textController = TextEditingController();

  int currentStep = 0;
  String? selectionData;

  String? selectionOption;
  String? data1;
  String? data2;

  dynamic id;
  String? name;
  String? printData;
  bool extracLine = true;
  bool textIcon = true;

  @override
  void initState() {
    super.initState();
    serviceGetData();
    propetyGetData();

    priorityGetData();
    priorityController.text = 'Medium';
    _datePicker.text = nowDate();
  }
// service drop down list URL data........

  Future<void> serviceGetData() async {
    baseUrl = await EnvironmentPageState.getBaseurl() as dynamic;
    serData = (await (CreateJobServices(
            service: Dio(
                BaseOptions(baseUrl: 'https://$baseUrl/v1/jobs/service-type/')))
        .createJobService()));

    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
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
    propertyData = proData;
  }

// Location drop down list URL data........

  Future<void> locationGetData(id) async {
    dynamic baseurl2 = await EnvironmentPageState.getBaseurl() as dynamic;
    locData = (await (CreateJobServices(
            service: Dio(BaseOptions(
                baseUrl: 'https://$baseurl2/v1/properties/$id/units/')))
        .createJobService()));
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
    locationData = locData;
  }

// maintenance category drop down list URL data........

  Future<void> categoryGetData(cateid) async {
    dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;
    cateData = (await (CreateJobServices(
            service: Dio(BaseOptions(
                baseUrl:
                    'https://$baseurl1/v1/properties/$cateid/categories/')))
        .createJobService()));
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
    categoryData = cateData;
  }

  Future<void> priorityGetData() async {
    dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;
    prioData = (await (CreateJobServices(
            service: Dio(
                BaseOptions(baseUrl: 'https://$baseurl1/v1/jobs/priorities/')))
        .createJobService()));
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
    priorityData = prioData;
  }

  Future<void> managerGetData(manid) async {
    dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;
    manData = (await (CreateJobServices(
            service: Dio(BaseOptions(
                baseUrl: 'https://$baseurl1/v1/properties/$manid/managers/')))
        .createJobService()));
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
    managerData = manData;
    print('manager $managerData');
  }

  Future<void> engineerGetData(engid) async {
    dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;
    engData = (await (CreateJobServices(
            service: Dio(BaseOptions(
                baseUrl: 'https://$baseurl1/v1/properties/$engid/engineers/')))
        .createJobService()));
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
    engineerData = engData;
    print('engineer $engineerData');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              heightFactor: 1.6,
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
              Form(
                key: step1FormKey,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    mandatoryText("Service"),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                      child: ReuseTextFields(
                        hinttext: 'Select',
                        inputfieldcolor: Colors.white,
                        maxLines: 1,
                        password: false,
                        color: const Color(0xFF000000),
                        readOnly: true,
                        showCursor: false,
                        controller: serviceController,
                        textAlign: TextAlign.left,
                        onTap: () async {
                          bottomSheetDropDown(
                            'Service',
                            serviceData!.length,
                            (context, index) {
                              return Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.black12)),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      serviceData![index]['name'].toString(),
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
                        },
                        suffixs: const Icon(
                          Icons.keyboard_arrow_down_sharp,
                          size: 30,
                        ),
                      ),
                    ),
                    mandatoryText("Property"),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                      child: ReuseTextFields(
                          hinttext: 'Select',
                          inputfieldcolor: Colors.white,
                          maxLines: 1,
                          password: false,
                          readOnly: true,
                          color: const Color(0xFF000000),
                          showCursor: false,
                          controller: propertyController,
                          textAlign: TextAlign.left,
                          suffixs: const Icon(
                            Icons.keyboard_arrow_down_sharp,
                            size: 30,
                          ),
                          onTap: () async {
                            bottomSheetDropDown(
                              'Property',
                              propertyData!.length,
                              (context, index) {
                                return Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.02,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 248, 246, 246),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        propertyData![index]['name'].toString(),
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
                                              propertyData![index]['name'];
                                          print(
                                              "id: ${propertyData![index]['id']}");
                                          id = propertyData![index]['id'];
                                          locationGetData(id);
                                          categoryGetData(id);
                                          managerGetData(id);
                                          engineerGetData(id);
                                        });

                                        Navigator.of(context).pop();
                                      },
                                    ));
                              },
                            );
                            ;
                          }),
                    ),
                    mandatoryText("Location"),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                      child: ReuseTextFields(
                        hinttext: 'Select',
                        inputfieldcolor: Colors.white,
                        maxLines: 1,
                        password: false,
                        readOnly: true,
                        showCursor: false,
                        color: const Color(0xFF000000),
                        controller: locationController,
                        textAlign: TextAlign.left,
                        suffixs: const Icon(
                          Icons.keyboard_arrow_down_sharp,
                          size: 30,
                        ),
                        onTap: () {
                          bottomSheetDropDown(
                            'Location',
                            locationData!.length,
                            (context, index) {
                              final locAddress =
                                  locationData![index]['address'].toString();
                              locatData = locationData![index]['units']
                                      .cast<Map<String, dynamic>>() ??
                                  [];
                              return ListTile(
                                title: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 248, 246, 246),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        locAddress,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                subtitle: Column(
                                    children: locatData!.map<Widget>((unit) {
                                  final unitName = unit['name'];
                                  final tenantName = unit['tenant'] != null
                                      ? unit['tenant']['name']
                                      : '-';
                                  return InkWell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            unitName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            tenantName,
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      locationName = unitName;
                                      locTenantName = tenantName;
                                      locatAddress = locAddress;
                                      setState(() {
                                        print('$locTenantName,$locationName');
                                        locationController.text =
                                            ' $locAddress,$unitName,$tenantName';
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  );
                                }).toList()),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    mandatoryText("Brief Description"),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                      child: ReuseTextFields(
                        keyboardtypes: TextInputType.multiline,
                        textAlign: TextAlign.left,
                        hinttext: "Description",
                        color: const Color(0xFF000000),
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
                        keyboardtypes: TextInputType.text,
                        textAlign: TextAlign.left,
                        hinttext: "Description",
                        inputfieldcolor: Colors.white,
                        maxLines: 4,
                        color: const Color(0xFF000000),
                        controller: detailDescripController,
                        password: false,
                        readOnly: false,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        //Second Step page.....
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text(''),
          content: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Form(
              key: step2FormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  mandatoryText("Maintenance Category"),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                    child: ReuseTextFields(
                      hinttext: 'Select',
                      inputfieldcolor: Colors.white,
                      maxLines: 1,
                      password: false,
                      readOnly: true,
                      color: const Color(0xFF000000),
                      showCursor: false,
                      textAlign: TextAlign.left,
                      controller: categoryController,
                      onTap: () {
                        bottomSheetDropDown(
                          'Category',
                          categoryData!.length,
                          (context, index) {
                            return Container(
                                width: MediaQuery.of(context).size.width * 0.02,
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
                      color: const Color(0xFF000000),
                      showCursor: false,
                      textAlign: TextAlign.left,
                      controller: priorityController,
                      onTap: () {
                        bottomSheetDropDown(
                          'Priority',
                          priorityData!.length,
                          (context, index) {
                            return Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.black12))),
                              child: ListTile(
                                title: Text(
                                  priorityData![index]['name'],
                                ),
                                onTap: () {
                                  setState(() {
                                    priorityController.text =
                                        priorityData![index]['name'];
                                  });

                                  Navigator.of(context).pop();
                                },
                              ),
                            );
                          },
                        );
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
                      color: const Color(0xFF000000),
                      textAlign: TextAlign.left,
                      controller: _datePicker,
                      onTap: () async {
                        DateTime? pickDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2110),
                            initialDatePickerMode: DatePickerMode.day);

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
                            textColor: Colors.white,
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 1, 30, 54)),
                            onPressed: () {
                              pickImageByCamera();
                            }),
                        const SizedBox(width: 20),
                        PhotoButton(
                          onPressed: () {
                            pickMultipleImage();
                          },
                          buttonName: "Upload Photo",
                          textColor: Colors.white,
                          icon: Icons.file_upload_outlined,
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 1, 30, 54)),
                        )
                      ],
                    ),
                  ),

                  //multiple image upload in step 2 screen .......

                  _imageFiles.isNotEmpty
                      ? GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 5,
                          children: List.generate(
                              _imageFiles.length,
                              (index) => Stack(children: <Widget>[
                                    Image.file(
                                      _imageFiles[index],
                                      fit: BoxFit.cover,
                                      scale: 2,
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: InkWell(
                                        child: const Icon(
                                          Icons.cancel,
                                          size: 16,
                                          color: Colors.black26,
                                        ),
                                        onTap: () async {
                                          setState(() {
                                            _imageFiles.removeAt(index);
                                          });
                                          var imageId = imgId[index].toString();

                                          await CreateJobServices()
                                              .deleteFiles(imageId);
                                          setState(() {
                                            imgId.removeAt(index);
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 100)
                                  ])),
                        )
                      : const SizedBox(
                          height: 168,
                        )
                ],
              ),
            ),
          ),
        ),

        //Step 3 screen.....
        Step(
            isActive: currentStep >= 2,
            title: const Text(''),
            content: SingleChildScrollView(
              controller: ScrollController(),
              child: Form(
                key: step3FormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 248, 246, 246),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Priority:',
                            style: TextStyle(fontSize: 12),
                          ),
                          ReuseTextFields(
                            hinttext: 'Select',
                            inputfieldcolor: Colors.white,
                            maxLines: 1,
                            password: false,
                            readOnly: true,
                            showCursor: false,
                            textAlign: TextAlign.left,
                            color: const Color(0xFF000000),
                            controller: priorityController,
                            onTap: () {
                              bottomSheetDropDown(
                                'Priority',
                                priorityData!.length,
                                (context, index) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.black12))),
                                    child: ListTile(
                                      title: Text(
                                        priorityData![index]['name'],
                                      ),
                                      onTap: () {
                                        setState(() {
                                          priorityController.text =
                                              priorityData![index]['name'];
                                        });

                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            suffixs: const Icon(
                              Icons.keyboard_arrow_down_sharp,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      'Brief Description',
                      style: TextStyle(fontSize: 12),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          briefDescripController.text,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.mode_edit_outline,
                            size: 18,
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),

                    const Text(
                      'Detailed Description',
                      style: TextStyle(fontSize: 12),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          detailDescripController.text,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.mode_edit_outline,
                            size: 18,
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),

                    ReviewScreen(
                      titleText: "Property:",
                      editableText: propertyController.text,
                      iconVisiable: false,
                    ),
                    ReviewScreen(
                      titleText: "Address:",
                      editableText: locatAddress,
                      iconVisiable: false,
                    ),
                    ReviewScreen(
                      titleText: "location:",
                      editableText: locationName,
                      iconVisiable: true,
                      onPressed: () {
                        bottomSheetDropDown(
                          'Location',
                          locationData!.length,
                          (context, index) {
                            final locAddress =
                                locationData![index]['address'].toString();
                            locatData = locationData![index]['units']
                                    .cast<Map<String, dynamic>>() ??
                                [];
                            return ListTile(
                              title: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 248, 246, 246),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      locAddress,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              subtitle: Column(
                                  children: locatData!.map<Widget>((unit) {
                                final unitName = unit['name'];
                                final tenantName = unit['tenant'] != null
                                    ? unit['tenant']['name']
                                    : '-';
                                return InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          unitName,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          tenantName,
                                          textDirection: TextDirection.rtl,
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    locationName = unitName;
                                    locTenantName = tenantName;
                                    locatAddress = locAddress;
                                    setState(() {
                                      locationController.text =
                                          ' $locAddress,$unitName,$tenantName';
                                    });
                                    Navigator.of(context).pop();
                                  },
                                );
                              }).toList()),
                            );
                          },
                        );
                      },
                    ),
                    ReviewScreen(
                      titleText: "Target\nCompletion Date:",
                      editableText: _datePicker.text,
                      iconVisiable: true,
                      onPressed: () async {
                        DateTime? pickDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2110),
                            initialDatePickerMode: DatePickerMode.day);

                        if (pickDate != null) {
                          setState(() {
                            _datePicker.text =
                                DateFormat('MM-dd-yyyy').format(pickDate);
                          });
                        }
                      },
                    ),
                    ReviewScreen(
                      titleText: "Service Type:",
                      editableText: serviceController.text,
                      iconVisiable: true,
                      onPressed: () {
                        bottomSheetDropDown(
                          'Service',
                          serviceData!.length,
                          (context, index) {
                            return Container(
                                width: MediaQuery.of(context).size.width * 0.02,
                                decoration: const BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.black12)),
                                ),
                                child: ListTile(
                                  title: Text(
                                    serviceData![index]['name'].toString(),
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
                      },
                    ),
                    ReviewScreen(
                      titleText: "Category:",
                      editableText: categoryController.text,
                      iconVisiable: true,
                      onPressed: () {
                        bottomSheetDropDown(
                          'Category',
                          categoryData!.length,
                          (context, index) {
                            return Container(
                                width: MediaQuery.of(context).size.width * 0.02,
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
                      },
                    ),
                    ReviewScreen(
                      titleText: "Tenant:",
                      editableText: locTenantName,
                      iconVisiable: false,
                    ),
                    ReviewScreen(
                      titleText: "Billable Party:",
                      editableText: "Tenant",
                      iconVisiable: false,
                    ),

                    ReviewScreen(
                      titleText: "Assign Manager:",
                      editableText: propertyController.text,
                      iconVisiable: true,
                      onPressed: () {
                        bottomSheetDropDown(
                            'Assign Manager', managerData!.length,
                            (context, index) {
                          return Container();
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Assign Enggineer:',
                          style: TextStyle(fontSize: 12),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 204, 203, 203)),
                          ),
                          child: const Text(
                            'Assign',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        // Container(
                        //   width: 0,
                        //   padding: const EdgeInsets.all(18),
                        // ),
                      ],
                    ),
                    ReviewScreen(
                      titleText: "Submitted by:",
                      editableText: propertyController.text,
                      iconVisiable: false,
                    ),
                    ReviewScreen(
                      titleText: "Date Created:",
                      editableText: nowDate(),
                      iconVisiable: false,
                    ),
                    ReviewScreen(
                      titleText: "Courtesy Job:",
                      editableText: propertyController.text,
                      iconVisiable: false,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.black12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: extracLine ? null : 90.0,
                                padding: const EdgeInsets.only(left: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: const Border(
                                      bottom: BorderSide(),
                                      top: BorderSide(),
                                      left: BorderSide(),
                                      right: BorderSide()),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ExpansionTile(
                                  // childrenPadding: const EdgeInsets.symmetric(
                                  //     vertical: 5.0, horizontal: 5),
                                  // expandedCrossAxisAlignment:
                                  //     CrossAxisAlignment.stretch,
                                  title: const Text(
                                    'Access Instruction',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        textIcon
                                            ? Text(textController.text)
                                            : ReuseTextFields(
                                                width: 270,
                                                controller: textController,
                                                hinttext: 's',
                                                inputfieldcolor: Colors.black12,
                                                maxLines: 5,
                                                minLines: 1,
                                                password: false,
                                                readOnly: false,
                                                showCursor: true,
                                                color: const Color.fromARGB(
                                                    255, 226, 72, 1),
                                                textAlign: TextAlign.start),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                textIcon = !textIcon;
                                              });
                                            },
                                            icon: textIcon
                                                ? const Icon(
                                                    Icons.mode_edit_outline,
                                                    //size: 16,
                                                  )
                                                : const Icon(
                                                    Icons.check_sharp,
                                                    color: Color.fromARGB(
                                                        255, 230, 81, 0),
                                                  ))
                                      ],
                                    )
                                  ],
                                )),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'Pre-Completion Photos',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                          _imageFiles.isNotEmpty
                              ? GridView.count(
                                  shrinkWrap: true,
                                  crossAxisCount: 5,
                                  children: List.generate(
                                      _imageFiles.length,
                                      (index) => Stack(children: [
                                            Image.file(
                                              _imageFiles[index],
                                              fit: BoxFit.cover,
                                              scale: 1,
                                            ),
                                            Positioned(
                                              right: 0,
                                              top: 0,
                                              child: InkWell(
                                                child: const Icon(
                                                  Icons.cancel,
                                                  size: 16,
                                                  color: Colors.white,
                                                ),
                                                onTap: () async {
                                                  setState(() {
                                                    _imageFiles.removeAt(index);
                                                  });
                                                  var imageId =
                                                      imgId[index].toString();

                                                  await CreateJobServices()
                                                      .deleteFiles(imageId);
                                                  setState(() {
                                                    imgId.removeAt(index);
                                                  });
                                                },
                                              ),
                                            )
                                          ])),
                                )
                              : const SizedBox(
                                  height: 5,
                                )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )),
      ];
  Future<void> pickMultipleImage() async {
    List<XFile> images =
        await ImagePicker().pickMultiImage(maxHeight: 600, maxWidth: 600);

    if (images != null) {
      for (var i = 0; i < images.length; i++) {
        File pic = File(images[i].path);
        print('pic:$pic');
        print('path: ${images[i].path}');
        setState(() {
          _imageFiles.add(pic);
        });
      }
      uploadImage();
    }
  }

  Future<void> pickImageByCamera() async {
    XFile? cameraImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 150,
      maxHeight: 150,
    );
    if (cameraImage == null) return;
    if (cameraImage != null) {
      setState(() {
        _imageFiles.add(File(cameraImage.path));
      });
      uploadImage();
    }
  }

  Future<void> uploadImage() async {
    imageId = (await CreateJobServices().uploadFile(_imageFiles));
    //print(_imageFiles);
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(
          () {},
        ));

    // dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;
    // FormData formData = FormData();
    // dynamic data = {'file': _imageFiles, 'mime_Type': 'png'};
    // await (CreateJobServices(
    //         service: Dio(BaseOptions(baseUrl: 'https://$baseurl1/v1/photos/')))
    //     .uploadFile(formData));

    // var jsonResponse = imageId;
    // print('imgid${imageId['id']}');
    // var id = imageId['id'];
    // print('id : $id');

    // imgId.add(id);
    // for (var i = 0; i < _imageFiles.length; i++) {
    //   formData.files.add(MapEntry(
    //     'file',
    //     await MultipartFile.fromFile(_imageFiles[i].path),
    //   ));
    //   formData.fields.add(MapEntry('mime)type', 'image/png'));
    //   formData.fields.add(MapEntry('description', 'photo'));
    //   formData.fields.add(MapEntry('source', 'job'));
    //   formData.fields.add(MapEntry('type', 'Pro Completion'));
    // }
  }

  // Future<void> deleteFiles(imageid) async {
  //   dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;
  //   await (CreateJobServices(
  //           service: Dio(
  //               BaseOptions(baseUrl: 'https://$baseurl1/v1/photos/$imageid/')))
  //       .deleteFiles());
  // }

  Future<void> uploadCreateJobs({
    dynamic priority,
    dynamic serviceType,
    dynamic property,
    dynamic category,
    dynamic targetDate,
    dynamic manager,
    dynamic description,
    dynamic accessInstruction,
    List<dynamic>? photos,
    dynamic unitloc,
    dynamic engineers,
    dynamic issueType,
  }) async {
    try {
      dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;

      var data = {
        "service_type": serviceType,
        "type": "Regular",
        "request_type": "In Unit",
        "property": property,
        "category": category,
        "target_date": targetDate,
        "description": description,
        "access_instruction": accessInstruction,
        "unit_entry_permission": false,
        "property_entry_permission": false,
        "skip_site_visit": false,
        "request_feedback_on_close": false,
        "request_auto_response": false,
        "skip_bid": false,
        "courtesy_job": false,
        "request_completion_photos": false,
        "_vendors": [],
        "followers": [],
        "engineers_required": false,
        "engineers": [engineers],
        "photos": photos,
        "pm_assignee": manager,
        "issue_type": issueType,
        "priority": priority,
        "unit": unitloc,
      };
      await (CreateJobServices(
              service: Dio(BaseOptions(baseUrl: 'https://$baseurl1/v1/jobs/')))
          .uploadCreateJob(data));
    } catch (e) {
      print('error $e');
    }
  }

  nowDate() {
    return DateFormat('MM-dd-yyyy').format(DateTime.now());
  }

  mandatoryText(String? text) {
    return RichText(
      text: TextSpan(
          text: text,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          children: const [
            TextSpan(text: '*', style: TextStyle(color: Colors.red))
          ]),
      textAlign: TextAlign.start,
    );
  }

  // Future<dynamic> fileUpload(List<String> filepath, String url) async {
  //   var token = await storage.getToken();
  //   var idToken = await storage.getIdToken();
  //   Dio dio = Dio();

  //   List uploadList = [];

  //   FormData formData = FormData.fromMap({"assignment": uploadList});
  //   for (var file in filepath) {
  //     formData.files.addAll([
  //       MapEntry("assignment", await MultipartFile.fromFile(file)),
  //     ]);
  //     // var multipartFile = await MultipartFile.fromFile(
  //     //   file
  //     // );
  //     // uploadList.add(multipartFile);
  //   }

  //   var response = await dio.post(APIURL.baseUrl + url,
  //       data: formData,
  //       options: Options(headers: {
  //         HttpHeaders.authorizationHeader: "Bearer $token",
  //         'idToken': idToken,
  //       }));
  //   return response;
  // }

  bottomSheetDropDown(String titleText, int? itemCount,
      Widget? Function(BuildContext, int) itemBuilder) async {
    return await showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (context) {
          return DraggableScrollableSheet(
              initialChildSize: 0.7,
              minChildSize: 0.13,
              maxChildSize: 0.9,
              expand: false,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return FutureBuilder(builder: (context, snapshot) {
                  return Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ListTile(
                            leading: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon:
                                    const Icon(Icons.arrow_back_ios_new_sharp)),
                            title: Text(
                              titleText,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: itemCount,
                          itemBuilder: itemBuilder,
                        ),
                      ),
                    ],
                  );
                });
              });
        });
  }

  void onClearTap() {
    searchEditingController.clear();
  }
}
