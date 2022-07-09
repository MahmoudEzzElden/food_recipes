


import 'package:food_recipes/model/constants.dart';

class RecipeModel{
  final int? id;
  final String? recName;
  final String? recIngredients;
  final String? recPreparation;
  final String? recCategory;
  final String? recImage;



  const RecipeModel({this.id, this.recName, this.recIngredients,this.recPreparation,this.recCategory,this.recImage});

  Map<String,dynamic> toMap(){
    return {recipeName: recName,
      recipeIngredients:recIngredients,
      recipePreparation:recPreparation,
      recipeCategory:recCategory,
      recipeImage:recImage,
    };
  }
//
  factory RecipeModel.fromMap(Map<String,dynamic> map){
    return RecipeModel(
      id: map[recipeID],
      recName:map[recipeName],
      recIngredients:map[recipeIngredients],
      recPreparation:map[recipePreparation],
      recCategory: map[recipeCategory],
      recImage: map[recipeImage],
    );
  }

}