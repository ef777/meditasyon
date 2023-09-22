import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meditasyon/controllers/config.dart';
import 'package:meditasyon/wrapper.dart';
import '../models/usermodel.dart';
import 'registerpage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userController = Get.find<UserController>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  void showResetPasswordDialog(BuildContext context) {
    TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Şifrenizi Sıfırlayın"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  "Lütfen şifresini sıfırlamak istediğiniz hesabın e-posta adresini girin."),
              SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'E-posta Adresi',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("İptal"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Şifreyi Sıfırla"),
              onPressed: () {
                sendPasswordResetEmail(emailController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar(
        "Başarılı",
        "Şifre sıfırlama linki e-postanıza gönderildi.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white.withOpacity(0.3),
        colorText: Colors.white,
        icon: Icon(
          Icons.check,
          color: Colors.white,
        ),
      );
    } on FirebaseAuthException catch (e) {
      print(e.code.toString() + " - " + e.message.toString());
      Get.snackbar(
        "Başarısız",
        "Bir hata oluştu: ${e.message}",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white.withOpacity(0.3),
        colorText: Colors.white,
        icon: Icon(
          Icons.error,
          color: Colors.white,
        ),
      );
    } catch (e) {
      print('Bir hata oluştu: $e');
    }
  }

  Future<String> signIn() async {
    try {
      print("signin fonk başladı");
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (userCredential.user != null) {
        print("user null değil");
        setState(() {
          isLoading = true;
        });
        print("o zaman user verileri çekiliyor");

        userController.fetchUserData(userCredential.user!.uid);
        print("user verileri çekildi");
        if (userController.checkuser()) {
          print("user verisi var");
          print(userController.getusername());
          setState(() {
            isLoading = false;
          });
          AppConfig.login.value = true;
          AppConfig.login.refresh();
          return userCredential.user.toString();
        } else {
          setState(() {
            isLoading = false;
          });
          AppConfig.login.value = false;
          AppConfig.login.refresh();
          return "";
        }

        // Giriş başarılı, yapılacak işlemler buraya yazılabilir.
      } else {
        print("user giriş null");
        setState(() {
          isLoading = false;
        });
        AppConfig.login.value = false;
        AppConfig.login.refresh();
        return "";
      }
    } catch (e) {
      print(e.toString());
      setState(() {
        isLoading = false;
      });
      AppConfig.login.value = false;
      AppConfig.login.refresh();
      return "";
    }
  }

  void signInWithGoogle() async {
    try {
      setState(() {
        isLoading = true;
      });
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        setState(() {
          isLoading = false;
        });
        AppConfig.login.value = true;
        AppConfig.login.refresh();
        Get.offAll(Wrapper());
      }
    } catch (e) {
      print(e.toString());
    }
  }

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
    // Kontrolcülerin değişikliklerini dinleyin ve formu doğrulayın
    _passwordController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
  }

  @override
  void dispose() {
    // Kontrolcüleri ve focus nodeları temizleyin
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
                                          .requestFocus(_passwordFocusNode);
                                    },
                                    onChanged: (_) => _validateForm(),
                                    focusNode: _emailFocusNode,
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w200,
                                        fontFamily: 'Montserrat',
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
                                          color:
                                              Color.fromARGB(255, 94, 92, 102),
                                        ),
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
                                          fontWeight: FontWeight.w200,
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
                            TextButton(
                                onPressed: () {
                                  showResetPasswordDialog(context);
                                },
                                child: Text(
                                  "Şifremi unuttum",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Montserrat',
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: size.width * 0.038),
                                )),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Container(
                              padding: EdgeInsets.lerp(
                                  EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 8),
                                  EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 8),
                                  0.5),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: Colors.grey[300],
                                      height: 1,
                                      thickness: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 35.0),
                                    child: Text(
                                      "Ya da",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Montserrat',
                                        color: Colors.white,
                                        fontSize: size.width * 0.03,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: Colors.grey[300],
                                      height: 1,
                                      thickness: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
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

                                          await signIn();
                                          if (_auth.currentUser != null) {
                                            AppConfig.login = true.obs;
                                            AppConfig.logind = true;
                                            print("giriş başarılı");
                                            print(
                                                _auth.currentUser!.displayName);

                                            AppConfig.isim = _auth
                                                    .currentUser!.displayName ??
                                                "Kullanıcı";
                                            print("Giriş Başarılı");
                                            Get.snackbar(
                                              "Giriş Başarılı",
                                              "Hoş geldiniz!",
                                              backgroundColor: Colors.grey,
                                              duration: Duration(seconds: 2),
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                            );

                                            // Belirli bir süre sonra HomePage sayfasına geçiş yapılır
                                            Future.delayed(Duration(seconds: 2),
                                                () {
                                              Get.offAll(() => Wrapper());
                                            });
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
                                                content: Text(e.toString()),
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
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            /*    ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize:
                                    Size(size.width * 0.90, size.height * 0.06),
                                primary: _isFormValid
                                    ? Colors.white
                                    : Color.fromRGBO(119, 119, 141, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                              ),
                              child: Text('Devam Et',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Montserrat',
                                      fontSize: size.width * 0.04,
                                      color: Colors.black)),
                              onPressed: () async {},
                            ),
                            */
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Container(
                                padding: EdgeInsets.all(8),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: TextButton(
                                      onPressed: () {
                                        Get.to(LoginPage(),
                                            transition: Transition.cupertino);
                                      },
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
                          ],
                        ),
                      ),
                      Positioned(
                        top: 25,
                        left: 0,
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
