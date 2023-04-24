import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:juiesapk/controller/auth_store.dart';
import 'package:juiesapk/controller/boxes.dart';
import 'package:juiesapk/controller/hivestore.dart';
import 'package:juiesapk/noteadd.dart';
import 'package:juiesapk/splash_screen.dart';

class HomePageBar2 extends StatefulWidget {
  const HomePageBar2({Key? key}) : super(key: key);

  @override
  State<HomePageBar2> createState() => _HomePageBarState();
}

class _HomePageBarState extends State<HomePageBar2> {
  AuthStore authStore = AuthStore();
  late CollectionReference<Map<String, dynamic>> fireStore;

  String? uid;
  final box = Hive.box<NotesModel>('notes');
  @override
  void initState() {
    super.initState();
    uid = authStore.getuid();

    var fire = FirebaseFirestore.instance;
    fireStore = fire.collection(uid!);
    authStore.subscription();
    authStore.LoadNote();
    authStore.circuler == false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 105, 46, 99),
        title: Text('Notes App without snapshot'),
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
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Observer(
              builder: (context) {
                if (authStore.circuler == true) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    itemCount: authStore.documentinfo.documents?.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            Text(authStore.documentinfo.documents![index].fields
                                .notes.stringValue),
                            Text(authStore.documentinfo.documents![index].fields
                                .title.stringValue),
                            InkWell(
                                onTap: () {
                                  String nid = authStore.documentinfo
                                      .documents![index].fields.id!.stringValue;

                                  authStore.Deltenote(nid);
                                },
                                child: Icon(Icons.delete)),
                            InkWell(onTap: () {}, child: Icon(Icons.edit)),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: ValueListenableBuilder<Box<NotesModel>>(
              valueListenable: Boxes.getData().listenable(),
              builder: (context, box, _) {
                List<NotesModel> data = box.values.toList();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(blurRadius: 20, color: Colors.grey),
                              ],
                              color: Color.fromARGB(148, 77, 231, 213)),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data[index].titles,
                                      style: TextStyle(
                                          fontSize: 19,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      data[index].note,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        // delete(data[index]);
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                  InkWell(
                                      onTap: () {
                                        // CoustomDialog.showAppalert(
                                        //   context,
                                        //   title: 'Edit Note',
                                        //   button1: Icons.edit,
                                        //   editNote: data[index],
                                        // );
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: Color.fromARGB(255, 19, 95, 22),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (authStore.isDeviceConnected) {
                box.values.forEach((note) {
                  String id = DateTime.now().millisecondsSinceEpoch.toString();
                  fireStore.doc(id).set({
                    'title': note.titles.toString(),
                    'notes': note.note.toString(),
                    'id': id,
                  });

                  print('Title: ${note.titles}');
                  print('Note: ${note.note}');
                  print('-----------------');
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Internet connected'),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Internet is not connected'),
                  ),
                );
              }
            },
            child: Text('Sync Now'),
          ),
        ],
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
