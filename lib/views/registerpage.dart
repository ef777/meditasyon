import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meditasyon/controllers/config.dart';
import 'package:meditasyon/controllers/istatistik.dart';
import 'package:meditasyon/wrapper.dart';

import 'registerpage.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final Statistic statistik = Get.put(Statistic());

  Future<String> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      AppConfig.login = true.obs;
      AppConfig.logind = true;
      AppConfig.isim = _nameController.text;
      await userCredential.user!.updateProfile(displayName: AppConfig.isim);
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  Future<void> addUser(String userId, String name, String email) {
    statistik.gunllukkullaniciekle(AppConfig.istrefbelge);
    return _db.collection('users').doc(userId).set({
      'name': name,
      'email': email,
      'premium': false,
      'premiumbitis': "",
      'premiumbaslangic': "",
      'premiumkalan': "",
      'uid': userId,
      'teklif': teklif,
      // diğer kullanıcı bilgilerini burada ekleyebilirsiniz
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _nameFocusNode = FocusNode();

  final _passwordFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  bool _isFormValid = false;

  bool isLoading = false;
  bool teklif = false;
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
    _passwordController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _nameController.addListener(_validateForm);
  }

  @override
  void dispose() {
    // Kontrolcüleri ve focus nodeları temizleyin
    _nameController.dispose();

    _passwordController.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _emailFocusNode.dispose();
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
                    key:
                        _formKey, // Form anahtarını _formKey değişkenine atıyoruz
                    child: Stack(children: [
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
                                    ))),
                            SizedBox(
                              height: size.height * 0.07,
                            ),
                            SizedBox(
                                height: size.height * 0.10,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: TextFormField(
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context)
                                          .requestFocus(_emailFocusNode);
                                    },
                                    onChanged: (_) => _validateForm(),
                                    focusNode: _nameFocusNode,
                                    controller: _nameController,
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.width * 0.04),
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
                                          color:
                                              Color.fromARGB(255, 94, 92, 102),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                      ),
                                      filled: true,
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Montserrat',
                                          color: Colors.white.withOpacity(0.7),
                                          fontSize: size.width * 0.04),
                                      fillColor:
                                          Color.fromRGBO(33, 33, 50, 0.9),
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
                                )),
                            SizedBox(
                              height: size.height * 0.00,
                            ),
                            SizedBox(
                                height: size.height * 0.10,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: TextFormField(
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context)
                                          .requestFocus(_passwordFocusNode);
                                    },
                                    onChanged: (_) => _validateForm(),
                                    focusNode: _emailFocusNode,
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontFamily: 'Montserrat',
                                        color: Colors.white,
                                        fontSize: size.width * 0.04),
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
                                            color: Color.fromARGB(
                                                255, 94, 92, 102)),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                      ),
                                      filled: true,
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Montserrat',
                                          color: Colors.white.withOpacity(0.7),
                                          fontSize: size.width * 0.04),
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
                                      if (!RegExp(
                                              r'\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b')
                                          .hasMatch(value)) {
                                        return 'Lütfen geçerli bir e-posta adresi girin';
                                      }
                                      return null;
                                    },
                                  ),
                                )),
                            SizedBox(
                              height: size.height * 0.00,
                            ),
                            SizedBox(
                                height: size.height * 0.10,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: TextFormField(
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context).nextFocus();
                                    },
                                    onChanged: (_) => _validateForm(),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Lütfen bir şifre girin';
                                      }
                                      if (value!.length < 6) {
                                        return 'Şifreniz en az 6 karakter uzunluğunda olmalıdır';
                                      }
                                      return null;
                                    },
                                    obscureText: true,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontFamily: 'Montserrat',
                                        color: Colors.white,
                                        fontSize: size.width * 0.04),
                                    controller: _passwordController,
                                    focusNode: _passwordFocusNode,
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
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 94, 92, 102)),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Color.fromRGBO(33, 33, 50, 1),
                                      hintText: "Şifre",
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Montserrat',
                                          color: Colors.white.withOpacity(0.7),
                                          fontSize: size.width * 0.04),
                                      prefixIcon: ImageIcon(
                                        AssetImage('assets/pass.png'),
                                        color: Colors.grey,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                width: size.width * 0.90,
                                height: size.height * 0.064,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.0),
                                  gradient: SweepGradient(
      center: Alignment.bottomRight,
      startAngle: 0.0, // Başlangıç açısı (radyan cinsinden)
      endAngle: 3.14159,  colors: [
                                      _isFormValid
                                          ? {
                                              Color.fromRGBO(132, 173, 234, 1),
                                              Color.fromRGBO(148, 147, 233, 1),
                                            }.first
                                          : Color.fromRGBO(182, 199, 223, 1),
                                      Color.fromRGBO(163, 163, 216, 1),
                                    ],
                                  ),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(24.0),
                                    onTap: () async {
                                      if (_isFormValid == true) {
                                        // Doğrulama başarılı ise devam et butonu aktif hale gelir

                                        try {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          String userId =
                                              await signUpWithEmailAndPassword(
                                                  _emailController.text,
                                                  _passwordController.text);

                                          await addUser(
                                              userId,
                                              _nameController.text,
                                              _emailController.text);

                                          AppConfig.isim = _nameController.text;

                                          setState(() {
                                            isLoading = false;
                                          });

                                          if (userId != "") {
                                            AppConfig.login = true.obs;
                                            AppConfig.logind = true;
                                            AppConfig.isim =
                                                _nameController.text;

                                            print("kayıt başarılı");
                                            print(_nameController.text);
                                            // Başarılı giriş durumunda snackbar gösterilir
                                            Get.snackbar(   backgroundColor: Colors.white.withOpacity(0.9),
          colorText: Colors.black,
                                              "Kayıt Başarılı",
                                              "Hoş geldiniz!",
                                              duration: Duration(seconds: 1),
                                              snackPosition: SnackPosition.TOP,
                                            );

                                            // Belirli bir süre sonra HomePage sayfasına geçiş yapılır
                                            Future.delayed(Duration(seconds: 1),
                                                () {
                                              Get.offAll(() => Wrapper());
                                            });
                                          } else {
                                            // Başarısız giriş durumunda hata mesajı gösterilir
                                            Get.snackbar(
                                              "Giriş Hatası",
                                              "E-posta adresi veya şifre yanlış",
                                                 backgroundColor: Colors.white.withOpacity(0.9),
          colorText: Colors.black,
                                              duration: Duration(seconds: 3),
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                            );
                                          }
                                          // Navigate to home screen or display welcome message
                                        } catch (e) {
                                          setState(() {
                                            isLoading = false;
                                          });

                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Giriş Hatası'),
                                                content: Text("Bu Eposta zaten kullanımda!"),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Tamam'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      } else {}
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 0),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Devam Et',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontFamily: 'Montserrat',
                                          color: Colors.white.withOpacity(0.8),
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Container(
                                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        "Devam'a dokunarak Şartları kabul etmiş ve Gizlilik Politikamızı okuduğunuzu kabul etmiş olursunuz.",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Montserrat',
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            fontSize: size.width * 0.03),
                                      )),
                                )),
                            Container(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Theme(
                                      data: ThemeData(
                                        unselectedWidgetColor: Colors.white,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            teklif = !teklif;
                                          });
                                        },
                                        child: Container(
                                          height:
                                              20.0, // İstediğiniz boyuta ayarlayabilirsiniz.
                                          width:
                                              20.0, // İstediğiniz boyuta ayarlayabilirsiniz.
                                          decoration: BoxDecoration(
                                            color: teklif
                                                ? Colors.white.withOpacity(0.8)
                                                : Colors.transparent,
                                            border: Border.all(
                                                color: Colors.grey, width: 2.0),
                                            borderRadius: BorderRadius.circular(
                                                4.0), // Yumuşatma miktarını ayarlar
                                          ),
                                          child: teklif
                                              ? Icon(Icons.check,
                                                  size: 18.0,
                                                  color: Colors.white)
                                              : null,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Teklifler ve Promosyonlar hakkında bilgi almak istiyorum.",
                                        maxLines:
                                            2, // Metni en fazla iki satırda gösterir
                                        overflow: TextOverflow
                                            .ellipsis, // Fazla metni "..." ile gösterir
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Montserrat',
                                          color: Colors.white,
                                          fontSize: size.width * 0.029,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 30,
                        left: 5,
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
                    ]))));
  }
}
