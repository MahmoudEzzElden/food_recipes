import 'package:flutter/material.dart';

class HomeCategory with ChangeNotifier{
  String? selectedCategory;
  List categories=['Carne', 'Pollo', 'Arroz Y Pasta', 'Salsas', 'Panes', 'Postres'];
  chooseCategory(int index){
    selectedCategory=categories[index];
    notifyListeners();
  }
}