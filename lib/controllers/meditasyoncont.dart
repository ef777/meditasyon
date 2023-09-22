import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/meditasyonmodel.dart';

class MeditasyonController extends GetxController {
  static List<Meditasyon> meditasyon = [];
  final firestoreInstance = FirebaseFirestore.instance;
  Future<List<Meditasyon>> ozelmeditasyongetir(tip) async {
    QuerySnapshot querySnapshot = await firestoreInstance
        .collection('meds')
        .where('tip', isEqualTo: '$tip')
        .get();
    List<Meditasyon> documents = [];

    if (querySnapshot.docs.isNotEmpty) {
      querySnapshot.docs.forEach((doc) {
        documents.add(Meditasyon.fromFirestore(doc));
      });
    }
    return documents;
  }

  Future<List<Meditasyon>> onmeditasyongetir() async {
    QuerySnapshot querySnapshot = await firestoreInstance
        .collection('meds')
        .where('onecikan', isEqualTo: '1')
        .get();
    List<Meditasyon> documents = [];

    if (querySnapshot.docs.isNotEmpty) {
      querySnapshot.docs.forEach((doc) {
        documents.add(Meditasyon.fromFirestore(doc));
      });
    }
    return documents;
  }

  meditasyonbastacek() async {
    meditasyon = await onmeditasyongetir();
  }
}
