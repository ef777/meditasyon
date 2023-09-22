import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:meditasyon/premium.dart';
import 'package:meditasyon/views/otherloginpage.dart';
import 'package:meditasyon/wrapper.dart';

import '../controllers/config.dart';

class Premiumayricalik extends StatelessWidget {
  final String premium;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void premiumOl() {
    if (_auth.currentUser != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .update({'premium': true});
      AppConfig.premium = true;
      Get.snackbar("Premium", "Premium üyeliğiniz aktif edildi",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white.withOpacity(0.9),
          colorText: Colors.black,
          icon: Icon(
            Icons.check,
            color: Colors.black,
          ));

      Get.offAll(Wrapper());
    } else {
      Get.snackbar("Lütfen Giriş Yapın", "",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white.withOpacity(0.9),
          colorText: Colors.black,
          icon: Icon(
            Icons.error,
            color: Colors.black,
          ));
      Get.to(OtherLoginPage(), transition: Transition.cupertino);
    }
  }

  void premiumIptal() {
    if (_auth.currentUser != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .update({'premium': false});
      AppConfig.premium = false;
      Get.snackbar("Premium", "Premium üyeliğiniz İptal Edildi",
          snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white.withOpacity(0.9),
          colorText: Colors.black,
          icon: Icon(
            Icons.check,
            color: Colors.black,
          ));
      Get.offAll(Wrapper());
    } else {
      Get.snackbar("Lütfen Giriş Yapın", "",
          snackPosition: SnackPosition.BOTTOM,
           backgroundColor: Colors.white.withOpacity(0.9),
          colorText: Colors.black,
          icon: Icon(
            Icons.check,
            color: Colors.black,
          ));
      Get.to(OtherLoginPage(), transition: Transition.cupertino);
    }
  }

