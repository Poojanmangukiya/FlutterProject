import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:juiesapk/noteadd.dart';
import 'package:juiesapk/signup.dart';
import 'package:juiesapk/splash_screen.dart';

class HomePageBar extends StatefulWidget {
  const HomePageBar({Key? key}) : super(key: key);

  @override
  State<HomePageBar> createState() => _HomePageBarState();
}

class _HomePageBarState extends State<HomePageBar> {
  late var fireStore;
  String? uid;

  @override
  void initState() {
    super.initState();

    uid = authStore.getuid();
    print('cheak : ${uid}');
    var fire = FirebaseFirestore.instance;
    fireStore = fire.collection(uid!);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final fireStore = FirebaseFirestore.instance.collection(uid!).snapshots();
    final ref = FirebaseFirestore.instance.collection(uid!);
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/16399264_v640-peipei-16-modernbg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        height: size.height,
        width: size.width,
        //color: Colors.orange,
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
                  color: Color.fromARGB(255, 105, 46, 99),
                ),
                child: Center(
                  child: Text(
                    'Welcome To The Note App ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Alkatara'),
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
                        childAspectRatio: 0.8,
                      ),
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        " ${snapshot.data!.docs[index]['title'].toString()}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Row(
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
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NotseaddScreen(
                                                        text3:
                                                            '${snapshot.data!.docs[index]['id'].toString()}',
                                                        text1:
                                                            '${snapshot.data!.docs[index]['title'].toString()}',
                                                        text2:
                                                            '${snapshot.data!.docs[index]['notes'].toString()}',
                                                      )),
                                            );
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            color:
                                                Color.fromARGB(255, 34, 92, 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Color.fromARGB(255, 65, 34, 131),
                                thickness: 2,
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '${snapshot.data!.docs[index]['notes'].toString()}',
                                    style: TextStyle(
                                        fontSize: 15,
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
