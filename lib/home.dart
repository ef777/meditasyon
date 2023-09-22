import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:meditasyon/controllers/homecontroller.dart';
import 'package:meditasyon/views/Favoriler.dart';

import 'views/hesapdegistir.dart';
import 'views/home_view.dart';
import 'views/loginpage.dart';
import 'views/otherloginpage.dart';
import 'views/profil.dart';
import 'views/registerpage.dart';
import 'views/sifredegistir.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _getPage(controller.selectedIndex.value)),
      bottomNavigationBar: Obx(() => _buildBottomNavigationBar()),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Theme(
        data: Theme.of(context).copyWith(
          textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(
                  fontFamily: 'Montserrat',
                ), // Buraya istediğiniz yazı tipini, büyüklüğünü ve rengini ekleyin.
              ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // Sabit boyutlu öğeleri kullan
          backgroundColor: Color.fromRGBO(95, 95, 125, 1),
          currentIndex: controller.selectedIndex.value,
          selectedItemColor: Colors.white, // Renk ayarı
          unselectedItemColor: Colors.grey,
          unselectedIconTheme: IconThemeData(color: Colors.grey),
          selectedIconTheme: IconThemeData(color: Colors.white),
          unselectedFontSize: 12,
          selectedFontSize: 12,

          unselectedLabelStyle: TextStyle(
            color: Colors.grey,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
          selectedLabelStyle: TextStyle(
            color: Colors.white,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
          ),

          onTap: (index) => controller.selectedIndex.value = index,
          items: [
            BottomNavigationBarItem(
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 2), // Boşluk için kullanılacak SizedBox widget'ı

                  SvgPicture.asset(
                    'assets/Light.svg',
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(
                      height: 4), // Boşluk için kullanılacak SizedBox widget'ı
                ],
              ),
              label: 'Keşfet',
            ),
            BottomNavigationBarItem(
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 2), // Boşluk için kullanılacak SizedBox widget'ı

                  SvgPicture.asset(
                    'assets/Heart.svg',
                    width: 19,
                    height: 19,
                  ),
                  SizedBox(
                      height: 4), // Boşluk için kullanılacak SizedBox widget'ı
                ],
              ),
              label: 'Favoriler',
            ),
            BottomNavigationBarItem(
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 2), // Boşluk için kullanılacak SizedBox widget'ı

                  SvgPicture.asset(
                    'assets/Light2.svg',
                    width: 24,
                    height: 24,
                  ),
                  SizedBox(
                      height: 4), // Boşluk için kullanılacak SizedBox widget'ı
                ],
              ),
              label: 'Profil',
            ),
          ],
        ));
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return HomeView();
      case 2:
        return Profil();
      case 1:
        return Favoriler();
      default:
        return HomeView();
    }
  }
}
