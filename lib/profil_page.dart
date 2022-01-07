import 'package:flutter/material.dart';
import 'package:project_001/home_page.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import 'auth/forget_password_page.dart';
import 'auth/login_page.dart';
import 'auth_provider.dart';
import 'auth_service.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    var _currentUser =
        Provider.of<AuthProvider>(context, listen: true).currentMyUser;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => HomePage()));
              },
              icon: Icon(Icons.home))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                    height: 250,
                    width: 350,
                    child: imageFromBase64String(_currentUser.userImg)),
                Text(_currentUser.userMail),
              ],
            ),
            Column(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgetPasswordPage(),
                      ),
                    );
                  },
                  child: Text("Şifre Değiştir"),
                ),
                TextButton(
                  onPressed: () {
                    AuthService().firebaseUserDelete();
                    AuthService().firestoreUserDelete(_currentUser.userMail);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const LoginPage()));
                  },
                  child: Text("Hesabı Sil"),
                ),
                TextButton(
                    onPressed: () {
                      AuthService().firebaseSignOut();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => LoginPage()));
                    },
                    child: Text("Çıkış Yap"))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }
}
