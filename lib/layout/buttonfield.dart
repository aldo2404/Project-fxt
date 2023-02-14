import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fx_project/blocpattern/login_bloc/login_bloc.dart';

class Buttonfield {
  late Function() onpressed;

  clickButton(String text, onpressed) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        width: 300,
        child: State is LoginLoading
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        height: 25.0,
                        width: 25.0,
                        child: CupertinoActivityIndicator(),
                      )
                    ],
                  ))
                ],
              )
            : ElevatedButton(
                // ignore: sort_child_properties_last
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.orange[900]),
                    padding: const MaterialStatePropertyAll(
                        EdgeInsets.only(top: 10, bottom: 10))),
                onPressed: onpressed,
              ),
      ),
    );
  }
}
