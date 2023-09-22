import 'package:cloud_firestore/cloud_firestore.dart';

class ProgramlarModels {
  final String oncelik;
  final String tip;
  final String disresimurl;
  final String kimden;
  final String aciklama;
  final String gidecekurl;
  final String aktif;

  final String baslik;

  ProgramlarModels({
    required this.oncelik,
    required this.aciklama,
    required this.disresimurl,
    required this.kimden,
    required this.gidecekurl,
    required this.baslik,
    required this.tip,
    required this.aktif,
  });

  factory ProgramlarModels.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return ProgramlarModels(
      oncelik: data['oncelik'] ?? '',
      disresimurl: data['disresimurl'] ?? '',
      kimden: data['kimden'] ?? '',
      aciklama: data['aciklama'] ?? '',
      baslik: data['baslik'] ?? '',
      gidecekurl: data['gidecekurl'] ?? '',
      tip: data['tip'] ?? '',
      aktif: data['aktif'] ?? '',
    );
  }
}
