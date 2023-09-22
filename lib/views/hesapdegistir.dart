import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meditasyon/controllers/config.dart';
import 'package:meditasyon/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'registerpage.dart';

class HesapDegistir extends StatefulWidget {
  @override
  _HesapDegistirState createState() => _HesapDegistirState();
}

class _HesapDegistirState extends State<HesapDegistir> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final user = FirebaseAuth.instance.currentUser;

  degistir(mail, ad) async {
    try {
      await FirebaseAuth.instance.currentUser!.updateEmail(mail);
      await FirebaseAuth.instance.currentUser!.updateDisplayName(ad);
// E-posta güncelleme
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  final TextEditingController adsoyad = TextEditingController();
  final TextEditingController mail = TextEditingController();

  final mailfocus = FocusNode();
  final adsoyadfocus = FocusNode();
  bool _isFormValid = false;

  bool isLoading = false;
  final _formKey =
      GlobalKey<FormState>(); // _formKey değişkeni burada tanımlanıyor

  void _validateForm() {
// Form doğrulama işlemini burada yapın
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isFormValid = true;
      });
    } else {
      setState(() {
        _isFormValid = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
// Kontrolcülerin değişikliklerini dinleyin ve formu doğrulayın
    mail.addListener(_validateForm);
    adsoyad.addListener(_validateForm);
// Kullanıcı adı ve e-posta bilgilerini kontrolcülere yerleştirin
    adsoyad.text = user?.displayName ?? '';
    mail.text = user?.email ?? '';
  }

  @override
  void dispose() {
// Kontrolcüleri ve focus nodeları temizleyinmail.dispose();
    mailfocus.dispose();
    adsoyad.dispose();
    adsoyadfocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(43, 43, 64, 1),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Form(
                key: _formKey, // Form anahtarını _formKey değişkenine atıyoruz
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: size.height * 0.08,
                          ),
                          Center(
                            child: Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                './assets/logo.png',
                                height: size.height * 0.24,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.07,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(3),
                            child: Text(
                              "Hesap Bilgilerini Güncelle",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Montserrat',
                                fontSize: size.height * 0.023,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          SizedBox(
                            height: size.height * 0.12,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: TextFormField(
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(mailfocus);
                                },
                                onChanged: (_) => _validateForm(),
                                focusNode: adsoyadfocus,
                                controller: adsoyad,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: size.width * 0.04,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: size.width * 0.01,
                                    horizontal: size.height * 0.01,
                                  ),
                                  errorStyle: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontSize: size.width * 0.04,
                                  ),
                                  fillColor: Color.fromRGBO(33, 33, 50, 1),
                                  hintText: "Ad Soyad",
                                  prefixIcon: ImageIcon(
                                    AssetImage('assets/person.png'),
                                    color: Colors.grey,
                                    size: 22,
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Lütfen ad soyad girin';
                                  }
                                  if (value.length < 6) {
                                    return 'Lütfen 6 karakterden uzun ad ve soyad giriniz';
                                  }

                                  if (!RegExp(r'^[a-zA-ZğüşıöçĞÜŞİÖÇ ]+$')
                                      .hasMatch(value)) {
                                    return 'Lütfen geçerli bir ad soyad girin';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          SizedBox(
                            height: size.height * 0.12,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: TextFormField(
                                onChanged: (_) => _validateForm(),
                                focusNode: mailfocus,
                                controller: mail,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: size.width * 0.04,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: size.width * 0.01,
                                    horizontal: size.height * 0.01,
                                  ),
                                  errorStyle: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontSize: size.width * 0.04,
                                  ),
                                  fillColor: Color.fromRGBO(33, 33, 50, 1),
                                  hintText: "E-mail",
                                  prefixIcon: ImageIcon(
                                    AssetImage('assets/Message.png'),
                                    color: Colors.grey,
                                    size: 22,
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Lütfen bir e-posta adresi girin';
                                  }
                                  if (!RegExp(r'\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b')
                                      .hasMatch(value)) {
                                    return 'Lütfen geçerli bir e-posta adresi girin';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize:
                                  Size(size.width * 0.90, size.height * 0.06),
                              primary: _isFormValid
                                  ? Colors.white
                                  : Color.fromRGBO(195, 195, 214, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60.0),
                              ),
                            ),
                            child: Text(
                              'Güncelle',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Montserrat',
                                fontSize: size.width * 0.045,
                                color: Color.fromRGBO(43, 43, 64, 1),
                              ),
                            ),
                            onPressed: () async {
                              if (_isFormValid == true) {
                                // Doğrulama başarılı ise devam et butonu aktif hale gelir

                                try {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  var sonuc = degistir(
                                    mail.text,
                                    adsoyad.text,
                                  );

                                  setState(() {
                                    isLoading = false;
                                  });

                                  if (sonuc != null) {
                                    Get.snackbar(
                                      "Başarılı",
                                      "Başarıyla değiştirildi",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor:
                                          Colors.white.withOpacity(0.3),
                                      colorText: Colors.white,
                                      icon: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                    );
                                    Get.to(Wrapper());
                                  } else {
                                    Get.snackbar(
                                      "Hata",
                                      "Bir hata oluştu",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor:
                                          Colors.white.withOpacity(0.3),
                                      colorText: Colors.white,
                                      icon: Icon(
                                        Icons.error,
                                        color: Colors.white,
                                      ),
                                    );
                                  }
                                  // Navigate to home screen or display welcome message
                                } catch (e) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              } else {}
                            },
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 15,
                      left: 10,
                      child: IconButton(
                        onPressed: () {
                          print("tıklandı");
                          Get.back();
                        },
                        icon: SvgPicture.asset(
                          'assets/kapat.svg',
                          width: 36,
                          height: 36,
                        ),
                        color: Colors.white,
                        iconSize: 45,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
