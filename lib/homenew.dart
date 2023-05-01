import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
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
                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: size.height * 0.08,
                              width: size.width * 0.85,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(137, 169, 84, 184),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          authStore
                                              .documentinfo
                                              .documents![index]
                                              .fields
                                              .notes
                                              .stringValue,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          authStore
                                              .documentinfo
                                              .documents![index]
                                              .fields
                                              .title
                                              .stringValue,
                                          style: TextStyle(
                                              color:
                                                  Color.fromARGB(167, 0, 0, 0),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              String nid = authStore
                                                  .documentinfo
                                                  .documents![index]
                                                  .fields
                                                  .id!
                                                  .stringValue;

                                              authStore.Deltenote(nid);
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            )),
                                        InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        NotseaddScreen(
                                                          text3:
                                                              '${authStore.documentinfo.documents![index].fields.id!.stringValue}',
                                                          text1:
                                                              '${authStore.documentinfo.documents![index].fields.title.stringValue}',
                                                          text2:
                                                              '${authStore.documentinfo.documents![index].fields.notes.stringValue}',
                                                        )),
                                              );
                                            },
                                            child: Icon(
                                              Icons.edit,
                                              color: Color.fromARGB(
                                                  255, 36, 102, 38),
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                  height: size.height * 0.05,
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                    'Offline Data',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ))),
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
                                    BoxShadow(
                                        blurRadius: 20, color: Colors.grey),
                                  ],
                                  color: Color.fromARGB(148, 77, 231, 213)),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            color:
                                                Color.fromARGB(255, 19, 95, 22),
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
              SizedBox(
                width: size.width * 0.9,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple, // Set background color
                  ),
                  onPressed: () {
                    if (authStore.isDeviceConnected) {
                      box.values.forEach((note) {
                        String id =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        fireStore.doc(id).set({
                          'title': note.titles.toString(),
                          'notes': note.note.toString(),
                          'id': id,
                        });

                        print('Title: ${note.titles}');
                        print('Note: ${note.note}');
                        print('-----------------');
                      });
                      box.clear();
                      authStore.LoadNote();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Internet connected'),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Plese cheak Internet. Internet is not connected'),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Sync Now',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
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
