import 'package:cloud_firestore/cloud_firestore.dart';

class Meditasyon {
  final String tarih;
  final String oncelik;

  final String baslik;
  final String dakika;
  final String aktif;
  final String kimden;
  final String resimurl;
  final String sesurl;
  final String onecikan;
  final String id;
  final String tip;
  final String premium;

  Meditasyon({
    required this.oncelik,
    required this.tarih,
    required this.tip,
    required this.baslik,
    required this.dakika,
    required this.aktif,
    required this.kimden,
    required this.resimurl,
    required this.sesurl,
    required this.onecikan,
    required this.premium,
    required this.id,
  });

  factory Meditasyon.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Meditasyon(
      tarih: data['tarih'],
      oncelik: data['oncelik'],
      premium: data['premium'],
      tip: data['tip'],
      id: data['id'] ?? "0",
      baslik: data['baslik'],
      dakika: data['dakika'],
      aktif: data['aktif'],
      kimden: data['kimden'],
      resimurl: data['resimurl'],
      sesurl: data['sesurl'],
      onecikan: data['onecikan'],
    );
  }
}
