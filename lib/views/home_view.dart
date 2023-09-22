import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:meditasyon/controllers/config.dart';
import 'package:meditasyon/controllers/favorikontrol.dart';
import 'package:meditasyon/controllers/kategoricontrol.dart';
import 'package:meditasyon/models/kategorimodels.dart';
import 'package:meditasyon/models/meditasyonmodel.dart';
import 'package:meditasyon/views/kategori.dart';
import 'package:meditasyon/views/play.dart';
import 'package:meditasyon/views/premiumayr%C4%B1cal%C4%B1k.dart';
import 'package:meditasyon/wrapper.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../controllers/meditasyoncont.dart';
import '../controllers/programcontroller.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}



String getGreetingMessage() {
  final currentHour = DateTime.now().hour;

  if (currentHour >= 5 && currentHour < 12) {
    return "Günaydın";
  } else if (currentHour >= 12 && currentHour < 18) {
    return "İyi günler";
  } else if (currentHour >= 18 && currentHour < 21) {
    return "İyi akşamlar";
  } else {
    return "İyi geceler";
  }
}
class _HomeViewState extends State<HomeView> {
  final MeditasyonController medcont = Get.find();
    void initState() {
print("homeview başladı");

        print("işte inite gelen son değer homeviewde");
        print(AppConfig.canliayar1['canliaktif1']);
        print(AppConfig.canliayar1['canliaktif2']);
        print(AppConfig.canliayar1['canliisim1']);
        print(AppConfig.canliayar1['canliisim2']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    if (_auth.currentUser != null) {
      final User? user = _auth.currentUser;
      final String uid = user!.uid;
    }

    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(children: [
          ClipRRect(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(0.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient:SweepGradient(
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
                  physics: BouncingScrollPhysics(),
                  scrollBehavior: ScrollBehavior(),
                  slivers: [
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
                      expandedHeight: 225,
                      floating: false,
                      centerTitle: true,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                            child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                  width: size.width,
                                  child: Image.asset(
                                    'assets/backg1.png',
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  height: size.height * 0.2,
                                  padding: EdgeInsets.only(top: 15),
                                  child: Image.asset(
                                    'assets/logo.png',
                                    width: 140,
                                    height: 90,
                                  ),
                                )),
                          ],
                        )),
                        centerTitle: true,
                        collapseMode: CollapseMode.parallax,
                        stretchModes: [
                          StretchMode.zoomBackground,
                          StretchMode.blurBackground,
                          StretchMode.fadeTitle,
                        ],
                      ),
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(50),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 14, vertical: 18),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            getGreetingMessage() +
                                " " +
                                AppConfig.isim.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverPadding(
                        padding: EdgeInsets.all(0.0),
                        sliver: SliverToBoxAdapter(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: SweepGradient(
      center: Alignment.bottomRight,
      startAngle: 0.0, // Başlangıç açısı (radyan cinsinden)
      endAngle: 3.14159,  colors: [
                                  Color.fromRGBO(0, 0, 0,
                                      1), // Kırmızı (255, 0, 0) ve opaklık 1.0
                                  Color.fromRGBO(0, 0, 0, 1),
                                ],
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12.0),
                                topRight: Radius.circular(12.0),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FutureBuilder<List<Meditasyon>>(
                                    future: Future.value(
                                        MeditasyonController.meditasyon),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: SpinKitCircle(
                                            color: Colors.white,
                                            size: 50.0,
                                          ),
                                        );
                                      }
                                      if (snapshot.hasData) {
                                        List<Meditasyon> meditasyon =
                                            MeditasyonController.meditasyon;
                                        List<Meditasyon> aktifMeditasyonlar =
                                            meditasyon
                                                .where(
                                                    (med) => med.aktif != "0")
                                                .toList();
                                        meditasyon = [];
                                        meditasyon = aktifMeditasyonlar;
                                        meditasyon.sort((a, b) =>
                                            DateTime.parse(b.tarih).compareTo(
                                                DateTime.parse(a.tarih)));
                                        print("mini tile adeti " +
                                            meditasyon.length.toString());
                                        return Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12.0))),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          height: 150.0,
                                          child: GridView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: meditasyon.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return onecikantile(
                                                premium:
                                                    meditasyon[index].premium,
                                                id: meditasyon[index].id,
                                                resimurl:
                                                    meditasyon[index].resimurl,
                                                baslik:
                                                    meditasyon[index].baslik,
                                                kimden:
                                                    meditasyon[index].kimden,
                                                aktif: meditasyon[index].aktif,
                                                dakika:
                                                    meditasyon[index].dakika,
                                                sesurl:
                                                    meditasyon[index].sesurl,
                                              );
                                            },
                                            gridDelegate:
                                                SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 150.0,
                                              mainAxisSpacing: 12.0,
                                              crossAxisSpacing: 16.0,
                                              childAspectRatio: 1.1,
                                            ),
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    }),
                                Container(
                                  padding:
                                      EdgeInsets.fromLTRB(14.0, 16.0, 14.0, 0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'KATEGORİLER',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                FutureBuilder<List<KategoriModel>>(
                                    future: Future.value(
                                        KategoriController.kategorimodel),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: SpinKitCircle(
                                            color: Colors.white,
                                            size: 50.0,
                                          ),
                                        );
                                      }
                                      if (snapshot.hasData) {
                                        List<KategoriModel> kategorimodelo =
                                            KategoriController.kategorimodel;
                                        kategorimodelo.sort((a, b) =>
                                            int.parse(a.oncelik).compareTo(
                                                int.parse(b.oncelik)));

                                        return Container(
                                            padding: EdgeInsets.fromLTRB(
                                                3.0, 0, 3.0, 0),
                                            child: GridView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              itemCount: kategorimodelo.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                childAspectRatio: 1.2,
                                                crossAxisSpacing: 0.0,
                                                mainAxisSpacing: 0.0,
                                              ),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return kategoritile(
                                                  title: kategorimodelo[index]
                                                      .baslik,
                                                  tip:
                                                      kategorimodelo[index].tip,
                                                  imageUrl:
                                                      kategorimodelo[index]
                                                          .resimurl,
                                                );
                                              },
                                            ));
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    }),
                                AppConfig.canliayar1['canliaktif1'] == "1" ?        Container(
                                  padding:
                                      EdgeInsets.fromLTRB(14.0, 4, 14.0, 0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${   AppConfig.canliayar1['canliisim1']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ): SizedBox(height: 0,),
                                
                          AppConfig.canliayar1['canliaktif1'] == "1" ? Container(
  child: ListView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: ProgramController.canlisprogram.length,
    itemBuilder: (BuildContext context, int index) {
      double height;
      List<int> thresholds = [50,75, 100,125, 150, 175, 200, 225 ,250, 275 
      ,300 ,325,350,375,400];
List<double> factors = [0.40, 0.41, 0.42, 0.44, 0.45, 0.48, 0.49,  0.51, 0.53 ,0.56, 0.59];

int titleLength = ProgramController.canlisprogram[index].baslik.length;
 height = size.height * factors.last; // Default değer en büyük faktöre göre ayarlanır

for (int i = 0; i < thresholds.length; i++) {
    if (titleLength < thresholds[i]) {
        height = size.height * factors[i];
        break; // En yakın eşik değeri bulunduğunda döngüden çıkılır
    }
}

      return Container(
        height: height,
        child: ProgramTile(
          tip: ProgramController.canlisprogram[index].tip,
          url: ProgramController.canlisprogram[index].gidecekurl,
          title: ProgramController.canlisprogram[index].baslik,
          description: ProgramController.canlisprogram[index].aciklama,
          imageUrl: ProgramController.canlisprogram[index].disresimurl,
          kimden: ProgramController.canlisprogram[index].kimden,
          // icona: ProgramController.canlisprogram[index].icresimurl,
        ),
      );
    },
  ),
) : SizedBox(height: 0),


                              
                                 AppConfig.canliayar1['canliaktif2'] == "1" ?   Container(
                                  padding:
                                      EdgeInsets.fromLTRB(14.0, 18.0, 14.0, 0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                   '${   AppConfig.canliayar1['canliisim2']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ) : SizedBox(height: 0,),
                                 
                                 
                                    AppConfig.canliayar1['canliaktif2'] == "1" ? Container(
  child: ListView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: ProgramController.canlisertifika.length,
    itemBuilder: (BuildContext context, int index) {
      double height;
      List<int> thresholds = [50,75, 100,125, 150, 175, 200, 225 ,250, 275 
      ,300 ,325,350,375,400];
List<double> factors = [0.40, 0.41, 0.42, 0.44, 0.45, 0.48, 0.49,  0.51, 0.53 ,0.56, 0.59];

int titleLength = ProgramController.canlisertifika[index].baslik.length;
 height = size.height * factors.last; // Default değer en büyük faktöre göre ayarlanır

for (int i = 0; i < thresholds.length; i++) {
    if (titleLength < thresholds[i]) {
        height = size.height * factors[i];
        break; // En yakın eşik değeri bulunduğunda döngüden çıkılır
    }
}

      return Container(
        height: height,
        child: ProgramTile(
          tip: ProgramController.canlisertifika[index].tip,
          url: ProgramController.canlisertifika[index].gidecekurl,
          title: ProgramController.canlisertifika[index].baslik,
          description: ProgramController.canlisertifika[index].aciklama,
          imageUrl: ProgramController.canlisertifika[index].disresimurl,
          kimden: ProgramController.canlisertifika[index].kimden,
          // icona: ProgramController.canlisprogram[index].icresimurl,
        ),
      );
    },
  ),
) : SizedBox(height: 0),
                                     /*  AppConfig.canliayar1['canliaktif2'] == "1" ?   Container(
                                    child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      ProgramController.canlisertifika.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    childAspectRatio: 1.3,
                                    crossAxisSpacing: 2.0,
                                    mainAxisSpacing: 5.0,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ProgramTile(
                                      tip: ProgramController
                                          .canlisertifika[index].tip,
                                      url: ProgramController
                                          .canlisertifika[index].gidecekurl,
                                      title: ProgramController
                                          .canlisertifika[index].baslik,
                                      description: ProgramController
                                          .canlisertifika[index].aciklama,
                                      imageUrl: ProgramController
                                          .canlisertifika[index].disresimurl,
                                      kimden: ProgramController
                                          .canlisertifika[index].kimden,
                                      /*  icona: ProgramController
                                          .canlisertifika[index].icresimurl, */
                                    );
                                  },
                                )): SizedBox(height: 0,), */
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

