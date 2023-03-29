import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:juiesapk/dashbord.dart';
import 'package:juiesapk/welcome.dart';

class AuthenticationRepo extends GetxController {
  static AuthenticationRepo get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseuser;

  @override
  void onReady() {
    firebaseuser = Rx<User?>(_auth.currentUser);
    firebaseuser.bindStream(_auth.userChanges());
    ever(firebaseuser, _setIntialScreen);
  }

  _setIntialScreen(User? user) {
    user == null
        ? Get.offAll(() => const WelComePage())
        : Get.offAll(() => const DashBoard());
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseuser.value != null
          ? Get.to(() => const DashBoard())
          : Get.to(() => WelComePage());
    } on FirebaseAuthException catch (e) {
    } catch (e) {
      print(e);
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
    } catch (_) {}
  }

  Future<void> logout() async => await _auth.signOut();
}
