import 'package:bulleted_list/bulleted_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../model/recipe_model.dart';

class RecipeDetails extends StatelessWidget {
  static const String routeName='RecipeDetails';
  const RecipeDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments=ModalRoute.of(context)!.settings.arguments as RecipeModel;
    return Scaffold(

      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(arguments.recName!,style: TextStyle(fontSize: 26,color: Colors.redAccent),),
                SizedBox(height: 20,),
                Hero(
                  tag:arguments.recName!,
                  child: Center(
                    child: CachedNetworkImage(
                      width: 300,
                      height: 300,
                      imageUrl: arguments.recImage!,
                    ),
                  ),
                ),
                Divider(height: 40,thickness: 5,),
                Text('Ingredients:',style: TextStyle(fontSize: 24,color: Colors.redAccent),),
                BulletedList(listItems: arguments.recIngredients!.split('\n'),bullet: Icon(Icons.star,color: Colors.lightGreen,),),
                Divider(height: 40,thickness: 5,),
                Text('Preparation:',style: TextStyle(fontSize: 24,color: Colors.redAccent)),
               BulletedList(listItems: arguments.recPreparation!.split('\n'),bullet: Icon(Icons.ac_unit_sharp,color: Colors.lightBlueAccent,),)

              ],
            ),
          ),
        ),
      ),

    );
  }
}
