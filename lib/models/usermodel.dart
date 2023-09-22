import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String email;
  String name;
  String profileImageUrl;

  UserModel(
      {required this.uid,
      required this.email,
      required this.name,
      required this.profileImageUrl});

  UserModel.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : uid = snapshot.id,
        email = snapshot.get('email') as String,
        name = snapshot.get('name') as String,
        profileImageUrl = snapshot.get('profileImageUrl') as String;
}

class UserController extends GetxController {
  static UserModel? _user;
  static UserModel? get user => _user;

  getusername() {
    return _user!.name;
  }

  checkuser() {
    if (_user == null) {
      return false;
    } else {
      return true;
    }
  }

  void setUser(UserModel user) {
    _user = user;
    update();
  }

  Future<void> fetchUserData(String uid) async {
    try {
      final userData =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final user = UserModel.fromDocumentSnapshot(userData);
      setUser(user);
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateUserData(String name, String profileImageUrl) async {
    try {
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(_user!.uid);

      await userRef.update({'name': name, 'profileImageUrl': profileImageUrl});

      final updatedUserData = await userRef.get();
      final updatedUser = UserModel.fromDocumentSnapshot(updatedUserData);
      setUser(updatedUser);
    } catch (e) {
      print(e);
    }
  }
}
