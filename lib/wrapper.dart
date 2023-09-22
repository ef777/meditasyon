import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meditasyon/controllers/config.dart';
import 'package:meditasyon/controllers/homecontroller.dart';
import 'package:meditasyon/controllers/logincontroller.dart';
import 'package:meditasyon/controllers/programcontroller.dart';
import 'package:meditasyon/models/usermodel.dart';
import 'package:meditasyon/views/kategori.dart';
import 'package:meditasyon/controllers/kategoricontrol.dart';
import 'package:meditasyon/controllers/meditasyoncont.dart';
import 'package:permission_handler/permission_handler.dart';

import 'controllers/config.dart';
import 'controllers/istatistik.dart';
import 'controllers/kategoricontrol.dart';
import 'controllers/meditasyoncont.dart';
import 'home.dart';
import 'models/meditasyonmodel.dart';

class Wrapper extends StatefulWidget {
  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final HomeController controller = Get.put(HomeController());
  final LoginController _LoginController = Get.put(LoginController());
  final MeditasyonController medcont = Get.put(MeditasyonController());
  final KategoriController katcont = Get.put(KategoriController());
  final ProgramController programcont = Get.put(ProgramController());
  final Statistic statistik = Get.put(Statistic());
  bool _verilerYuklendi = false;

  Future<bool> _isPremiumActive() async {
    // Kullanıcının Premium aboneliklerini Firestore'dan al
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('subscriptions')
        .where('userId', isEqualTo: user!.uid)
        .where('plan', isEqualTo: 'Premium')
        .orderBy('timestamp', descending: true) // En son aboneliği almak için
        .limit(1) // Sadece en son aboneliği al
        .get();

    // Kullanıcının bir Premium aboneliği yoksa, false döndür
    if (snapshot.docs.isEmpty) {
      return false;
    }

    // En son Premium aboneliği al
    Map<String, dynamic> latestSubscription =
        snapshot.docs.first.data() as Map<String, dynamic>;

    // Aboneliğin başlangıç tarihini al
    DateTime subscriptionStart = latestSubscription['timestamp'].toDate();

    // Aboneliğin bitiş tarihini hesapla (genellikle başlangıç tarihinden 30 gün sonra)
    DateTime subscriptionEnd = subscriptionStart.add(Duration(days: 30));

    // Eğer mevcut tarih, aboneliğin bitiş tarihinden önceyse, abonelik hala aktif demektir
    return DateTime.now().isBefore(subscriptionEnd);
  }

  Future<void> gunlukDinleyenSayisiEkle() async {
    final user = _auth.currentUser;
    if (user == null) {
      // Giriş yapılmamış
      return;
    }

    final userDoc =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
    final userSnap = await userDoc.get();

    final lastListenDate = (userSnap.data()
        as Map<String, dynamic>)['last_listen_date'] as Timestamp;
    final now = DateTime.now().toUtc();
    if (lastListenDate.toDate().day != now.day ||
        lastListenDate.toDate().month != now.month ||
        lastListenDate.toDate().year != now.year) {
      // Bugünün ilk girişi, dinleyici sayısını artır
      statistik.gunlukdinleyensayisiekle(AppConfig.istrefbelge);
    }
    // Kullanıcının son giriş tarihini güncelle
    await userDoc.update({
      'last_listen_date': FieldValue.serverTimestamp(),
    });
  }

  Future<void> _checkPermissions() async {
    final PermissionStatus storagePermissionStatus =
        await Permission.storage.request();
    final PermissionStatus audioStatus = await Permission.audio.request();
    final PermissionStatus ignoreBatteryOptimizationsStatus =
        await Permission.ignoreBatteryOptimizations.request();

/*     final PermissionStatus mediaLibrarystatus =
        await Permission.mediaLibrary.request();
    
    final PermissionStatus notificationStatus =
        await Permission.notification.request();
    final PermissionStatus accessMediaLocations =
        await Permission.accessMediaLocation.request(); */
    /* final PermissionStatus manageExternalStorageStatus =
        await Permission.manageExternalStorage.request();
 */
    if (storagePermissionStatus.isGranted) {
      // İzinler verildiyse verileri yükleme işlemini gerçekleştir
    } else {
      // İzinler reddedildiyse kullanıcıya izin isteği göster
      if (storagePermissionStatus.isPermanentlyDenied) {
        // Kullanıcı izinleri kalıcı olarak reddetti
        // Uygulama ayarlarına yönlendirerek izinleri el ile etmesini sağlayabilirsiniz
        //  openAppSettings();
      } else {
        // Kullanıcı izinleri geçici olarak reddetti
        // İzinleri tekrar isteme işlemini gerçekleştir
      }
    }
  }

