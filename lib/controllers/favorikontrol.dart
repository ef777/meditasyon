import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/meditasyonmodel.dart';

class FavKontroller extends GetxController {
  static void addToFavorites2(String id, String uid) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentReference userDoc =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      await userDoc.update({
        'fav': FieldValue.arrayUnion([id])
      });
    }
  }

  Future<List<String>> getFavoriteIds() async {
    print('getFavoriteIds');
    User? user = await FirebaseAuth.instance.currentUser;
    print(user);
    if (user != null) {
      print('user.uid: ' + user.uid);
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        print('userDoc.exists');

        var _favoriteIds = await List<String>.from(
            (userDoc.data()! as Map<String, dynamic>)['fav'] ?? [""]);

        if (_favoriteIds == Null) {
          _favoriteIds = [""];
        }
        print("favoriteIds");
        print(_favoriteIds);
        return await _favoriteIds;
      } else {
        print('userDoc does not exist');
        return [""];
      }
    }
    return [
      ""
    ]; // Return an empty list if user is null or userDoc does not exist
  }

  Future<List<Meditasyon>> getFavoriteMeditations(_favoriteIds) async {
    print('getFavoriteMeditations');
    List<Meditasyon> meditations = [];
    await FirebaseFirestore.instance
        .collection('meds')
        .where('id', whereIn: _favoriteIds ?? [""])
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        meditations.add(Meditasyon.fromFirestore(doc));
      });
      print("meditations");
      print(meditations);
    });
    return meditations;
  }

  void removeFromFavorites(String id) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentReference userDoc =
          FirebaseFirestore.instance.collection('users').doc(user.uid);

      await userDoc.update({
        'fav': FieldValue.arrayRemove([id])
      });
      getFavoriteIds();
    }
  }
}
