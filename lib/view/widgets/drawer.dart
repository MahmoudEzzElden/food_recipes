import 'package:flutter/material.dart';

import '../screens/category_page.dart';
import 'drawer_list_tile.dart';

class recetaDrawer extends StatelessWidget {
  const recetaDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFFFAEC8),
      child:

      ListView(
        children:  [
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              'Categories',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          DrawerTile(
            onTap: (){

              Navigator.popAndPushNamed(context, CategoryPage.routeName,arguments: 'Pollo');
            },
            title: 'Pollo',
            image: 'assets/icons/chicken.png',
          ),
          DrawerTile(
            onTap: (){
              Navigator.popAndPushNamed(context, CategoryPage.routeName,arguments: 'Carne');
            },
            title: 'Carne',
            image: 'assets/icons/meat.png',
          ),
          DrawerTile(
            onTap: (){
              Navigator.popAndPushNamed(context, CategoryPage.routeName,arguments: 'Arroz Y Pasta');
            },
            title: 'Arroz Y Pasta',
            image: 'assets/icons/pasta.png',
          ),
          DrawerTile(
            onTap: (){
              Navigator.popAndPushNamed(context, CategoryPage.routeName,arguments: 'Panes');
            },
            title: 'Panes',
            image: 'assets/icons/bread.png',
          ),
          DrawerTile(
            onTap: (){
              Navigator.popAndPushNamed(context, CategoryPage.routeName,arguments: 'Postres');
            },
            title: 'Postres',
            image: 'assets/icons/dessert.png',
          ),
          DrawerTile(
            onTap: (){
              Navigator.popAndPushNamed(context, CategoryPage.routeName,arguments: 'Salsas');
            },
            title: 'Salsas',
            image: 'assets/icons/sause.png',
          ),
        ],
      ),
    );
  }
}
