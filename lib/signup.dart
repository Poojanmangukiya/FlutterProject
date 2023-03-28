import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'controller/signup_controller.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    final _formKey = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.orange,
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            height: size.height * 0.5,
            width: size.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(161, 233, 98, 20),

              //boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey)]
            ),
            child: Form(
              key: _formKey,
              child: Column(children: [
                TextField(
                  controller: controller.fullname,
                  decoration: InputDecoration(
                      fillColor: Color.fromARGB(141, 232, 229, 207),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      hintText: 'Enter Username '),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                TextField(
                  controller: controller.email,
                  decoration: InputDecoration(
                      fillColor: Color.fromARGB(141, 232, 229, 207),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      hintText: 'Enter Email '),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                TextField(
                  controller: controller.phoneNo,
                  decoration: InputDecoration(
                      fillColor: Color.fromARGB(141, 232, 229, 207),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      hintText: 'Enter Phonenumber '),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                TextField(
                  controller: controller.password,
                  decoration: InputDecoration(
                      fillColor: Color.fromARGB(141, 232, 229, 207),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      hintText: 'Enter Password '),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 0, 0, 0)),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      SignupController.instance.registerUser(
                          controller.email.text.trim(),
                          controller.password.text.trim());
                    }
                  },
                  child: Text('Sign up'),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
