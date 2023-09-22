import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'config.dart';

class Statistic extends GetxController {
  static var statisticbelge;

  gunlukpaketyenilemeekle(String belge, double kazanc) async {
    print('gunlukpaketyenileme data getiriliyor');

    CollectionReference statistic =
        FirebaseFirestore.instance.collection('statistics');
    print(belge.toString());
    print(' belge');
    DocumentReference belgeReferansi = statistic.doc(belge);
    DocumentSnapshot doc = await belgeReferansi.get();
    if (doc.exists) {
      print('Belge bulundu.');
      final dat = doc.data();

      if (dat is Map<String, dynamic>) {
        print('döküman okundu');
        double kullanici = dat['dailyNewSubscriptions'].toDouble();

        double son = kullanici + 1;

        await belgeReferansi.update({
          'dailyNewSubscriptions': son,
        });

        print('gunlukpaketyenileme adeti eklendi');
      } else {
        print('gunlukpaketyenileme adeti  hatası.');
        return null;
      }
    } else {
      print('gunlukpaketyenileme adeti bulunamadı.');
      return null;
    }
  }

  gunlukkazancekle(String belge, double kazanc) async {
    print('gunlukkazancekle data getiriliyor');

    CollectionReference statistic =
        FirebaseFirestore.instance.collection('statistics');
    print(belge.toString());
    print(' belge');
    DocumentReference belgeReferansi = statistic.doc(belge);
    DocumentSnapshot doc = await belgeReferansi.get();
    if (doc.exists) {
      print('Belge bulundu.');
      final dat = doc.data();

      if (dat is Map<String, dynamic>) {
        print('döküman okundu');
        double kullanici = dat['dailyTotalRevenue'].toDouble();

        double son = kullanici + kazanc;

        await belgeReferansi.update({
          'dailyTotalRevenue': son,
        });

        print('gunlukkazancekle adeti eklendi');
      } else {
        print('gunlukkazancekle adeti  hatası.');
        return null;
      }
    } else {
      print('gunlukkazancekle adeti bulunamadı.');
      return null;
    }
  }

  gunlukdinleyensayisiekle(
    String belge,
  ) async {
    print('gunlukdinleyensayisiekle data getiriliyor');

    CollectionReference statistic =
        FirebaseFirestore.instance.collection('statistics');
    print(belge.toString());
    print(' belge');
    DocumentReference belgeReferansi = statistic.doc(belge);
    DocumentSnapshot doc = await belgeReferansi.get();
    if (doc.exists) {
      print('Belge bulundu.');
      final dat = doc.data();

      if (dat is Map<String, dynamic>) {
        print('döküman okundu');
        double kullanici = dat['dailyUniqueListeners'].toDouble();

        double son = kullanici + 1;

        await belgeReferansi.update({
          'dailyUniqueListeners': son,
        });

        print('gunlukdinleyensayisiekle adeti eklendi');
      } else {
        print('gunlukdinleyensayisiekle adeti  hatası.');
        return null;
      }
    } else {
      print('gunlukdinleyensayisi adeti bulunamadı.');
      return null;
    }
  }

  gunllukkullaniciekle(
    String belge,
  ) async {
    print('kullanici data getiriliyor');
    print('yeni kullanici istatisitk eklendi');

    CollectionReference statistic =
        FirebaseFirestore.instance.collection('statistics');
    print(belge.toString());
    print(' belge');
    DocumentReference belgeReferansi = statistic.doc(belge);
    DocumentSnapshot doc = await belgeReferansi.get();
    if (doc.exists) {
      print('Belge bulundu.');
      final dat = doc.data();

      if (dat is Map<String, dynamic>) {
        print('döküman okundu');
        double kullanici = dat['dailyNewUsers'].toDouble();

        double son = kullanici + 1;

        await belgeReferansi.update({
          'dailyNewUsers': son,
        });

        print('yenikullanici adeti eklendi');
      } else {
        print('yenikullanici adeti  hatası.');
        return null;
      }
    } else {
      print('yenikullanici adeti bulunamadı.');
      return null;
    }
  }

  dinlemeadetiekle(String belge) async {
    print('statistic data getiriliyor');

    CollectionReference statistic =
        FirebaseFirestore.instance.collection('statistics');
    print(belge.toString());
    print(' belge');
    DocumentReference belgeReferansi = statistic.doc(belge);
    DocumentSnapshot doc = await belgeReferansi.get();
    if (doc.exists) {
      print('Belge bulundu.');
      final dat = doc.data();

      if (dat is Map<String, dynamic>) {
        print('döküman okundu');
        double dinlemeadet = dat['dailyMdPlays'].toDouble();

        double son = dinlemeadet + 1;

        await belgeReferansi.update({
          'dailyMdPlays': son,
        });

        print('med adet eklendi');
      } else {
        print('med adet hatası.');
        return null;
      }
    } else {
      print('med dakika dosyası bulunamadı.');
      return null;
    }
  }

  dakikaekledata(String belge, double ekdakika) async {
    print('statistic data getiriliyor');

    CollectionReference statistic =
        FirebaseFirestore.instance.collection('statistics');
    print(belge.toString());
    print(' belge');
    DocumentReference belgeReferansi = statistic.doc(belge);
    DocumentSnapshot doc = await belgeReferansi.get();
    if (doc.exists) {
      print('Belge bulundu.');
      final dat = doc.data();

      if (dat is Map<String, dynamic>) {
        print('döküman okundu');
        double dakika = dat['dailyMdListens'].toDouble();

        double son = dakika + ekdakika;

        await belgeReferansi.update({
          'dailyMdListens': son,
        });

        print('dakika eklendi');
      } else {
        print('dakika hatası.');
        return null;
      }
    } else {
      print('dakika dosyası bulunamadı.');
      return null;
    }
  }

  static Future<String> getrefadress() async {
    print("getrefadress fonk içinde başladı");
    CollectionReference koleksiyonReferansi =
        FirebaseFirestore.instance.collection('data');
    DocumentReference belgeReferansi = koleksiyonReferansi.doc('reference');
    DocumentReference aktif = koleksiyonReferansi.doc('aktif');

    DocumentSnapshot doc = await belgeReferansi.get();
    DocumentSnapshot aktifdoc = await aktif.get();
    if (aktifdoc.exists) {
      var aktifo = aktifdoc.data();
      if (aktifo is Map<String, dynamic>) {
        AppConfig.istaktif = aktifo['aktif'];
        print(aktifo.toString() + "aktifo" + AppConfig.istaktif);
      }
    }

    if (doc.exists) {
      print('Belge bulundu.');
      final dat = doc.data();
      if (dat is Map<String, dynamic> && dat.containsKey('daily')) {
        var dailystParam = dat['daily'];
        print(dailystParam.toString() + "dailystParam" + "getrefadress");
        AppConfig.istrefbelge = dailystParam;
        AppConfig.istaktif = dat['aktif']?? 0 ;  //buraya bak
        return dailystParam;
      } else {
        print('reference parametresi bulunamadı.');
        return "bos";
      }
    } else {
      print('reference bulunamadı.');
      return "bos";
    }
  }
}
