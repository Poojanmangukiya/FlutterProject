import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:juiesapk/home.dart';

import 'package:juiesapk/welcome.dart';

import 'homenew.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkUserLogin());
  }

  void checkUserLogin() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePageBar2()),
        );
      });
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const WelComePage()),
        );
      });
    }
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
        child: Container(
          child: Column(
            children: [
              Container(
                height: size.height * 0.5,
                width: size.width * 0.7,
                child: Image.asset(
                    'assets/images/Screenshot_2023-03-31_153647-transformed.png'),
              ),
              Text(
                'Welcome To The',
                style: TextStyle(
                    color: Color.fromARGB(255, 27, 26, 26),
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Alkatara'),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit, color: Colors.purple),
                  Text(
                    'Note App',
                    style: TextStyle(
                        fontFamily: 'Alkatara',
                        color: Color.fromARGB(255, 84, 37, 79),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
