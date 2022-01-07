import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'models/user_model.dart';

class AuthProvider with ChangeNotifier {
  late UserCredential _currentUser;
  late UserModel _currentUserModel;

  static List<String> _product = [
    "Ürün adı",
    "Açıklama",
    "Eklenme tarihi",
    "marketAdı",
    "ücret",
    "ekleyenUser",
    "fotoPath",
  ];

  List<String> get product => _product;
  set setProduct(List<String> product) {
    _product = product;
  }

  UserCredential get currentUser => _currentUser;
  set setCurrentUser(UserCredential val) {
    _currentUser = val;
  }

  UserModel get currentMyUser => _currentUserModel;
  set setCurrentMyUser(UserModel val) {
    _currentUserModel = val;
  }
}
