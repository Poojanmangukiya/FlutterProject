import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:juiesapk/home.dart';

import 'controller/auth_store.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

AuthStore authStore = AuthStore();

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final password = TextEditingController();
    final fullname = TextEditingController();
    final phoneNo = TextEditingController();

    void _onSignUpSuccess() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePageBar()),
      );
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.orange,
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            height: size.height * 0.28,
            width: size.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(161, 233, 98, 20),

              //boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey)]
            ),
            child: Column(children: [
              TextField(
                controller: email,
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
                controller: password,
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
              Observer(
                builder: (context) => ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 90, 63, 54)),
                  ),
                  onPressed: () async {
                    bool success = await authStore.signUpWithEmailAndPassword(
                      email.text,
                      password.text,
                      _onSignUpSuccess,
                    );
                    if (!success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to sign up.'),
                        ),
                      );
                    }

                    //authStore.signUpWithEmailAndPassword( email.text, password.text);
                  },
                  child: Text('Sign up'),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
