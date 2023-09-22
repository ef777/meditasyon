import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppConfig extends GetxController {
  static var istrefbelge;
  static var istaktif = "0";
  static late CacheManager cacheManager;

  var favori = [];
  final aramadegisti = false.obs;
  static var secilisesurl;
  degistir() {
    aramadegisti(!aramadegisti.value);
  }

  static bool depoizin = false;
  static var premium = false;
  static var premiumbitis = "".obs;

  static var login = false.obs;
  static var logind = false;

  static var email = "";
  static var uid = "".obs;
  static var isim = "Misafir";

  static UserCredential? user;
  static var main = Color.fromRGBO(17, 17, 68, 1);
static Map<String, dynamic> canliayar1= {};

  static Future<bool> checkInternet() async {
    try {
      print("internet kontrol ediliyor");
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected internet');
        return true;
      }
    } on SocketException catch (_) {
      print('not connected internet');
      Get.snackbar("internet problemi", "lütfen internete bağlanın");
      return false;
    }
    print("internet kontrol edildi başarısız");
    Get.snackbar("internet problemi", "lütfen internete bağlanın");

    return false;
  }

  static void medekle() {
    FirebaseFirestore.instance.collection('meds').add({
      'baslik': 'nefesini kontrol et',
      'dakika': '12',
      'id': '2',
      'kategori': '1',
      'kimden': 'efe',
      'onecikan': '1',
      'resimurl': 'https://picsum.photos/500?random=10',
      'sesurl':
          'https://firebasestorage.googleapis.com/v0/b/meditasyonnn1.appspot.com/o/d1.mp3?alt=media&token=1f72b448-9a52-4068-a97c-de045d993beb',
      'tip': '2',
    });
  }

  static void programekle() async {
    print("program eklendi");
    String aciklama = "Şifacı Ruhlar İçin";
    String aktif = "1";
    String baslik = "Şifacı Ruhlar İçin";
    String disResimUrl = "https://picsum.photos/500?random=11";
    String gidecekUrl = "https://www.google.com";
    String icResimUrl = "https://picsum.photos/500?random=10";
    String kimden = "Seda Sancaktar";
    String tip = "2";

    await FirebaseFirestore.instance.collection('programvesertifika').add({
      'aciklama': aciklama,
      'aktif': aktif,
      'baslik': baslik,
      'disresimurl': disResimUrl,
      'gidecekurl': gidecekUrl,
      'icresimurl': icResimUrl,
      'kimden': kimden,
      'tip': tip
    });
    print("program eklendi");
  }
}