class ProgramTile extends StatelessWidget {
  ProgramTile({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.kimden,
    required this.url,
    required this.tip,
  }) : super(key: key);

  final String title;
  final String description;
  final String imageUrl;
  final String kimden;
  final String url;
  final String tip;
double detaybutonyukseklik= 15;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
int titleLength = title.length;
int descriptionFlexValue = 1;
int pictureFlexValue = 4;

List<int> lengthThresholds = [50,75, 100,125, 150,175, 200 ,225, 250, 275, 300, 325, 350, 375, 400];
List<int> descriptionFlexValues = [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2 ,2, 2, 2, 2];
List<int> pictureFlexValues =     [ 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1 ,1, 1, 1, 1];

for (int i = 0; i < lengthThresholds.length; i++) {
  if (titleLength < lengthThresholds[i]) {
    descriptionFlexValue = descriptionFlexValues[i];
    pictureFlexValue = pictureFlexValues[i];
    break;
  }
}


    return GestureDetector(
      onTap: () async {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          await launch("https://www.spiritya.com/");
          throw 'Could not launch $url';
        }
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(
          size.width * 0.03,
          size.height * 0.009,
          size.width * 0.03,
          size.height * 0.009,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: pictureFlexValue,
              fit: FlexFit.tight,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(0.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(9.0)),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          imageUrl,
                          cacheManager: AppConfig.cacheManager,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 3),
                        Center(
                          child: Container(
                              width: size.width * 0.65,
                              child: Center(
                                  child: Text(
                                description,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize:
                                      determineFontSize(size, description),
                                ),
                                textAlign: TextAlign.center,
                              ))),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
                flex: descriptionFlexValue,
                fit: FlexFit.tight,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.70,
                          padding: EdgeInsets.fromLTRB(8.0, 7.0, 8.0, 0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: detaybutonyukseklik/3,),
                                Text(
                                  title,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Montserrat',
                                    fontSize: 14.0,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  kimden,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Montserrat',
                                    fontSize: 14.0,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ])),
                     
                              Column(
                                
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [ Container(
                                                 padding: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                                alignment: Alignment.topCenter,
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0,0 , 0),

                        width: 75,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          gradient: SweepGradient(
      center: Alignment.bottomRight,
      startAngle: 0.0, // Başlangıç açısı (radyan cinsinden)
      endAngle: 3.14159, colors: [
                              Color.fromRGBO(148, 147, 233, 1),
                              Color.fromRGBO(132, 173, 234, 1),
                            ],
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(24.0),
                            onTap: () async {
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                await launch("https://www.spiritya.com/");
                                throw 'Could not launch $url';
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              alignment: Alignment.center,
                              child: Text(
                                                                  textAlign: TextAlign.start,

                                'DETAY',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Montserrat',
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      ,
                      SizedBox( height: detaybutonyukseklik,),

                      ],) ,
                    ])),
          ],
        ),
      ),
    );
  }

  double determineFontSize(Size size, String text) {
    double screenWidth = size.width;
    double screenHeight = size.height;
    double maxLength =
        160; // Maximum length of the description before shrinking the font size
    double defaultFontSize = 14.0;

    if (text.length > maxLength) {
      double ratio = maxLength / text.length;
      double fontSize = defaultFontSize * ratio;
      return fontSize < 8 ? 8 : fontSize;
    }

    return defaultFontSize;
  }
}

