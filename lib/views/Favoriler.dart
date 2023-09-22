import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:meditasyon/controllers/favorikontrol.dart';
import 'package:meditasyon/views/hesapdegistir.dart';
import 'package:meditasyon/views/otherloginpage.dart';
import 'package:meditasyon/views/premiumayr%C4%B1cal%C4%B1k.dart';
import 'package:meditasyon/views/sifredegistir.dart';
import 'package:meditasyon/wrapper.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../controllers/config.dart';
import '../models/meditasyonmodel.dart';

import 'play.dart';

class Favoriler extends StatefulWidget {
  @override
  _FavorilerState createState() => _FavorilerState();
}

class _FavorilerState extends State<Favoriler> {
  bool _verilerYuklendi = false;

  List<String> _favoriteIds = [];
  List<Meditasyon> _favoriteMeditations = [];
  final FavKontroller favcont = Get.put(FavKontroller());
  favorigetir() async {
    var favmeds;
    var ids = await favcont.getFavoriteIds();
    print("gelen ids");
    print(ids);

    setState(() {
      _favoriteIds = ids;
    });
    print("ids");

    var yenid = ids.toString();

    if (yenid == "[]") {
      print("yeni ids boş");
      favmeds = null;
    } else {
      favmeds = await favcont.getFavoriteMeditations(_favoriteIds);

      print("yeni ids dolu");
    }
    print("favmeds");
    print(favmeds);
    print(favmeds.runtimeType);
    print(favmeds.toString());
    setState(() {
      if (favmeds == Null || favmeds == [] || favmeds == null) {
        print("favmeds null");
        _favoriteMeditations = [];
      } else {
        print("favmeds ok");
        _favoriteMeditations = favmeds;
      }
    });
    setState(() {
      _verilerYuklendi = true;
    });
  }

  favorisil(id) {
    favcont.removeFromFavorites(id);

    favorigetir();
  }

