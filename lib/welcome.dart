import 'package:flutter/material.dart';
import 'package:juiesapk/login.dart';
import 'package:juiesapk/signup.dart';

class WelComePage extends StatefulWidget {
  const WelComePage({Key? key}) : super(key: key);

  @override
  State<WelComePage> createState() => _WelComePageState();
}

class _WelComePageState extends State<WelComePage> {
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
          child: Container(
            padding: EdgeInsets.all(10),
            height: size.height * 0.28,
            width: size.width * 0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(193, 206, 151, 200)

                //boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey)]
                ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Welcome To \n The Note App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Alkatra",
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(223, 14, 14, 13),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 155, 68, 146)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LogInPage()),
                      );
                    },
                    child: Text('Login'),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 155, 68, 146)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignupPage()),
                      );
                    },
                    child: Text('Sign up'),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