class kategoritile extends StatelessWidget {
  const kategoritile({
    Key? key,
    required this.title,
    required this.tip,
    required this.imageUrl,
  }) : super(key: key);

  final String title;
  final String imageUrl;
  final String tip;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
        onTap: () {
          Get.to(
              () => Kategori(
                    baslik: title,
                    resim: imageUrl,
                    tip: tip,
                  ),
              transition: Transition.cupertino);
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(9, 0, 9, 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9.0),
            color: Colors.transparent,
          ),
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(0.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(9.0)),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        imageUrl,
                        cacheManager: AppConfig.cacheManager,
                      ),
                      fit: BoxFit.cover,
                    )),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class onecikantile extends StatelessWidget {
  final String resimurl;
  final String baslik;
  final String kimden;
  final String dakika;
  final String aktif;
  final String sesurl;
  final String id;
  final String premium;

  onecikantile({
    Key? key,
    required this.resimurl,
    required this.baslik,
    required this.kimden,
    required this.dakika,
    required this.aktif,
    required this.sesurl,
    required this.id,
    required this.premium,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
        onTap: () {
          if (premium == "1") {
            if (AppConfig.premium == true) {
              Get.to(
                  () => MusicPlayerScreen(
                        sesurl: sesurl,
                        id: id ?? "*",
                        baslik: baslik,
                        kimden: kimden,
                        resimurl: resimurl,
                        uzunluk: dakika,
                      ),
                  transition: Transition.cupertino);
            } else {
              Get.to(() => Premiumayricalik(premium: ""),
                  transition: Transition.cupertino);
            }
          } else {
            Future.delayed(Duration(milliseconds: 500), () {
              Get.to(
                  () => MusicPlayerScreen(
                        sesurl: sesurl,
                        id: id,
                        baslik: baslik,
                        kimden: kimden,
                        resimurl: resimurl,
                        uzunluk: dakika,
                      ),
                  transition: Transition.cupertino);
            });
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9.0),
            color: Colors.transparent,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9.0),
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(0.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(9.0)),
                        ),
                        child: LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            final double containerWidth = constraints.maxWidth;
                            final double containerHeight =
                                constraints.maxHeight;

                            return ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9.0)),
                              child: Stack(
                                children: [
                                  CachedNetworkImage(
                                    cacheManager: AppConfig.cacheManager,
                                    imageUrl: resimurl,
                                    placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Center(child: Icon(Icons.error)),
                                    fit: BoxFit.cover,
                                    width: containerWidth,
                                    height: containerHeight,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(9.0)),
                                      color: Colors.black.withOpacity(0.3),
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 0, sigmaY: 0),
                                      child: Container(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 3.0,
                          right: 5.0,
                        ),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            dakika + " dk",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                      premium == "1"
                          ? Padding(
                              padding: EdgeInsets.only(
                                top: 2.0,
                                right: 4.0,
                              ),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 2.0,
                                    horizontal: 4.0,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.black.withOpacity(0),
                                  ),
                                  child: IconButton(
                                    color: Colors.white,
                                    iconSize: 10.0,
                                    onPressed: () {},
                                    icon: SvgPicture.asset(
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
                    ],
                  ),
                ),
              ),
              SizedBox(height: 7.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Text(
                  baslik,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Montserrat',
                    color: Colors.white38.withOpacity(0.8),
                    fontSize: 12.0,
                  ),
                ),
              ),
              SizedBox(height: 4.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Text(
                  kimden,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Montserrat',
                    fontSize: 11.0,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
