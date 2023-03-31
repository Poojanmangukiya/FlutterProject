import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:juiesapk/home.dart';
import 'package:juiesapk/welcome.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Future.delayed(const Duration(seconds: 5), () {
    //  WidgetsBinding.instance!.addPostFrameCallback((_) => checkUserLogin());
    // });

    WidgetsBinding.instance!.addPostFrameCallback((_) => checkUserLogin());
  }

  void checkUserLogin() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePageBar()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelComePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.orange,
        child: Container(
          child: Image.asset(
              'assets/images/Screenshot_2023-03-31_153647-transformed.png'),
        ),
      ),
    );
  }
}
