import 'dart:io';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:meditasyon/controllers/istatistik.dart';
import 'package:meditasyon/views/Favoriler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';

import '../controllers/config.dart';
import '../controllers/favorikontrol.dart';

class MusicPlayerScreen extends StatefulWidget {
  String baslik;
  String resimurl;
  String uzunluk;
  String id;
  String sesurl;
  String kimden;

  MusicPlayerScreen({
    Key? key,
    required this.baslik,
    required this.kimden,
    required this.resimurl,
    required this.uzunluk,
    required this.id,
    required this.sesurl,
  }) : super(key: key);

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  bool _verilerYuklendi = false;
  final Statistic statistik = Get.put(Statistic());

  int maxduration = 100;
  Duration _totalDuration = Duration.zero;
  final FavKontroller favcont = Get.put(FavKontroller());

  Duration currentpos = Duration.zero;
  String currentpostlabel = "0:0:0";
  bool isplaying = false;
  AudioPlayer player = AudioPlayer();
  String? audioUrl = "";
  /*  String sonurl =
   */
  bool isFavori = false;
  Future<void> ses1() async {
    final audioUrl = widget.sesurl;

    setState(() {
      _verilerYuklendi = true;
    });

    await player.play(audioUrl!);
    setState(() {
      if (isplaying) {
        player.pause();
        isplaying = false;
      } else {
        player.resume();
        isplaying = true;
      }
    });
    player.onDurationChanged.listen((Duration d) {
      setState(() {
        maxduration = d.inMilliseconds;
        _totalDuration = d;
      });
    });
    player.onAudioPositionChanged.listen((Duration p) {
      setState(() {
        currentpos = p;
        int shours = currentpos.inHours;
        int sminutes = currentpos.inMinutes;
        int sseconds = currentpos.inSeconds;

        int rhours = shours;
        int rminutes = sminutes - (shours * 60);
        int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

        currentpostlabel = "$rhours:$rminutes:$rseconds";

        // Slider'ın değerini güncelle
        double sliderValue = currentpos.inMilliseconds.toDouble();
        if (sliderValue > maxduration) {
          sliderValue = maxduration.toDouble();
        }
        if (sliderValue < 0) {
          sliderValue = 0.0;
        }
        // Slider'ın değerini güncelle
        currentpos = Duration(milliseconds: sliderValue.toInt());
      });
    });
  }

  Future<void> ses2() async {
    audioUrl = await widget.sesurl.toString();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    String audioFilePath = '$tempPath/dosya.mp3';
    File file = File(audioFilePath);
    bool fileExists = await file.exists();

    if (!fileExists) {
      http.Response audioResponse = await http.get(Uri.parse(audioUrl!));
      List<int> audioBytes = audioResponse.bodyBytes;
      await file.writeAsBytes(audioBytes);
    }

    setState(() {
      _verilerYuklendi = true;
    });

    await player.setUrl(file.path, isLocal: true);

    player.onDurationChanged.listen((Duration d) {
      setState(() {
        maxduration = d.inMilliseconds;
        _totalDuration = d;
      });
    });

    player.onAudioPositionChanged.listen((Duration p) {
      setState(() {
        currentpos = p;
        int shours = currentpos.inHours;
        int sminutes = currentpos.inMinutes;
        int sseconds = currentpos.inSeconds;

        int rhours = shours;
        int rminutes = sminutes - (shours * 60);
        int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

        currentpostlabel = "$rhours:$rminutes:$rseconds";
      });
    });
  }

  Duration parseDuration(String durationString) {
    var values = durationString.split(':').map(int.tryParse).toList();
    return Duration(
        hours: values[0] ?? 0,
        minutes: values[1] ?? 0,
        seconds: values[2] ?? 0);
  }

