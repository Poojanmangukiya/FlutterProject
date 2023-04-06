import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  @action
  Future<bool> signUpWithEmailAndPassword(
      String email, String password, Function onSignUpSuccess) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      user = userCredential.user!;
      String uid = userCredential.user!.uid;

      docRef = uid;
      onSignUpSuccess(); // Call the callback function

      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return false;
    }
  }

  @action
  Future<bool> signInWithEmailAndPassword(
      String email, String password, Function onSignInSuccess) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user!;

      String uid = userCredential.user!.uid;

      docRef = uid;
      print('User created with ID: ${uid}');
      onSignInSuccess();
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return false;
    }
  }

  @action
  Future<void> signOutUser() async {
    await _auth.signOut();
    user = null;
  }
}
