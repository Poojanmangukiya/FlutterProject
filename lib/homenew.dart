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
  @override
  void initState() {
    super.initState();
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
                var data = box.values.toList().cast<NotesModel>();
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
