import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User?> firebaseUser = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    // Listen for changes in the user's authentication state
    _auth.authStateChanges().listen((User? user) {
      firebaseUser.value = user;
    });
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
