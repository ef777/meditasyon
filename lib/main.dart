import 'dart:ui';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meditasyon/wrapper.dart';
import 'firebase_options.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(16.0)))),
          appBarTheme: const AppBarTheme(
            color: Color(0xFF2B2B40),
          ),
          scaffoldBackgroundColor: Color(0xFF2B2B40),

          primaryColor:
              Color.fromARGB(255, 255, 255, 255), // butonlar için ana renk
          hintColor:
              Color.fromRGBO(119, 119, 141, 1), // butonlar için ikincil renk
        ),
        home: Align(
            alignment: Alignment.center,
            child: AnimatedSplashScreen(
                duration: 750,
                splashIconSize: 3000,
                centered: true,
                splash: Stack(children: [
                Container(
        width: double.infinity,
        height: double.infinity,
        child:   Image.asset(
                    "assets/back.png",
                    fit: BoxFit.cover,
                 ) ),
                  BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Adjust the sigma values for blur intensity
                child: Container(
                  color: Colors.transparent, // Make the container transparent
                ),
              ),
                  Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/logo.png",
                        width: 184,
                        height: 171,
                      ))
                ]),
                nextScreen: Wrapper(),
                splashTransition: SplashTransition.fadeTransition,
                pageTransitionType: PageTransitionType.fade,
                backgroundColor: Colors.black)));
  }
}
