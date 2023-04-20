import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:juiesapk/controller/auth_store.dart';
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
      body: Observer(
        builder: (context) {
          if (!authStore.circuler) {
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
                      Text(authStore.documentinfo.documents![index].fields.notes
                          .stringValue),
                      Text(authStore.documentinfo.documents![index].fields.title
                          .stringValue),
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
