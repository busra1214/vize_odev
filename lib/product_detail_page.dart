import 'package:flutter/material.dart';
import 'package:project_001/home_page.dart';
import 'package:provider/provider.dart';

import 'auth_provider.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  List<String> product = [];
  void initState() {
    super.initState();
    product = Provider.of<AuthProvider>(context, listen: false).product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Detayları"),
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
          children: [
            Container(
              child: Text(
                product[6],
              ),
              height: 150,
              width: 250,
              color: Colors.grey,
              padding: EdgeInsets.all(10),
            ),
            ExpansionTile(
              title: Text(product[0]),
              subtitle: Text(product[1]),
              trailing: Text(product[4]),
              children: [
                Text(product[2]),
                Text(product[3]),
                Text(product[5]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
