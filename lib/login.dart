import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

final _username = TextEditingController();
final _password = TextEditingController();

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
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
                controller: _username,
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
                controller: _password,
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
                onPressed: () {},
                child: Text('Login'),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