  @override
  void initState() {
    super.initState();
    favorigetir();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (user == null) {
      return Container(
          decoration: BoxDecoration(
            gradient: SweepGradient(
      center: Alignment.bottomRight,
      startAngle: 0.0, // Başlangıç açısı (radyan cinsinden)
      endAngle: 3.14,/* transform: GradientRotation(3.14/2), */
/*        tileMode: TileMode.values[0],
 */
              colors: [
                Color.fromRGBO(43, 43, 64, 1),
                Color.fromRGBO(
                    95, 95, 125, 1), // Kırmızı (255, 0, 0) ve opaklık 1.0
              ],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                height: size.height * 0.40,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15, 40, 15, 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Kişiselleştirilmiş Deneyim için ",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => OtherLoginPage(),
                            transition: Transition.cupertino);
                      },
                      child: Text(
                        "Üye Ol / Giriş Yap",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ));
    }
    if (!_verilerYuklendi) {
      return Container(
          decoration: BoxDecoration(
            gradient: SweepGradient(
      center: Alignment.bottomRight,
      startAngle: 0.0, // Başlangıç açısı (radyan cinsinden)
      endAngle: 3.14159,    colors: [
                Color.fromRGBO(43, 43, 64, 1),
                Color.fromRGBO(
                    95, 95, 125, 1), // Kırmızı (255, 0, 0) ve opaklık 1.0
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
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: size.height * 0.4,
              width: size.width,
              child: Image.asset(
                'assets/backg1.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          ClipRRect(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(0.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: SweepGradient(
      center: Alignment.bottomRight,
      startAngle: 0.0, // Başlangıç açısı (radyan cinsinden)
      endAngle: 3.14159,  colors: [
                      AppConfig.main.withOpacity(0),
                      AppConfig.main.withOpacity(0),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
                      expandedHeight: size.height * 0.3,
                      flexibleSpace: FlexibleSpaceBar(background: Container()),
                    ),
                    SliverPadding(
                        padding: EdgeInsets.all(0.0),
                        sliver: SliverToBoxAdapter(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient:SweepGradient(
      center: Alignment.bottomRight,
      startAngle: 0.0, // Başlangıç açısı (radyan cinsinden)
      endAngle: 3.14159,  colors: [
                                  Color.fromRGBO(43, 43, 64, 1),
                                  Color.fromRGBO(95, 95, 125,
                                      1), // Kırmızı (255, 0, 0) ve opaklık 1.0
                                ],
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12.0),
                                topRight: Radius.circular(12.0),
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      20, 30, 20, 5), // 20, 30, 20, 20

                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Favoriler',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                _favoriteMeditations == [""] ||
                                        _favoriteMeditations == [] ||
                                        _favoriteMeditations == null ||
                                        _favoriteMeditations.length == 0 ||
                                        _favoriteMeditations == Null
                                    ? Container(
                                        height: size.height * 0.7,
                                        child: Center(
                                            child: Text(
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Montserrat',
                                                ),
                                                "Favorilerinize henüz bir şey eklemediniz")))
                                    : Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 5, 15, 0),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.0))),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 1.0),
                                        height: size.height * 0.7,
                                        child: GridView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount:
                                              _favoriteMeditations.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            Meditasyon meditation =
                                                _favoriteMeditations[index];

                                            return GestureDetector(
                                                onTap: () {
                                                  if (meditation.premium ==
                                                      "1") {
                                                    AppConfig.premium == true
                                                        ? Get.to(
                                                            () =>
                                                                MusicPlayerScreen(
                                                                  sesurl:
                                                                      meditation
                                                                          .sesurl,
                                                                  id: meditation
                                                                      .id,
                                                                  baslik:
                                                                      meditation
                                                                          .baslik,
                                                                  kimden:
                                                                      meditation
                                                                          .kimden,
                                                                  resimurl:
                                                                      meditation
                                                                          .resimurl,
                                                                  uzunluk:
                                                                      meditation
                                                                          .dakika,
                                                                ),
                                                            transition:
                                                                Transition
                                                                    .cupertino)
                                                        : Get.to(
                                                            () =>
                                                                Premiumayricalik(
                                                                    premium:
                                                                        ""),
                                                            transition:
                                                                Transition
                                                                    .cupertino);
                                                  } else {
                                                    Get.to(
                                                        () => MusicPlayerScreen(
                                                              sesurl: meditation
                                                                  .sesurl,
                                                              id: meditation.id,
                                                              baslik: meditation
                                                                  .baslik,
                                                              kimden: meditation
                                                                  .kimden,
                                                              resimurl:
                                                                  meditation
                                                                      .resimurl,
                                                              uzunluk:
                                                                  meditation
                                                                      .dakika,
                                                            ),
                                                        transition: Transition
                                                            .cupertino);
                                                  }
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.transparent,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: Stack(
                                                            children: [
                                                              Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          borderRadius: BorderRadius.all(Radius.circular(
                                                                              10.0)),
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                CachedNetworkImageProvider(
                                                                              meditation.resimurl,
                                                                              cacheManager: AppConfig.cacheManager,
                                                                            ),
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          )),
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          0.0),
                                                                  child:
                                                                      BackdropFilter(
                                                                    filter: ImageFilter.blur(
                                                                        sigmaX:
                                                                            0,
                                                                        sigmaY:
                                                                            0),
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(0.2),
                                                                      ),
                                                                    ),
                                                                  )),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  top: 3.0,
                                                                  right: 9.0,
                                                                ),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topRight,
                                                                  child: Text(
                                                                    meditation
                                                                            .dakika +
                                                                        " dk",
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              meditation.premium ==
                                                                      "1"
                                                                  ? Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                        top:
                                                                            2.0,
                                                                        right:
                                                                            4.0,
                                                                      ),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.bottomRight,
                                                                        child:
                                                                            Container(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(
                                                                            vertical:
                                                                                2.0,
                                                                            horizontal:
                                                                                4.0,
                                                                          ),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10.0),
                                                                            color:
                                                                                Colors.black.withOpacity(0),
                                                                          ),
                                                                          child:
                                                                              IconButton(
                                                                            color:
                                                                                Colors.white,
                                                                            iconSize:
                                                                                10.0,
                                                                            onPressed:
                                                                                () {},
                                                                            icon:
                                                                                SvgPicture.asset(
                                                                              'assets/lock.svg',
                                                                              width: 15,
                                                                              height: 15,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : SizedBox(
                                                                      height: 0,
                                                                    ),
                                                              Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .bottomRight,
                                                                  child: IconButton(
                                                                      color: Colors.white,
                                                                      onPressed: () {
                                                                        favorisil(
                                                                            meditation.id);
                                                                      },
                                                                      icon: Icon(
                                                                        Icons
                                                                            .delete,
                                                                      ))),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 3.0),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    1.0),
                                                        child: Text(
                                                          meditation.baslik,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontSize: 12.0,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 4.0),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    1.0),
                                                        child: Text(
                                                          meditation.kimden,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                'Montserrat',
                                                            color: Colors
                                                                .white38
                                                                .withOpacity(
                                                                    0.8),
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ));
                                          },
                                          gridDelegate:
                                              SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 200.0,
                                            mainAxisSpacing: 12.0,
                                            crossAxisSpacing: 16.0,
                                            childAspectRatio: 1,
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
              ))
        ]));
  }
}
