import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:juiesapk/splash_screen.dart';

import 'controller/auth_store.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

AuthStore authStore = AuthStore();

class _SignupPageState extends State<SignupPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  void _onSignUpSuccess() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SplashScreen()),
    );
  }

  void _onerror(String? er) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(er ?? ""),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/16399264_v640-peipei-16-modernbg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Please Signup here',
                style: TextStyle(
                    color: Color.fromARGB(255, 155, 68, 146),
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Alkatra'),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.all(10),
                height: size.height * 0.28,
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(174, 188, 86, 178),

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
                            Color.fromARGB(255, 105, 46, 99)),
                      ),
                      onPressed: () async {
                        bool success =
                            await authStore.signUpWithEmailAndPassword(
                          email.text,
                          password.text,
                          _onSignUpSuccess,
                          _onerror,
                        );
                        if (!success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to sign up.'),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('succesfully to Sign up.'),
                            ),
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 45, right: 45),
                        child: Text('Sign up'),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
