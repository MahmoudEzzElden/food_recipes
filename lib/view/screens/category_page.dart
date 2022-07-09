import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  static const String routeName='CategoryPage';
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String category=ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(

    );
  }
}
