import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_001/product_detail_page.dart';
import 'package:provider/provider.dart';

import 'add_product_page.dart';
import 'auth_provider.dart';
import 'home_page.dart';

class QrScanPage extends StatefulWidget {
  const QrScanPage({Key? key}) : super(key: key);

  @override
  _QrScanPageState createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {
  String _scanBarcode = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      uruneGit(_scanBarcode);
    });
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      uruneGit(_scanBarcode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('Barcode scan'), actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HomePage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.home)),
            ]),
            body: Builder(builder: (BuildContext context) {
              return Container(
                  alignment: Alignment.center,
                  child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                            onPressed: () => scanBarcodeNormal(),
                            child: Text('Barcode Tarama')),
                        ElevatedButton(
                            onPressed: () => scanQR(),
                            child: Text('QR Tarama')),
                        Text('Tarama Sonucu : $_scanBarcode\n',
                            style: TextStyle(fontSize: 20))
                      ]));
            })));
  }

  uruneGit(String scanBarcode) {
    List<String> product = [];
    if (scanBarcode == "barcode37") {
      product = [
        "Ürün adı",
        "Açıklama",
        "Eklenme tarihi",
        "marketAdı",
        "ücret",
        "ekleyenUser",
        "fotoPath",
      ];
    }
    product.length >= 5
        ? {
            Provider.of<AuthProvider>(context, listen: false).setProduct =
                product,
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProductDetailPage()))
          }
        : Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductPage(),
            ),
          );
  }
}
