import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// class MyListView extends StatefulWidget {
//   @override
//   _MyListViewState createState() => _MyListViewState();
// }

// class _MyListViewState extends State<MyListView> {
//   List<dynamic> _documents = [];

//   Future<void> _fetchData() async {
//     final response = await http.get(Uri.parse(
//         'https://firestore.googleapis.com/v1/projects/flutter-login-app-1a2c3/databases/(default)/documents/SNp9dqGZsKSS33iyl2P8MpjsHlt2/'));
//     final data = json.decode(response.body);
//   }

//   @override
//   void initState() {
//     super.initState();
//     _fetchData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My List View'),
//       ),
//       body: ListView.builder(
//         itemCount: _documents.length,
//         itemBuilder: (context, index) {
//           print(_documents[index]);
//           return Card(
//             child: Column(
//               children: [
//                 Text(_documents[index]['fields']['title']['stringValue']),
//                 Text(_documents[index]['fields']['notes']['stringValue']),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

///////////////////////////////////////////////////////////////////////////
///
///
///
///
///////////////////////////////////////////////////////////////////////////
///

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:juiesapk/controller/auth_store.dart';
import 'package:juiesapk/noteadd.dart';
import 'package:juiesapk/signup.dart';
import 'package:juiesapk/splash_screen.dart';

class HomePageBar2 extends StatefulWidget {
  const HomePageBar2({Key? key}) : super(key: key);

  @override
  State<HomePageBar2> createState() => _HomePageBarState();
}

class _HomePageBarState extends State<HomePageBar2> {
  AuthStore authStore = AuthStore();
  @override
  void initState() {
    super.initState();
    authStore.LoadNote();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 105, 46, 99),
        title: Text('Notes App'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  authStore.signOutUser();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SplashScreen()),
                  );
                },
                child: Icon(Icons.menu)),
          )
        ],
      ),
      body: Observer(
        builder: (context) => ListView.builder(
          itemCount: authStore.notelist.length,
          itemBuilder: (context, index) {
            final product = authStore.notelist[index];
            //  print(_documents[index]);
            return Card(
              child: Column(
                children: [
                  Text(product[index]['fields']['title']['stringValue']),
                  Text(product[index]['fields']['notes']['stringValue']),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const NotseaddScreen(
                      text1: '',
                      text2: '',
                    )),
          );
          // CustomDilog.showAppalert(context,
          //     title: 'Enter Notes', button: Icons.add);
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 105, 46, 99),
      ),
    );
  }
}
