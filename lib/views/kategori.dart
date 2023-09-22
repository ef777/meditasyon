import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:meditasyon/controllers/config.dart';
import 'package:meditasyon/controllers/meditasyoncont.dart';
import 'package:meditasyon/models/meditasyonmodel.dart';
import 'package:meditasyon/views/play.dart';
import 'package:meditasyon/views/premiumayrıcalık.dart';

class Kategori extends StatefulWidget {
  final String tip;
  final String baslik;
  final String resim;

  Kategori({
    Key? key,
    required this.tip,
    required this.baslik,
    required this.resim,
  }) : super(key: key);

  @override
  _KategoriState createState() => _KategoriState();
}

class KategoriTile extends StatelessWidget {
  final String resimurl;
  final String baslik;
  final String dakika;
  final String kategori;
  final String kimden;
  final String onecikan;
  final String premium;
  final String id;
  final String sesurl;

  const KategoriTile({
    Key? key,
    required this.premium,
    required this.resimurl,
    required this.baslik,
    required this.dakika,
    required this.kategori,
    required this.kimden,
    required this.onecikan,
    required this.sesurl,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (premium == "1") {
          if (AppConfig.premium) {
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
          } else {
            Get.to(() => Premiumayricalik(premium: ""),
                transition: Transition.cupertino);
          }
        } else {
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
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.transparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              resimurl,
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
                    Padding(
                      padding: EdgeInsets.only(
                        top: 9.0,
                        right: 9.0,
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
                            padding: const EdgeInsets.only(
                              top: 2.0,
                              right: 4.0,
                            ),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2.0,
                                  horizontal: 4.0,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.black.withOpacity(0),
                                ),
                                child: IconButton(
                                  color: Colors.white,
                                  iconSize: 19.0,
                                  onPressed: () {},
                                  icon: SvgPicture.asset(
                                    'assets/lock.svg',
                                    width: 19,
                                    height: 19,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(height: 0),
                  ],
                ),
              ),
            ),
            SizedBox(height: 3.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                baslik,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                  color: Colors.white38.withOpacity(1),
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(height: 4.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                kimden,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat',
                  fontSize: 12.0,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KategoriState extends State<Kategori> {
  final ScrollController _scrollController = ScrollController();

  final MeditasyonController medcont = Get.find();
  List<Meditasyon> oankikatmeditasyon = [];
  bool _verilerYuklendi = false;

  @override
  void initState() {
    super.initState();
    katgetir();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    oankikatmeditasyon.clear();
    super.dispose();
  }

  Future<void> katgetir() async {
    print("widget tipi bu" + widget.tip.toString());
    oankikatmeditasyon = await medcont.ozelmeditasyongetir(widget.tip);

    List<Meditasyon> aktifMeditasyonlar =
        oankikatmeditasyon.where((med) => med.aktif != "0").toList();
    oankikatmeditasyon = [];
    oankikatmeditasyon = aktifMeditasyonlar;

    oankikatmeditasyon.sort((a, b) {
      int priorityComparison =
          int.parse(a.oncelik).compareTo(int.parse(b.oncelik));
      if (priorityComparison != 0) {
        return priorityComparison;
      }
      return DateTime.parse(b.tarih).compareTo(DateTime.parse(a.tarih));
    });

    setState(() {
      _verilerYuklendi = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    if (!_verilerYuklendi) {
      return Container(
        decoration: BoxDecoration(
          gradient: SweepGradient(
      center: Alignment.bottomRight,
      startAngle: 0.0, // Başlangıç açısı (radyan cinsinden)
      endAngle: 3.14159,  colors: [
              Color.fromRGBO(43, 43, 64, 0.85),
              Color.fromRGBO(95, 95, 125, 0.85),
            ],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
        ),
        child: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
              height: size.height * 0.4,
              width: size.width, // Example of responsive height
              child: CachedNetworkImage(
                cacheManager: AppConfig.cacheManager,
                imageUrl: widget.resim,
                fit: BoxFit.cover,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              )),
          ClipRRect(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(0.0)),
            child: Container(
              height: size.height,
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
                controller: _scrollController,
                physics: NeverScrollableScrollPhysics(),
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
                          gradient: SweepGradient(
      center: Alignment.bottomRight,
      startAngle: 0.0, // Başlangıç açısı (radyan cinsinden)
      endAngle: 3.14159, colors: [
                              Color.fromRGBO(43, 43, 64, 1),
                              Color.fromRGBO(95, 95, 125, 1),
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
                              padding: EdgeInsets.fromLTRB(15, 20, 5, 0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.baslik,
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.0),
                                  ),
                                ),
                                padding:
                                    const EdgeInsets.fromLTRB(15, 5, 15, 0),
                                height: size.height * 0.7,
                                child: GridView.builder(
                                  controller: _scrollController,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: oankikatmeditasyon.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return KategoriTile(
                                      premium:
                                          oankikatmeditasyon[index].premium,
                                      id: oankikatmeditasyon[index].id,
                                      baslik: oankikatmeditasyon[index].baslik,
                                      resimurl:
                                          oankikatmeditasyon[index].resimurl,
                                      dakika: oankikatmeditasyon[index].dakika,
                                      kategori: oankikatmeditasyon[index].aktif,
                                      kimden: oankikatmeditasyon[index].kimden,
                                      onecikan:
                                          oankikatmeditasyon[index].onecikan,
                                      sesurl: oankikatmeditasyon[index].sesurl,
                                    );
                                  },
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: size.width *
                                        0.5, // Half of the screen width
                                    mainAxisSpacing: 12.0,
                                    crossAxisSpacing: 16.0,
                                    childAspectRatio: 1,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
