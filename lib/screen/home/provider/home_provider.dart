import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  TextEditingController txtcity = TextEditingController();
  String? city;

  void search() {
    city = txtcity.text;
    notifyListeners();
  }
}