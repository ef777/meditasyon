import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:meditasyon/models/kategorimodels.dart';

import '../models/kategorimodels.dart';
import '../models/kategorimodels.dart';

class KategoriController extends GetxController {
  static List<KategoriModel> kategorimodel = [];
  final firestoreInstance = FirebaseFirestore.instance;
  Future<List<KategoriModel>> ozelKategoriModelgetir(tip) async {
    QuerySnapshot querySnapshot = await firestoreInstance
        .collection('category')
        .where('tip', isEqualTo: "$tip")
        .get();
    List<KategoriModel> documents = [];

    if (querySnapshot.docs.isNotEmpty) {
      querySnapshot.docs.forEach((doc) {
        documents.add(KategoriModel.fromFirestore(doc));
      });
    }
    return documents;
  }

  Future<List<KategoriModel>> onKategoriModelgetir() async {
    QuerySnapshot querySnapshot =
        await firestoreInstance.collection('category').get();
    List<KategoriModel> documents = [];

    if (querySnapshot.docs.isNotEmpty) {
      querySnapshot.docs.forEach((doc) {
        documents.add(KategoriModel.fromFirestore(doc));
      });
    }
    return documents;
  }

  kategoriModelbastacek() async {
    kategorimodel = await onKategoriModelgetir();
  }
}
