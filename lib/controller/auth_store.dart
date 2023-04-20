import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:juiesapk/modelclass/documentinfo.dart';
import 'package:mobx/mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DocumentInfo documentinfo = DocumentInfo();

  @action
  String? getuid() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    return user?.uid;
  }

  @observable
  User? user;

  @observable
  String? docRef;

  @observable
  bool circuler = false;
  @action
  Future<bool> signUpWithEmailAndPassword(String email, String password,
      Function onSignUpSuccess, void Function(String? er) onerror) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      user = userCredential.user!;
      String uid = userCredential.user!.uid;

      docRef = uid;
      onSignUpSuccess(); // Call the callback function

      return true;
    } on FirebaseAuthException catch (e) {
      onerror(e.message);
      return false;
    } on PlatformException catch (e) {
      onerror(e.message);
      return false;
    }
  }

  @action
  Future<bool> signInWithEmailAndPassword(
    String email,
    String password,
    Function onSignInSuccess,
    void Function(String? er) onerror,
  ) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user!;

      String uid = userCredential.user!.uid;

      docRef = uid;
      // print('User created with ID: ${uid}');
      onSignInSuccess();
      return true;
    } on FirebaseAuthException catch (e) {
      onerror(e.message);
      return false;
    } on PlatformException catch (e) {
      onerror(e.message);
      return false;
    }
  }

  @action
  Future<void> signOutUser() async {
    await _auth.signOut();
    user = null;
  }

  @observable
  ObservableList<dynamic> notelist = ObservableList<dynamic>();

  @action
  Future<void> LoadNote() async {
    circuler = true;
    String uis = _auth.currentUser!.uid;
    print('jjfhfhf $uis');
    final response = await http.get(Uri.parse(
        'https://firestore.googleapis.com/v1/projects/flutter-login-app-1a2c3/databases/(default)/documents/$uis/'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      //notelist.addAll(data['documents']);
      documentinfo = DocumentInfo.fromJson(data);
      circuler = false;
    } else {
      throw Exception('Failed to load notelist');
    }
  }

  @action
  Future<void> Deltenote(String nid) async {
    String uis = _auth.currentUser!.uid;
    final response = await http.delete(Uri.parse(
        'https://firestore.googleapis.com/v1/projects/flutter-login-app-1a2c3/databases/(default)/documents/$uis/$nid/'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      //notelist.addAll(data['documents']);
      documentinfo = DocumentInfo.fromJson(data);
      LoadNote();
    } else {
      throw Exception('Failed to load notelist');
    }
  }

  @observable
  bool isDeviceConnected = true;
  @action
  void subscription() {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
    });
  }
}
