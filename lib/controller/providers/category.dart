import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier{
  String? categryValue;
  String? homeCategory;
  List categoryList = ['Carne', 'Pollo','Arroz Y Pasta','Salsas','Panes','Postres'];
  selectedCategory(String g){
    categryValue=g;
    notifyListeners();
  }
  selectedHomeCategory(int ind){
    homeCategory=categoryList[ind];
    notifyListeners();
  }
}