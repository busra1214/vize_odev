import 'package:flutter/material.dart';
import 'package:project_001/profil_page.dart';
import 'package:project_001/qr_scan_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Project 001"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => ProfilPage()));
              },
              icon: Icon(Icons.person),
            ),
          ],
        ),
        body: Center(
          child: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QrScanPage()));
              },
              child: Text("Tarayıcı")),
        ),
      ),
    );
  }
}
