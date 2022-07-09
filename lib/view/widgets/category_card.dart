
import 'package:flutter/material.dart';
import 'package:food_recipes/controller/providers/category.dart';
import 'package:provider/provider.dart';

Widget CategoryCard(BuildContext context,int index) {


 return Container(
   width: 120,
   decoration: BoxDecoration(
     borderRadius: BorderRadius.circular(8.0),
     color: Provider.of<CategoryProvider>(context).homeCategory==Provider.of<CategoryProvider>(context).categoryList[index]?
     Colors.white60:
     Color(0xFFfff5f4),
     boxShadow: [
       BoxShadow(
         color: Colors.lightGreen,
         blurRadius: 2.0,
         spreadRadius: 0.0,
        // offset: Offset(2.0, 2.0),
       )
     ],
   ),
    child: Center(child: Text('${Provider.of<CategoryProvider>(context).categoryList[index]}',
      style: TextStyle(fontSize: 18,color:Colors.lightGreen),),),
  );
}