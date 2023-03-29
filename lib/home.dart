import 'package:flutter/material.dart';

class HomePageBar extends StatefulWidget {
  const HomePageBar({Key? key}) : super(key: key);

  @override
  State<HomePageBar> createState() => _HomePageBarState();
}

class _HomePageBarState extends State<HomePageBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: 200, width: 500, color: Colors.pink, child: Text('Home')),
    );
  }
}
