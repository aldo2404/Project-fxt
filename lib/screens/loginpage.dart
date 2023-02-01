import 'package:flutter/material.dart';
import 'package:fx_project/authentication/api_login.dart';
import 'package:fx_project/layout/buttonfield.dart';
import 'package:fx_project/layout/input_field.dart';
import '../layout/background_screen.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formfield = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  bool _isChecked = false;

  late Box table1;
  @override
  void initState() {
    super.initState();
    loginTable();
  }

  void loginTable() async {
    table1 = await Hive.openBox('logindata');
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          BackGroundImg().Images(),
          Align(
            heightFactor: MediaQuery.of(context).size.height,
            child: Form(
              key: formfield,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //SizedBox(height: 65),
                  // Container(
                  //   // height: 100,
                  //   // width: 110,
                  //   child: Image.asset(
                  //     "assets/image/splashlogo.png",
                  //     // fit: BoxFit.fitWidth,
                  //   ),
                  // ),
                  SizedBox(height: 80),
                  const Text("Welcome back!",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                  SizedBox(height: 30),
                  ReuseTextFields(
                    keyboardtypes: TextInputType.emailAddress,
                    text: "Username",
                    inputfieldcolor: Colors.white,
                    password: false,
                    controller: emailcontroller,
                    validate: ((value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2}")
                              .hasMatch(value)) {
                        return 'Enter correct email id';
                      }
                      return null;
                    }),
                    //  MultiValidator([
                    //   RequiredValidator(errorText: "*Required"),
                    //   EmailValidator(errorText: "Enter valid email")
                    // ]),
                  ),
                  ReuseTextFields(
                    keyboardtypes: TextInputType.visiblePassword,
                    text: "Password",
                    inputfieldcolor: Colors.white,
                    password: true,
                    controller: passcontroller,
                    validate: MultiValidator([
                      RequiredValidator(errorText: "*Required"),
                      MinLengthValidator(6,
                          errorText: "password lenght too short"),
                      MaxLengthValidator(15,
                          errorText: "Password length too high")
                    ]),
                  ),
                  Container(
                    //height: 35,
                    width: 300,
                    padding: EdgeInsets.only(top: 0, bottom: 10),
                    child: GestureDetector(
                      child: Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            side: BorderSide(width: 2, color: Colors.white),
                            value: _isChecked,
                            onChanged: (value) {
                              _isChecked = !_isChecked;
                              setState(() {});
                            },
                          ),
                          const Text(
                            "Remember me",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      onTap: () => setState(() {
                        _isChecked = !_isChecked;
                      }),
                    ),
                  ),
                  Buttonfield().clickButton(
                    "Log In",
                    () {
                      if (formfield.currentState!.validate()) {
                        login();
                        print(emailcontroller.text.toString());
                        print(passcontroller.text.toString());
                        LoginAuthentication().getres(
                            emailcontroller.text.toString(),
                            passcontroller.text.toString());
                        print("data store sucess");
                        Navigator.of(context).pushNamed('/environmentpage');
                      } else {
                        print("Enter valied data");
                      }
                    },
                  ),
                  Container(
                    // height: 25,
                    width: 300,
                    padding: EdgeInsets.only(top: 10, bottom: 20),

                    child: const Text(
                      "or",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Buttonfield().clickButton(
                    "Log In with SSO",
                    () {},
                  ),
                  const SizedBox(height: 140),
                  SizedBox(
                    //height: 40,
                    width: 300,
                    child: GestureDetector(
                      onTap: (() {
                        setState(() {
                          Navigator.of(context)
                              .pushNamed('/passwordforgotpage');
                        });
                      }),
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void login() {
    if (_isChecked) {
      table1.put('email', emailcontroller.text);
      table1.put('pass', passcontroller.text);
    }
  }

  void getData() async {
    if (table1.get('email') != null) {
      emailcontroller.text = table1.get('email');
      _isChecked = true;
      setState(() {});
    }
    if (table1.get('pass') != null) {
      passcontroller.text = table1.get('pass');
      _isChecked = true;
      setState(() {});
    }
  }
}
