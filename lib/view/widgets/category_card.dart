
import 'package:flutter/material.dart';
import 'package:food_recipes/controller/providers/category.dart';
import 'package:provider/provider.dart';

Widget CategoryCard(BuildContext context,int index) {
List<String> icons=['assets/icons/meat.png','assets/icons/chicken.png','assets/icons/rice.png','assets/icons/pasta.png','assets/icons/sause.png','assets/icons/bread.png','assets/icons/dessert.png','assets/icons/extras.png'];

 return Container(
   width: 120,
   decoration: BoxDecoration(
     borderRadius: BorderRadius.circular(8.0),
     color: Provider.of<CategoryProvider>(context).homeCategory==Provider.of<CategoryProvider>(context).categoryList[index]?
     Colors.white60:
     const Color(0xFFfff5f4),
     boxShadow: const [
       BoxShadow(
         color: Colors.lightGreen,
         blurRadius: 2.0,
         spreadRadius: 0.0,
        // offset: Offset(2.0, 2.0),
       )
     ],
   ),
    child: Row(
      children: [
        Image.asset(icons[index]),
         SizedBox(width:2,),
        Text('${Provider.of<CategoryProvider>(context).categoryList[index]}',
          style:  TextStyle(fontSize: 18,color:Colors.lightGreen),),
      ],
    ),
  );
}