import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:meditasyon/models/programmodels.dart';

class ProgramController extends GetxController {
  static List<ProgramlarModels> canlisprogram = [];
  static List<ProgramlarModels> canlisertifika = [];

  final firestoreInstance = FirebaseFirestore.instance;

  // tip 1 canlı eğitim
  // tip2 sertifika eğitim
  Future<List<ProgramlarModels>> ozelProgramlarModelsgetir(tip) async {
    QuerySnapshot querySnapshot = await firestoreInstance
        .collection('category')
        .where('tip', isEqualTo: "$tip")
        .get();
    List<ProgramlarModels> documents = [];

    if (querySnapshot.docs.isNotEmpty) {
      querySnapshot.docs.forEach((doc) {
        documents.add(ProgramlarModels.fromFirestore(doc));
      });
    }
    return documents;
  }

  Future<Map<String, List<ProgramlarModels>>> onProgramlarModelsgetir() async {
    QuerySnapshot querySnapshot =
        await firestoreInstance.collection('programvesertifika').get();
    List<ProgramlarModels> tip1Documents = [];
    List<ProgramlarModels> tip2Documents = [];

    if (querySnapshot.docs.isNotEmpty) {
      querySnapshot.docs.forEach((doc) {
        ProgramlarModels model = ProgramlarModels.fromFirestore(doc);
        if (model.tip == "1") {
          tip1Documents.add(model);
        } else if (model.tip == "2") {
          tip2Documents.add(model);
        }
      });
    }
    return {"tip1": tip1Documents, "tip2": tip2Documents};
  }

  Future<void> programbastacek() async {
    Map<String, List<ProgramlarModels>> programlar =
        await onProgramlarModelsgetir();
    print("fonksiyonda çekilen fonkslar");
    canlisprogram = programlar["tip1"]!;

    canlisprogram
        .sort((a, b) => int.parse(a.oncelik).compareTo(int.parse(b.oncelik)));

    canlisertifika = programlar["tip2"]!;

    canlisertifika
        .sort((a, b) => int.parse(a.oncelik).compareTo(int.parse(b.oncelik)));

    // Burada tip1Programlar ve tip2Programlar listelerinde "tip" değeri sırasıyla 1 ve 2 olan program verileri var.
    // Bu listeleri istediğiniz gibi kullanabilirsiniz.
  }
}