  String _formatDuration(var duration) {
    if (duration == null) {
      return '';
    }
    if (duration is String) {
      duration = parseDuration(duration);
    }
    if (duration.inHours == 0) {
      return '${duration.inMinutes.remainder(60)}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    }
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);
    return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  var ids;
  favorimi() async {
    await favcont.getFavoriteIds().then((value) => ids = value);
    await Future.delayed(Duration(milliseconds: 500)).then((_) {
      print("başladi ids nu");
      if (mounted) {
        // Check whether the State is mounted
        if (ids != null) {
          if (ids.runtimeType == List<String>) {
            if (ids.length > 0) {
              if (ids.contains(widget.id)) {
                setState(() {
                  isFavori = true;
                });
              } else {
                setState(() {
                  isFavori = false;
                });
              }
            }
          }
        }
      }
    });
  }

  favorisil(id) {
    favcont.removeFromFavorites(id);
    setState(() {
      isFavori = false;
    });
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((_) {});
    setState(() {
      isFavori = false;
    });
    statistik.dinlemeadetiekle(AppConfig.istrefbelge);

    Future.delayed(Duration(seconds: 3)).then((_) {
      if (mounted) {
        // Check whether the State is mounted
        favorimi();
      }
    });

    print("init başladı play için");

    _totalDuration = Duration(milliseconds: maxduration);

    print("ses başladı");

    if (AppConfig.depoizin == false) {
      print("ses1 başladı");
      ses1();
    } else {
      print("ses2 başladı");
      ses2();
    }
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (_auth.currentUser != null) {
      user = _auth.currentUser;
      final String uid = user!.uid;
    }

    if (!_verilerYuklendi) {
      return Container(
          decoration: BoxDecoration(
            gradient: SweepGradient(
      center: Alignment.bottomRight,
      startAngle: 0.0, // Başlangıç açısı (radyan cinsinden)
      endAngle: 3.14159,   colors: [
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
        body: Container(
      height: size.height * 1,
      width: size.width * 1,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: CachedNetworkImageProvider(
                widget.resimurl ?? "https://picsum.photos/500?random=10",
              ),
              fit: BoxFit.cover,
            )),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: SvgPicture.asset(
                      'assets/kapat.svg',
                      width: 36,
                      height: 36,
                    ),
                    color: Colors.white,
                    iconSize: 36,
                  ),
                  SizedBox(width: 70),
                  IconButton(
                    onPressed: () {
                      if (user != null) {
                        if (isFavori) {
                          favorisil(widget.id);
                          Get.snackbar(
                            widget.baslik ?? "..",
                            "Favorilerden Kaldırıldı",
                            colorText: Colors.black,
                            backgroundColor: Colors.white,
                            duration: Duration(seconds: 2),
                            snackPosition: SnackPosition.TOP,
                          );
                          setState(() {
                            isFavori = false;
                          });
                        } else {
                          FavKontroller.addToFavorites2(widget.id!, user!.uid);
                          Get.snackbar(
                            widget.baslik ?? "..",
                            "Favorilere Eklendi",
                            colorText: Colors.black,
                          backgroundColor: Colors.white,
                            duration: Duration(seconds: 2),
                            snackPosition: SnackPosition.TOP,
                          );
                          setState(() {
                            isFavori = true;
                          });
                        }
                      } else {
                        Get.snackbar(
                          widget.baslik ?? "",
                          "Favorilere Eklemek İçin Giriş Yapın",
                               colorText: Colors.black,
                          backgroundColor: Colors.white,
                          duration: Duration(seconds: 2),
                          snackPosition: SnackPosition.TOP,
                        );
                      }
                    },
                    icon: SvgPicture.asset(
                      'assets/Heart.svg',
                      width: 36,
                      height: 36,
                    ),
                    color: Colors.white,
                    iconSize: 36,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1),
                height: MediaQuery.of(context).size.width * 0.8,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      widget.resimurl ?? "https://picsum.photos/500?random=10",
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              SizedBox(height: 20),
              Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.12),
                  alignment: Alignment.centerLeft,
                  child: Text(widget.baslik ?? "İçerik ...",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontSize: size.width * 0.07))),
              SizedBox(height: 0),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.12),
                alignment: Alignment.centerLeft,
                child: Text(widget.kimden ?? "Sanatçı",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: size.width * 0.04)),
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () async {
                      int newPosition =
                          await player.getCurrentPosition() - 15000;
                      if (newPosition < 0) {
                        newPosition = 0;
                      }
                      await player.seek(Duration(milliseconds: newPosition));
                    },
                    icon: SvgPicture.asset(
                      'assets/backp.svg',
                      width: 40,
                      height: 40,
                    ),
                    color: Color.fromRGBO(217, 217, 217, 1),
                    iconSize: 40,
                  ),
                  IconButton(
                    onPressed: () async {
                      setState(() {
                        if (isplaying) {
                          player.pause();
                          isplaying = false;
                        } else {
                          player.resume();
                          isplaying = true;
                        }
                      });
                    },
                    icon: Icon(
                      isplaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                    ),
                    color: Color.fromRGBO(217, 217, 217, 1),
                    iconSize: 70,
                  ),
                  IconButton(
                    onPressed: () async {
                      int newPosition =
                          await player.getCurrentPosition() + 15000;
                      int duration = await player.getDuration();
                      if (newPosition > duration) {
                        newPosition = duration;
                      }
                      await player.seek(Duration(milliseconds: newPosition));
                    },
                    icon: SvgPicture.asset(
                      'assets/forwardp.svg',
                      width: 40,
                      height: 40,
                    ),
                    color: Color.fromRGBO(217, 217, 217, 1),
                    iconSize: 40,
                  ),
                ],
              ),
              SizedBox(height: 5),
              Container(
                  width: MediaQuery.of(context).size.width * 1,
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.015),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(80),
                          bottomLeft: Radius.circular(80),
                          topRight: Radius.circular(80),
                          bottomRight: Radius.circular(80),
                        )),
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.01),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: SliderTheme(
                          data: SliderThemeData(
                            trackHeight: 7.0,
                            activeTrackColor:
                                const Color.fromRGBO(85, 92, 139, 1),
                            inactiveTrackColor:
                                const Color.fromRGBO(255, 255, 255, 0.8),
                            thumbColor: Colors.white,
                            trackShape: GradientSliderTrackShape(
                              gradient: LinearGradient(
                                colors: [
                                  const Color.fromRGBO(85, 92, 139, 1),
                                  Color.fromARGB(255, 122, 127, 156),
                                ],
                              ),
                              trackHeight: 8.0,
                            ),
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 15.0),
                          ),
                          child: Slider(
                            value: currentpos.inMilliseconds.toDouble(),
                            max: maxduration.toDouble(),
                            onChanged: (double value) {
                              setState(() {
                                player.seek(
                                    Duration(milliseconds: value.toInt()));
                              });
                            },
                            label: _formatDuration(currentpos),
                          ),
                        ),
                      ),
                    ],
                  )),
              Container(
                  width: MediaQuery.of(context).size.width * 1,
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.02),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 20),
                        Container(
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.002),
                            padding: EdgeInsets.all(1),
                            child: Text(
                                _formatDuration(currentpostlabel).toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontSize: size.width * 0.035))),
                        SizedBox(width: size.width * 0.5),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.002),
                          padding: EdgeInsets.all(1),
                          child: Text(
                              _formatDuration(_totalDuration).toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: size.width * 0.035)),
                        ),
                        SizedBox(width: 20),
                      ])),
              SizedBox(height: 1),
              SizedBox(height: 25),
            ],
          ),
        ],
      ),
    ));
  }
}

