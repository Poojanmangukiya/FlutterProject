import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:juiesapk/controller/auth_store.dart';
import 'package:juiesapk/noteadd.dart';
import 'package:juiesapk/splash_screen.dart';

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
    final fireStore = FirebaseFirestore.instance.collection('user').snapshots();
    final ref = FirebaseFirestore.instance.collection('user');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
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
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.orange,
        child: Container(
          padding: EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            StreamBuilder<QuerySnapshot>(
                stream: fireStore,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return CircularProgressIndicator();

                  if (snapshot.hasError) return Text('some error');

                  return Expanded(
                    child: GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.8),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(192, 230, 225, 213),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Flexible(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        " ${snapshot.data!.docs[index]['title'].toString()}",
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Flexible(
                                        child: Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                ref
                                                    .doc(snapshot
                                                        .data!.docs[index]['id']
                                                        .toString())
                                                    .delete();
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {},
                                              child: Icon(
                                                Icons.edit,
                                                color: Color.fromARGB(
                                                    255, 34, 92, 20),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                                thickness: 2,
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '${snapshot.data!.docs[index]['notes'].toString()}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotseaddScreen()),
          );
          // CustomDilog.showAppalert(context,
          //     title: 'Enter Notes', button: Icons.add);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.brown,
      ),
    );
  }
}
