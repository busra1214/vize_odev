import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_001/models/user_model.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../auth_provider.dart';
import '../auth_service.dart';
import '../home_page.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _checkbox = false;
  TextEditingController _mailController = TextEditingController();
  TextEditingController _passwordController1 = TextEditingController();
  TextEditingController _passWordController2 = TextEditingController();
  final _signUpFormGlobalKey = GlobalKey<FormState>();
  File? imgFile;
  final imgPicker = ImagePicker();
  String _img64 = "";
  Future<void> showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Seçenekler"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Kamerayı Kullan"),
                    onTap: () {
                      openCamera();
                    },
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: Text("Galeriden Seç"),
                    onTap: () {
                      openGallery();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void openCamera() async {
    var imgCamera = await imgPicker.pickImage(source: ImageSource.camera);
    setState(() {
      imgFile = File(imgCamera!.path);
    });
    Navigator.of(context).pop();
  }

  void openGallery() async {
    var imgGallery = await imgPicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imgFile = File(imgGallery!.path);
    });
    Navigator.of(context).pop();
  }

  Widget displayImage() {
    if (imgFile == null) {
      return Text("Resim seçilmedi!");
    } else {
      final bytes = imgFile!.readAsBytesSync();
      _img64 = base64Encode(bytes);
      return Image.file(
        imgFile!,
        width: 250,
        height: 200,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
            key: _signUpFormGlobalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      displayImage(),
                      SizedBox(height: 30),
                      TextButton(
                        onPressed: () {
                          showOptionsDialog(context);
                        },
                        child: Text("Görsel Seç"),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 22),
                  child: TextFormField(
                    controller: _mailController,
                    validator: (value) {
                      if (RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value!))
                        return null;
                      else
                        return "Lütfen geçerli bir mail adresi giriniz!";
                    },
                    decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: "Mail ",
                        labelStyle: TextStyle(fontSize: 18),
                        contentPadding: EdgeInsets.all(4),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14.0)),
                        )),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 22),
                  child: TextFormField(
                    controller: _passwordController1,
                    validator: (value) {
                      return value!.length < 6
                          ? "Parolanız en az 6 haneli olmalı"
                          : null;
                    },
                    decoration: const InputDecoration(
                        icon: Icon(Icons.api),
                        labelText: "Şifre",
                        labelStyle: TextStyle(fontSize: 18),
                        contentPadding: EdgeInsets.all(4),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14.0)),
                        )),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 22),
                  child: TextFormField(
                    controller: _passWordController2,
                    validator: (value) {
                      return value!.length < 6
                          ? "Parolanız en az 6 haneli olmalı"
                          : null;
                    },
                    decoration: const InputDecoration(
                        icon: Icon(Icons.password_outlined),
                        labelText: "Şifre",
                        labelStyle: TextStyle(fontSize: 18),
                        contentPadding: EdgeInsets.all(4),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14.0)),
                        )),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: _checkbox,
                      onChanged: (value) {
                        setState(() {
                          _checkbox = value!;
                        });
                      },
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                          'Kullanıcı Koşullarını ve Şartları kabul ediyorum'),
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: TextStyle(fontSize: 22),
                    fixedSize: const Size.fromWidth(200),
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 40),
                  ),
                  onPressed: () {
                    if (_signUpFormGlobalKey.currentState!.validate() &&
                        _img64.isNotEmpty &&
                        _checkbox) {
                      signUp();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Lütfen formu tamamlayınız'),
                        ),
                      );
                    }
                  },
                  child: const Text("Kayıt Ol"),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    fixedSize: const Size.fromWidth(200),
                    padding: const EdgeInsets.symmetric(
                        vertical: 22, horizontal: 66),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  child: const Text("Giriş Yap "),
                ),
              ],
            )),
      ),
    );
  }

  signUp() async {
    String answer = await AuthService()
        .firebaseSignUp(_mailController.text, _passwordController1.text);
    if (answer.length > 3) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(answer),
      ));
    } else {
      signIn();
    }
  }

  signIn() async {
    UserCredential user = await AuthService()
        .firebaseSignIn(_mailController.text, _passwordController1.text);
    Provider.of<AuthProvider>(context, listen: false).setCurrentUser = user;
    await AuthService().firestoreUserSet(UserModel(
      _mailController.text,
      _img64,
    ));
    Provider.of<AuthProvider>(context, listen: false).setCurrentMyUser =
        await AuthService().firestoreUserGet(_mailController.text);

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomePage(),
        ));
  }

  String base64String(Uint8List data) {
    return base64Encode(data);
  }
}
