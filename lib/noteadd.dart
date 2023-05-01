import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:juiesapk/controller/boxes.dart';
import 'package:juiesapk/controller/hivestore.dart';
import 'package:juiesapk/signup.dart';

class NotseaddScreen extends StatefulWidget {
  final String? text1;
  final String? text2;
  final String? text3;
  const NotseaddScreen({Key? key, this.text1, this.text2, this.text3})
      : super(key: key);

  @override
  State<NotseaddScreen> createState() => _NotseaddScreenState();
}

class _NotseaddScreenState extends State<NotseaddScreen> {
  late TextEditingController titlecontroler;
  late TextEditingController notecontoler;

  late CollectionReference<Map<String, dynamic>> fireStore;

  String? uid;

  @override
  void initState() {
    super.initState();
    authStore.subscription();
    titlecontroler = TextEditingController(text: widget.text1);
    notecontoler = TextEditingController(text: widget.text2);
    uid = authStore.getuid();

    var fire = FirebaseFirestore.instance;
    fireStore = fire.collection(uid!);
  }

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
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Add note",
                  style: TextStyle(
                      color: Colors.purple,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Alkatra'),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.edit,
                  color: Colors.purple,
                  size: 30,
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Column(
              children: [
                TextField(
                  controller: titlecontroler,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.edit),
                      filled: true,
                      fillColor: Color.fromARGB(192, 230, 225, 213),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 55, 22, 20), width: 2.0),
                      ),
                      hintText: 'Add title'),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  maxLines: 8,
                  controller: notecontoler,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(192, 230, 225, 213),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 55, 22, 20), width: 2.0),
                    ),
                    hintText: 'Note Write here',
                    //contentPadding: EdgeInsets.fromLTRB(12, 20, 12, 12),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Color.fromARGB(255, 95, 42, 89)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(width: 8.0),
                Observer(
                  builder: (context) => ElevatedButton(
                    child: Text('OK'),
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 95, 42, 89)),
                    onPressed: () {
                      if (authStore.isDeviceConnected) {
                        print('connnected');
                        if (widget.text1 == '' || widget.text2 == '') {
                          if (titlecontroler.text.isEmpty ||
                              notecontoler.text.isEmpty) {
                            // Show an error message if either title or note is empty
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Error"),
                                  content:
                                      Text("Title and note cannot be empty."),
                                  actions: [
                                    TextButton(
                                      child: Text(
                                        "OK",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 48, 29, 23)),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            String id = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();
                            fireStore.doc(id).set({
                              'title': titlecontroler.text.toString(),
                              'notes': notecontoler.text.toString(),
                              'id': id,
                            });

                            titlecontroler.clear();
                            notecontoler.clear();
                            Navigator.of(context).pop();
                          }
                        } else {
                          fireStore.doc(widget.text3).update({
                            'title': titlecontroler.text.toString(),
                            'notes': notecontoler.text.toString(),
                          });

                          titlecontroler.clear();
                          notecontoler.clear();

                          Navigator.of(context).pop();
                          authStore.LoadNote();
                        }
                      } else {
                        print('not connected');
                        final data = NotesModel(
                          titles: titlecontroler.text.toString(),
                          note: notecontoler.text.toString(),
                        );
                        final box = Boxes.getData();
                        box.add(data);
                        data.save();
                        titlecontroler.clear();
                        notecontoler.clear();
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
