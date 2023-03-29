import 'package:flutter/material.dart';

import 'home.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;

    void onTabTapped(int index) {
      if (index == 1) {
        // Open a new tab or screen for home icon
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => HomePageBar()));
      } else {
        setState(() {
          _currentIndex = index;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Morning Freshness '),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ],
      ),
      body: Container(
        child: Text('Shrre Ganeshay namh'),
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.search),
              label: 'seacrh',
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Contact',
            )
          ]),
    );
  }
}