class GradientSliderTrackShape extends SliderTrackShape {
  final LinearGradient gradient;
  final double trackHeight;
  final double radius;
  GradientSliderTrackShape(
      {required this.gradient, required this.trackHeight, this.radius = 50});

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    bool isDiscrete = false,
    bool isEnabled = true,
    Offset? secondaryOffset,
  }) {
    if (!isEnabled) {
      return;
    }

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    // Burada slider'ın aktif değerini belirlemek için thumbCenter.dx kullanıyoruz.
    final activeTrackRect = Rect.fromLTWH(
      trackRect.left,
      trackRect.top,
      thumbCenter.dx - trackRect.left + 0,
      trackRect.height,
    );
    final inactiveTrackRect = Rect.fromLTWH(
      thumbCenter.dx,
      trackRect.top,
      trackRect.right - thumbCenter.dx,
      trackRect.height,
    );

    // Aktif olan kısım için birinci renk, inaktif olan kısım için ikinci rengi kullanıyoruz.
    final Paint activePaint = Paint()
      ..shader = gradient.createShader(activeTrackRect);
    final Paint inactivePaint = Paint()
      ..color = sliderTheme.inactiveTrackColor!;
    context.canvas.drawRRect(
        RRect.fromRectAndRadius(activeTrackRect, Radius.circular(radius)),
        activePaint);
    context.canvas.drawRRect(
        RRect.fromRectAndRadius(inactiveTrackRect, Radius.circular(radius)),
        inactivePaint);
  }
}