  Premiumayricalik({
    Key? key,
    required this.premium,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(23, 23, 36, 0.7),
                      ),
                      child: Column(children: [
                        Container(
                          height: size.height * 0.25,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/backg1.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              decoration: BoxDecoration(),
                            ),
                          ),
                          decoration: BoxDecoration(
                            gradient:SweepGradient(
      center: Alignment.bottomRight,
      startAngle: 0.0, // Başlangıç açısı (radyan cinsinden)
      endAngle: 3.14159,   colors: [
                                Color.fromRGBO(70, 70, 101, 0.8),
                                Color.fromRGBO(23, 23, 36,
                                    0.8), // Kırmızı (255, 0, 0) ve opaklık 1.0
                              ],
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.0),
                              topRight: Radius.circular(12.0),
                            ),
                          ),
                        ),
                      ])))),
          Center(
              child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.15),
                TextButton(
                  child: Text(
                    "Premium üye ol (Test)",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    premiumOl();
                  },
                ),
                TextButton(
                  child: Text(
                    "Premium iptal (Test)",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () => premiumIptal(),
                ),
                Container(
                    width: size.width * 0.90,
                    height: size.height * 0.080,
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    padding: const EdgeInsets.only(left: 0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dönüşümünü Başlat',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              textAlign: TextAlign.start,
                              '50+ Özel hipnotik meditasyon ile',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Montserrat',
                                color: Colors.white.withOpacity(0.9),
                              ),
                            )
                          ],
                        ))),
                SizedBox(height: 8),
                TileOfPremium(
                  aciklama: "Ruhsal dönüşümünü hızlandır",
                  icon: "assets/tik.svg",
                ),
                SizedBox(height: 5),
                TileOfPremium(
                  aciklama: "Farkındalığını arttır",
                  icon: "assets/tik.svg",
                ),
                SizedBox(height: 5),
                TileOfPremium(
                  aciklama: "Potansiyelini açığa çıkart",
                  icon: "assets/tik.svg",
                ),
                SizedBox(height: 5),
                TileOfPremium(
                  aciklama: "İyi hisset",
                  icon: "assets/tik.svg",
                ),
                SizedBox(height: 5),
                TileOfPremium(
                  aciklama: "Sürekli güncellenen içeriklere sınırsız eriş",
                  icon: "assets/tik.svg",
                ),
                SizedBox(height: 20),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        width: size.width * 0.90,
                        height: size.height * 0.115,
                        child: Stack(children: [
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                width: size.width * 0.90,
                                height: size.height * 0.095,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60.0),
                                  gradient: SweepGradient(
      center: Alignment.bottomRight,
      startAngle: 0.0, // Başlangıç açısı (radyan cinsinden)
      endAngle: 3.14159,  colors: [
                                      Color.fromRGBO(148, 147, 233, 1),
                                      Color.fromRGBO(132, 173, 234, 1),
                                    ],
                                  ),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(60.0),
                                    onTap: () async {
                                      Get.to(SubscriptionPage());
                                    },
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 0),
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(children: [
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      7, 10, 70, 0),
                                                  child: Text(
                                                    'Yıllık',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontFamily: 'Montserrat',
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      20, 0, 1, 0),
                                                  child: Row(children: [
                                                    Text(
                                                      '₺250',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily:
                                                            'Montserrat',
                                                        color: Colors.white
                                                            .withOpacity(0.8),
                                                        fontSize: 18,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      '₺123 / Yıl',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontFamily:
                                                            'Montserrat',
                                                        color: Colors.white
                                                            .withOpacity(0.8),
                                                        fontSize: 18,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  ])),
                                            ]),
                                            Row(children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 1, 8, 1),
                                                child: Text(
                                                  '11₺ / Ay',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.white
                                                        .withOpacity(0.8),
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0,
                                                    top: 1,
                                                    right: 15,
                                                    bottom: 1),
                                                child: SvgPicture.asset(
                                                  "assets/devam.svg",
                                                ),
                                              ),
                                            ])
                                          ],
                                        )),
                                  ),
                                ),
                              )),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 0, top: 1, right: 17, bottom: 7),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                width: size.width * 0.37,
                                height: size.height * 0.035,
                                decoration: BoxDecoration(
                                  color:
                                      Colors.white, // Arkaplan rengini belirtin
                                  borderRadius: BorderRadius.circular(
                                      60.0), // Köşeleri yuvarla
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        3.0), // Yazıyı istediğiniz şekilde hizalayın
                                    child: Text(
                                      "Popüler",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Montserrat',
                                        color: Color.fromRGBO(145, 151, 233, 1),
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ]))),
                SizedBox(height: 10),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      width: size.width * 0.90,
                      height: size.height * 0.095,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60.0),
                        gradient:SweepGradient(
      center: Alignment.bottomRight,
      startAngle: 0.0, // Başlangıç açısı (radyan cinsinden)
      endAngle: 3.14159,  colors: [
                            Color.fromRGBO(148, 147, 233, 1),
                            Color.fromRGBO(132, 173, 234, 1),
                          ],
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(60.0),
                          onTap: () async {
                            Get.to(SubscriptionPage());
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(25, 0, 70, 0),
                                      child: Text(
                                        'Aylık',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontFamily: 'Montserrat',
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.left,
                                      )),
                                  Row(children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 1, 8, 1),
                                      child: Text(
                                        '15₺ / Ay',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontFamily: 'Montserrat',
                                          color: Colors.white.withOpacity(0.8),
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0,
                                          top: 1,
                                          right: 15,
                                          bottom: 1),
                                      child: SvgPicture.asset(
                                        "assets/devam.svg",
                                      ),
                                    ),
                                  ])
                                ],
                              )),
                        ),
                      ),
                    )),
                SizedBox(height: 80),
              ],
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 40),
            child: IconButton(
              iconSize: 30,
              icon: SvgPicture.asset(
                "assets/kapat.svg",
                color: Colors.white,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TileOfPremium extends StatelessWidget {
  final String aciklama;
  final String icon;

  const TileOfPremium({
    Key? key,
    required this.aciklama,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "$icon",
            width: 35,
            height: 35,
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$aciklama',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
