import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meditasyon/controllers/config.dart';
import 'package:meditasyon/controllers/istatistik.dart';
import 'package:meditasyon/views/loginpage.dart';
import 'package:meditasyon/wrapper.dart';

import 'registerpage.dart';

class OtherLoginPage extends StatefulWidget {
  @override
  _OtherLoginPageState createState() => _OtherLoginPageState();
}

class _OtherLoginPageState extends State<OtherLoginPage> {
  final Statistic statistik = Get.put(Statistic());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
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

  Future<String?> _signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;
      if (user != null) {
        final userExists = await doesUserExist(user.uid);
        if (!userExists) {
          await addUser(user.uid, user.displayName ?? "", user.email ?? "");
          AppConfig.login = true.obs;
          AppConfig.logind = true;
          AppConfig.isim = user.displayName.toString() ?? "Kullanıcı";
          statistik.gunllukkullaniciekle(AppConfig.istrefbelge);
        }
        /*      print("var ama eklendi");
        statistik.gunllukkullaniciekle(AppConfig.istrefbelge); */

        AppConfig.login = true.obs;
        AppConfig.logind = true;
        AppConfig.isim = user.displayName.toString() ?? "Kullanıcı";
        return user.uid;
      } else {
        return null;
      }
    } catch (e) {
      print("hata bu");
      print(e.toString());
      return null;
    }
  }

  Future<bool> doesUserExist(String uid) async {
    try {
      final userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      return userDoc.exists;
    } catch (e) {
      print('Firestore error: $e');
      return false;
    }
  }

  Future<void> addUser(String userId, String name, String email) {
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

  @override
  void initState() {
    super.initState();
    // Kontrolcülerin değişikliklerini dinleyin ve formu doğrulayın
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
                            Container(
                              padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                              margin: EdgeInsets.all(0),
                              child: Text(
                                textAlign: TextAlign.center,
                                "İlerlemeni kaydetmek için hesap oluştur",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Montserrat',
                                    fontSize: size.height * 0.020,
                                    color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                            SizedBox(
                                height: size.height * 0.06,
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(size.width * 0.9,
                                            size.height * 0.02),
                                        maximumSize: Size(size.width * 0.9,
                                            size.height * 0.02),
                                        primary: Colors.white,
                                        onPrimary: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        Get.to(RegisterPage(),
                                            transition: Transition.cupertino);
                                        // Google ile giriş yapmak için kodlar buraya gelecek
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: SvgPicture.asset(
                                              'assets/mail.svg',
                                              height: 30,
                                              width: 30,
                                              semanticsLabel: 'Mail',
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              'Mail ile Devam Et',
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      43, 43, 60, 1),
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Montserrat',
                                                  fontSize: size.width * 0.045),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))),
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                            SizedBox(
                                height: size.height * 0.06,
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(size.width * 0.9,
                                            size.height * 0.03),
                                        primary: Colors.white,
                                        onPrimary: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      onPressed: () async {
                                        final uid = await _signUpWithGoogle();
                                        if (uid != null) {
                                          Get.snackbar(
                                            "Giriş/Kayıt",
                                            "Hoş geldiniz!",
                                            backgroundColor: Colors.grey,
                                            duration: Duration(seconds: 2),
                                            snackPosition: SnackPosition.BOTTOM,
                                          );

                                          // Belirli bir süre sonra HomePage sayfasına geçiş yapılır
                                          Future.delayed(Duration(seconds: 2),
                                              () {
                                            Get.offAll(() => Wrapper());
                                          });
                                        } else {
                                          // Kayıt işlemi başarısız oldu, bir hata mesajı gösterilebilir
                                          Get.snackbar(
                                            "Giriş/Kayıt Başarısız",
                                            "Bir hata oldu, lütfen mail ile kayıt olmayı deneyin!",
                                            backgroundColor: Colors.grey,
                                            duration: Duration(seconds: 2),
                                            snackPosition: SnackPosition.BOTTOM,
                                          );
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: Image.asset(
                                            'assets/google.png',
                                            height: 25,
                                            width: 25,
                                          )),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              'Google ile Devam Et',
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      43, 43, 60, 1),
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Montserrat',
                                                  fontSize: size.width * 0.045),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))),
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                            /*   SizedBox(
                                height: size.height * 0.06,
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(size.width * 0.9,
                                            size.height * 0.03),
                                        primary: Colors.white,
                                        onPrimary: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        // Google ile giriş yapmak için kodlar buraya gelecek
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: Image.asset(
                                            'assets/apple.png',
                                            height: 30,
                                            width: 30,
                                          )),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              'Apple ile Devam Et',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Montserrat',
                                                  fontSize: size.height * 0.02),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))),
                           */
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Container(
                                padding: EdgeInsets.all(12),
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
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
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
                                                size: 18.0, color: Colors.white)
                                            : null,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 0),
                                          child: TextButton(
                                            onPressed: () {},
                                            child: Wrap(
                                              alignment: WrapAlignment.center,
                                              children: [
                                                Text(
                                                  "Teklifler ve Promosyonlar hakkında bilgi almak istiyorum.",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.white,
                                                    fontSize:
                                                        size.width * 0.032,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Hesabın var mı? ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Montserrat',
                                          color: Colors.white,
                                          fontSize: size.width * 0.035),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Get.to(LoginPage(),
                                              transition: Transition.cupertino);
                                        },
                                        child: Text(
                                          "Giriş yap.",
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Montserrat',
                                              color: Colors.white,
                                              fontSize: size.width * 0.035),
                                        )),
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
