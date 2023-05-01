import 'package:flutter/material.dart';
import 'package:juiesapk/homenew.dart';

import 'controller/auth_store.dart';
import 'home.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

AuthStore authStore = AuthStore();

class _LogInPageState extends State<LogInPage> {
  void _onSignInSuccess() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePageBar2()),
    );
  }

  void _onerror(String? er) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(er ?? ""),
      ),
    );
  }

  final email = TextEditingController();
  final password = TextEditingController();
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
                'Please Login here',
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
                height: size.height * 0.31,
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
                        hintText: 'Enter Email Adress '),
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
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 105, 46, 99)),
                    ),
                    onPressed: () async {
                      bool success = await authStore.signInWithEmailAndPassword(
                        email.text,
                        password.text,
                        _onSignInSuccess,
                        _onerror,
                      );
                      if (!success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to Login.'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('succesfully to Login.'),
                          ),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 45, right: 45),
                      child: Text('Login'),
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
