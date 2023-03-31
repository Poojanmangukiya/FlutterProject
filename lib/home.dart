import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:juiesapk/controller/auth_store.dart';

class HomePageBar extends StatefulWidget {
  const HomePageBar({Key? key}) : super(key: key);

  @override
  State<HomePageBar> createState() => _HomePageBarState();
}

AuthStore authStore = AuthStore();

class _HomePageBarState extends State<HomePageBar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text('Notes App'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.menu),
          )
        ],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.orange,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: size.width,
              height: size.height * 0.05,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.brown,
              ),
              child: Center(
                child: Text(
                  'Welcome _user name Note App ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: 7,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.8),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 1,
                  width: 1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(192, 230, 225, 213),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "title",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "in this type user can add chat in that app ,that was the example of how user can store data. ",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.brown,
      ),
    );
  }
}
