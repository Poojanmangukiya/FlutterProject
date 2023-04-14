import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
  // @observable
  // String? er;

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
  List<dynamic> notelist = [];

  @action
  Future<void> LoadNote() async {
    final response = await http.get(Uri.parse(
        'https://firestore.googleapis.com/v1/projects/flutter-login-app-1a2c3/databases/(default)/documents/SNp9dqGZsKSS33iyl2P8MpjsHlt2/'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      notelist.addAll(data['documents']);
    } else {
      throw Exception('Failed to load notelist');
    }
  }
}
