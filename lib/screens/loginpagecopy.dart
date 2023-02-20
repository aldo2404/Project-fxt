import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_project/constantbase/baseconstant.dart';
import 'package:fx_project/controller/login_controller.dart';
// import 'package:fx_project/authentication/api_login.dart';
import 'package:fx_project/layout/alertbox.dart';
import 'package:fx_project/layout/buttonfield.dart';
import 'package:fx_project/layout/input_field.dart';
import 'package:fx_project/screens/environmentpage.dart';
import 'package:fx_project/screens/forgotpasswordpage.dart';
import 'package:fx_project/services/loginservice.dart';
import '../layout/background_screen.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginPageCopy extends StatefulWidget {
  // final UserRepositories userRepositories;
  // const LoginPage({super.key, required this.userRepositories})
  //     : assert(userRepositories != null);
  const LoginPageCopy({super.key});

  @override
  // ignore: no_logic_in_create_state
  State<LoginPageCopy> createState() => _LoginPageCopyState();
}

class _LoginPageCopyState extends State<LoginPageCopy> {
  // final UserRepositories userRepositories;
  // _LoginPageState(this.userRepositories);

  final formfield = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  bool _isChecked = false;
  bool passToggle = true;

  late Box table1;
  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    loginTable();
    //});
  }

  void loginTable() async {
    table1 = await Hive.openBox('logindata');
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // onLoginButtonPressed() {
    //   BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
    //       email: emailcontroller.text, password: passcontroller.text));
    // }

    return Scaffold(
      resizeToAvoidBottomInset: false,

      //BlocListener<LoginBloc, LoginState>(
      // listener: (context, state) {
      //   if (state is LoginFailure) {
      //     ReuseAlertDialogBox().alertDialog(
      //         context, "Login Failed", "User not authorized to login");
      //   }
      // },
      // child: Scaffold(
      //   resizeToAvoidBottomInset: false,
      body: mainBody,
    );
  }

  Widget get mainBody {
    return BlocProvider(
      create: buildBlocProvider,
      child: bodyBlocConsumer,
    );
  }

  Widget get bodyBlocConsumer {
    return BlocConsumer<LoginCubit, LoginState>(
        listener: buildBlocListener,
        builder: (context, state) {
          return mainForm(context, state);
        });
  }

  Widget mainForm(BuildContext context, LoginState state) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        BackGroundImg().Images(),
        Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child:
              //  BlocBuilder<LoginBloc, LoginState>(
              //   builder: (context, state) {
              //     return
              Align(
            alignment: Alignment.center,
            heightFactor: MediaQuery.of(context).size.height,
            key: formfield,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 160),
                const Text("Welcome back!",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.white)),
                const SizedBox(height: 30),
                ReuseTextFields(
                  keyboardtypes: TextInputType.emailAddress,
                  text: "Username",
                  inputfieldcolor: Colors.white,
                  password: false,
                  controller: emailcontroller,
                  validate: ((value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
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
                  password: passToggle,
                  controller: passcontroller,
                  suffixs: InkWell(
                    onTap: () {
                      setState(() {
                        passToggle = !passToggle;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Icon(
                        passToggle ? Icons.visibility : Icons.visibility_off,
                        size: 16.0,
                      ),
                    ),
                  ),
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
                  padding: const EdgeInsets.only(top: 0, bottom: 0),
                  child: GestureDetector(
                    child: Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          side: const BorderSide(width: 2, color: Colors.white),
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
                //Buttonfield().
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    width: 300,
                    child: ElevatedButton(
                      child: state is LoginLoading
                          ? CircularProgressIndicator.adaptive()
                          : Text('Log In'),
                      // Text(
                      //   'Log In',
                      //   style: const TextStyle(
                      //     color: Colors.white,
                      //     fontSize: 16,
                      //   ),
                      //   textAlign: TextAlign.center,
                      // ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.orange[900]),
                          padding: const MaterialStatePropertyAll(
                              EdgeInsets.only(top: 10, bottom: 10))),
                      onPressed: () {
                        if (emailcontroller.text.isEmpty ||
                            passcontroller.text.isEmpty) {
                          ReuseAlertDialogBox().alertDialog(
                              context, "Alert", "please enter valid data");
                        }
                        if (formfield.currentState!.validate()) {
                          print(emailcontroller.text.toString());
                          print(passcontroller.text.toString());
                          // state is LoginLoading
                          //     ? const CircularProgressIndicator
                          //         .adaptive()
                          //     : const Text('Log In');

                          context
                              .read<LoginCubit>()
                              .onPressedLogin(emailcontroller, passcontroller);
                          login();
                          //onLoginButtonPressed();

                          // LoginAuthentication().getres(
                          //     emailcontroller.text.toString(),
                          //     passcontroller.text.toString());
                          print("data store sucess");
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (_) => const EnvironmentPage()));
                        } else {
                          print("Enter valied data");
                        }
                      },
                    ),
                  ),
                ),
                // clickButton("Log In", () {
                //   if (emailcontroller.text.isEmpty ||
                //       passcontroller.text.isEmpty) {
                //     ReuseAlertDialogBox().alertDialog(
                //         context, "Alert", "please enter valid data");
                //   }
                //   if (formfield.currentState!.validate()) {
                //     state is LoginLoading
                //         ? const CircularProgressIndicator.adaptive()
                //         : const Text('Log In');

                //     context.read<LoginCubit>().onPressedLogin(
                //         emailcontroller, passcontroller);
                //     login();
                //     //onLoginButtonPressed();
                //     print(emailcontroller.text.toString());
                //     print(passcontroller.text.toString());
                //     // LoginAuthentication().getres(
                //     //     emailcontroller.text.toString(),
                //     //     passcontroller.text.toString());
                //     print("data store sucess");
                //     // Navigator.of(context).push(MaterialPageRoute(
                //     //     builder: (_) => const EnvironmentPage()));
                //   } else {
                //     print("Enter valied data");
                //   }
                // }),
                Container(
                  width: 300,
                  padding: const EdgeInsets.only(top: 10, bottom: 0),
                  child: const Text(
                    "or",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                //Buttonfield().
                clickButton(
                  // state is LoginLoading
                  //         ? CircularProgressIndicator.adaptive()
                  //         : Text('Log In');

                  "Log In with SSO",
                  () {
                    setState(() {
                      state is LoginLoading
                          ? CircularProgressIndicator.adaptive()
                          : Text('Log In');
                    });
                  },
                ),
                //const SizedBox(height: 140),
                Align(
                  //height: 40,
                  alignment: Alignment.bottomCenter,
                  heightFactor: 12,
                  //width: 300,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const PasswordForgotPage()));
                      });
                    },
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
    );
  }
  //     ),
  //   ),
  // );

  void buildBlocListener(context, state) {
    if (state is LoginCompleted) {
      final data = state.loginModel;
      if (data.error != null) {
        ReuseAlertDialogBox().alertDialog(context, "Alert", data.error!);
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const EnvironmentPage()));
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Log In Success")));
      }
    }
  }

  LoginCubit buildBlocProvider(context) => LoginCubit(
        service: LoginService(
          service: Dio(BaseOptions(baseUrl: Constants.baseUrl)),
        ),
      );

  // Widget buildChild(LoginState state) {
  //   return state is LoginLoading
  //       ? CircularProgressIndicator.adaptive()
  //       : Text('Login');
  // }

  void login() {
    if (_isChecked) {
      table1.put('email', emailcontroller.text);
      table1.put('password', passcontroller.text);
    }
  }

  void getData() async {
    if (table1.get('email') != null) {
      emailcontroller.text = table1.get('email');
      _isChecked = true;
      setState(() {});
    }
    if (table1.get('password') != null) {
      passcontroller.text = table1.get('password');
      _isChecked = true;
      setState(() {});
    }
  }
}