  istatistikdata() async {
    AppConfig.istrefbelge = await Statistic.getrefadress();
    print("istatistik data" + AppConfig.istrefbelge.toString());
    print("tamamlandı");
  }

  girisveri() async {
    await medcont.meditasyonbastacek();
    if (MeditasyonController.meditasyon == []) {
      setState(() {});
      print("medverileri çekilemedi");
    } else {
      setState(() {
        print("medverileri çekildi");
      });
    }
    await katcont.kategoriModelbastacek();
    if (KategoriController.kategorimodel == []) {
      setState(() {});
      print("kat çekilemedi");
    } else {
      setState(() {
        print("kat çekildi");
      });
    }
    await programcont.programbastacek();
    if (ProgramController.canlisertifika == []) {
      setState(() {});
      print("program çekilemedi");
    } else {
      setState(() {
        print("program çekildi");
      });
    }
    print("çekilen " + ProgramController.canlisertifika.length.toString());

    setState(() {
      _verilerYuklendi = true;
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  usercek() async {
    if (user != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();
      final userdata = userDoc.data();
      AppConfig.logind = true;
      AppConfig.login = true.obs;
      AppConfig.uid = user!.uid.obs;
      AppConfig.email = user!.email.toString();
      print("gelen isim" + user!.displayName.toString());
      AppConfig.isim = user!.displayName.toString() ?? "Kullanıcı";
      print("premium " + AppConfig.premium.toString());
      print("premium " + userdata.toString());
      bool premium = await _isPremiumActive();
      AppConfig.premium = premium;
      print("premium from time " + premium.toString());
      //TEST
      AppConfig.premium = userdata?['premium'] == true ? true : false;
    } else {
      AppConfig.logind = false;
      AppConfig.login = false.obs;
      AppConfig.premium = false;
      AppConfig.isim = "Misafir";
    }
  }
  late CollectionReference _CanliayarlarCollection;
Future<Map<String, dynamic>> _getCanliVeriler() async {
  try {
    var snapshot = await _CanliayarlarCollection.get();

    print("veri var");
    Map<String, dynamic> belge = snapshot.docs[0].data() as Map<String, dynamic>;
    var canliVeriler = {
      'canliaktif1': belge['canliaktif1'],
      'canliaktif2': belge['canliaktif2'],
      'canliisim1': belge['canliisim1'],
      'canliisim2': belge['canliisim2'],
    };
    print("işte veri 10");
    print(canliVeriler.toString());

    return canliVeriler;
  } catch (error) {
    var canliVeriler = {
      'canliaktif1': "1",
      'canliaktif2': "1",
      'canliisim1': "ee",
      'canliisim2': "ee",
    };
    print('Bir hata oluştu: $error');
    print(canliVeriler.toString());
    return canliVeriler;
  }
}
  @override
  void initState() {

         _CanliayarlarCollection =
        FirebaseFirestore.instance.collection('canlitip');
        Future.delayed(Duration(milliseconds: 400), () async { 
       _getCanliVeriler().then((canliVeriler) {
    setState(() {
      AppConfig.canliayar1 = canliVeriler;
      print("canli ayar değeri son");
      print(AppConfig.canliayar1.toString());
    });
  }); });
 
    AppConfig.cacheManager = DefaultCacheManager();

    _checkPermissions();
    AppConfig.checkInternet();
    girisveri();
    usercek();
    istatistikdata();
    Future.delayed(Duration(milliseconds: 400), () async{ // buraya dikkat
      await gunlukDinleyenSayisiEkle();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    if (!_verilerYuklendi) {
      return Container(
          decoration: BoxDecoration(
            gradient:SweepGradient(
      center: Alignment.bottomRight,
      startAngle: 0.0, // Başlangıç açısı (radyan cinsinden)
      endAngle: 3.14159,   colors: [
                Color.fromRGBO(43, 43, 64, 1),
                Color.fromRGBO(109, 116, 161, 1),
                // Kırmızı (255, 0, 0) ve opaklık 1.0
              ],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ));
    }
    return Obx(() {
      if (_LoginController.firebaseUser.value == null) {
        return HomePage();
      } else {
// User i
        return HomePage();
      }
    });
  }
}
