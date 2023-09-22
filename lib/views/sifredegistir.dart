import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meditasyon/controllers/config.dart';
import 'package:meditasyon/wrapper.dart';

import 'registerpage.dart';

class PassChangePage extends StatefulWidget {
  @override
  _PassChangePageState createState() => _PassChangePageState();
}

class _PassChangePageState extends State<PassChangePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController oncekisifre = TextEditingController();

  final TextEditingController sifre1 = TextEditingController();
  final TextEditingController sifre2 = TextEditingController();

  final sifre2focus = FocusNode();
  final sifre1focus = FocusNode();
  final oncekisifrefocus = FocusNode();

  bool _isFormValid = false;

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  void _validateForm() {
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

  Future<dynamic> changePassword(
      String email, String password, String newPassword) async {
    try {
      // Get the current user.
      User? user = _auth.currentUser;
      print("gelen şifre" + password);
      print("gelen yeni şifre" + newPassword);
      // Check if the user signed in with Google or Apple.
      for (UserInfo userInfo in user!.providerData) {
        if (userInfo.providerId == 'google.com' ||
            userInfo.providerId == 'apple.com') {
          Get.snackbar(

            "Başarısız",
            "Google/Apple ile giriş yaptıysanız, buradan şifrenizi değiştiremezsiniz.",
            snackPosition: SnackPosition.TOP,
                 backgroundColor: Colors.white.withOpacity(0.9),
          colorText: Colors.black,
           
            icon: Icon(
              Icons.error,
              color: Colors.black,
            ),
          );
          return;
        }
      }

      // Create a new credential with the user's email and password.
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      // Re-authenticate the user with the new credential.
      await user.reauthenticateWithCredential(credential);

      // Then update the password to the new password.
      await user.updatePassword(newPassword);

      print("Şifre değiştirme başarılı");

      return true;
    } on FirebaseAuthException catch (e) {
      print(e.code.toString() + "hhh " + e.message.toString());
      if (e.code == 'user-not-found') {
        print('Kullanıcı bulunamadı!');
      } else if (e.code == 'wrong-password') {
        print('Mevcut şifre yanlış!');
        _auth.sendPasswordResetEmail(email: email);
        Get.snackbar(
          "Başarısız",
          "Mevcut şifre yanlış. Şifre sıfırlama linki e-postanıza gönderildi.",
          snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.white.withOpacity(0.9),
          colorText: Colors.black,
          icon: Icon(
            Icons.error,
            color: Colors.black,
          ),
        );
      } else {
        print('Bir hata oluştu: $e');
      }
    } catch (e) {
      print('Bir hata oluştu: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    oncekisifre.addListener(_validateForm);
    sifre2.addListener(_validateForm);
    sifre1.addListener(_validateForm);
  }

  @override
  void dispose() {
    sifre2.dispose();
    sifre2focus.dispose();
    sifre1.dispose();
    sifre1focus.dispose();
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
                key: _formKey,
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
                              "Şifreni Güncelle",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Montserrat',
                                fontSize: size.height * 0.025,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          SizedBox(
                            height: size.height * 0.12,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: TextFormField(
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context).nextFocus();
                                },
                                onChanged: (_) => _validateForm(),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Lütfen bir şifre girin';
                                  }
                                  if (value.length < 6) {
                                    return 'Şifreniz en az 6 karakter uzunluğunda olmalıdır';
                                  }
                                  return null;
                                },
                                obscureText: true,
                                style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: size.width * 0.04,
                                ),
                                controller: oncekisifre,
                                focusNode: oncekisifrefocus,
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
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Color.fromRGBO(33, 33, 50, 1),
                                  hintText: "Önceki şifrenizi yazınız",
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontSize: size.width * 0.04,
                                  ),
                                  prefixIcon: ImageIcon(
                                    AssetImage('assets/pass.png'),
                                    color: Colors.grey,
                                    size: 22,
                                  ),
                                ),
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
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context).nextFocus();
                                },
                                onChanged: (_) => _validateForm(),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Lütfen bir şifre girin';
                                  }
                                  if (value.length < 6) {
                                    return 'Şifreniz en az 6 karakter uzunluğunda olmalıdır';
                                  }
                                  return null;
                                },
                                obscureText: true,
                                style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: size.width * 0.04,
                                ),
                                controller: sifre1,
                                focusNode: sifre1focus,
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
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Color.fromRGBO(33, 33, 50, 1),
                                  hintText: "Yeni şifrenizi yazınız",
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontSize: size.width * 0.04,
                                  ),
                                  prefixIcon: ImageIcon(
                                    AssetImage('assets/pass.png'),
                                    color: Colors.grey,
                                    size: 22,
                                  ),
                                ),
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
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context).nextFocus();
                                },
                                onChanged: (_) => _validateForm(),
                                validator: (value) {
                                  if (value.toString() !=
                                      sifre1.text.toString()) {
                                    return 'Lütfen aynı şifreyi girin';
                                  }

                                  return null;
                                },
                                obscureText: true,
                                style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: size.width * 0.04,
                                ),
                                controller: sifre2,
                                focusNode: sifre2focus,
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
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Color.fromRGBO(33, 33, 50, 1),
                                    hintText: "Yeni şifrenizi yazınız",
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontSize: size.width * 0.04,
                                    ),
                                    prefixIcon: ImageIcon(
                                      AssetImage('assets/pass.png'),
                                      color: Colors.grey,
                                      size: 22,
                                    )),
                              ),
                            ),
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
                                  : Color.fromRGBO(200, 200, 207, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                            child: Text(
                              'Güncelle',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Montserrat',
                                fontSize: size.width * 0.045,
                                color: Colors.black,
                              ),
                            ),
                            onPressed: () async {
                              if (_isFormValid == true) {
                                try {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  var sonuc = await changePassword(
                                    // Add the necessary parameters here
                                    _auth.currentUser!.email ?? "",
                                    oncekisifre.text.toString(),
                                    sifre2.text.toString(),
                                  );

                                  setState(() {
                                    isLoading = false;
                                  });

                                  if (sonuc == true) {
                                    Get.snackbar(
                                      "Başarılı",
                                      "Şifreniz başarıyla değiştirildi",
                                      snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.white.withOpacity(0.9),
          colorText: Colors.black,
                                      icon: Icon(
                                        Icons.check,
                                        color: Colors.black,
                                      ),
                                    );

                                    Get.to(Wrapper());
                                  }
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
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 30,
                      left: 20,
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
