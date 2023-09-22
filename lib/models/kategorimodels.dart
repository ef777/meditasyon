import 'package:cloud_firestore/cloud_firestore.dart';

class KategoriModel {
  final String tip;
  final String baslik;
  final String resimurl;
  final String oncelik;

  KategoriModel({
    required this.oncelik,
    required this.baslik,
    required this.resimurl,
    required this.tip,
  });

  factory KategoriModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return KategoriModel(
      baslik: data['baslik'],
      oncelik: data['oncelik'],
      resimurl: data['resimurl'],
      tip: data['tip'] ?? '',
    );
  }
}
