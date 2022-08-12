import 'package:flutter/material.dart';
import 'package:food_recipes/controller/providers/category.dart';
import 'package:food_recipes/database_service/database_handler.dart';
import 'package:food_recipes/model/recipe_model.dart';
import 'package:provider/provider.dart';

class RecipeProvider with ChangeNotifier{
  bool? editMode=false;
 changeMode(){
   editMode = !editMode!;
   notifyListeners();
 }
List<RecipeModel> list=[];

Future<List<RecipeModel>> getRecipes(String category) async {
  list = await DataBaseHandler.instance.getRecipes();
  list=list.where((element) => element.recCategory==category).toList();
  notifyListeners();
  return list;
}
Future<void> addRecipe(RecipeModel recipeModel) async {
  await DataBaseHandler.instance
      .addRecipe(recipeModel)
     // .then((value) => getRecipes()
 // )
  ;
  notifyListeners();
}

Future<void> deleteRecipe(int id) async {
  await DataBaseHandler.instance.deleteRecipe(id);
  notifyListeners();
}

Future<void> updateRecipe(RecipeModel recipeModel) async {
  await DataBaseHandler.instance.updateRecipe(recipeModel);
  notifyListeners();
}
}