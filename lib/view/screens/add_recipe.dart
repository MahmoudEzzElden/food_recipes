import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_recipes/controller/providers/category.dart';
import 'package:food_recipes/controller/providers/image_handler.dart';
import 'package:food_recipes/controller/providers/recipe_provider.dart';
import 'package:food_recipes/model/recipe_model.dart';
import 'package:food_recipes/view/screens/home_page.dart';
import 'package:food_recipes/view/widgets/custome_text_field.dart';
import 'package:provider/provider.dart';

import '../../database_service/firestorage_service.dart';

class AddRecipe extends StatefulWidget {
  static const String routeName = 'AddRecipe';

  const AddRecipe({Key? key}) : super(key: key);

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  final recipeName = TextEditingController();

  final recipeIngredients = TextEditingController();

  final recipePreparation = TextEditingController();

  @override
  void dispose() {
    recipePreparation.dispose();
    recipeIngredients.dispose();
    recipeName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Add Recipe'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: Text('Choose a method '),
                              actions: [
                                ListTile(
                                  leading: Icon(Icons.image),
                                  title: TextButton(
                                    onPressed: () {
                                      Provider.of<ImageHandler>(context,
                                              listen: false)
                                          .pickGalleryImage();
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Pick From Gallery',
                                      style: TextStyle(color: Colors.redAccent),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(Icons.camera_alt),
                                  title: TextButton(
                                    onPressed: () {
                                      Provider.of<ImageHandler>(context,
                                              listen: false)
                                          .pickCameraImage();
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Pick From Camera',
                                      style: TextStyle(color: Colors.redAccent),
                                    ),
                                  ),
                                ),
                              ],
                            ));
                  },
                  child: ClipRRect(
                    child: Provider.of<ImageHandler>(context).selectedImage ==
                            null
                        ? CachedNetworkImage(
                            fit: BoxFit.cover,
                            width: 150,
                            height: 150,
                            imageUrl:
                                'https://firebasestorage.googleapis.com/v0/b/mi-receta-98762.appspot.com/o/noImage.jpg?alt=media&token=0aec11cb-309b-41aa-b75b-09f8d1c8288f')
                        : Image.file(
                            Provider.of<ImageHandler>(context).selectedImage!,
                            width: 150,
                            height: 150,
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Recipe Name',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent),
              ),
              CustomFormField(
                controller: recipeName,
              ),
              Text(
                'Ingredients',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent),
              ),
              CustomFormField(
                controller: recipeIngredients,
              ),
              Text(
                'Preparation',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent),
              ),
              CustomFormField(
                controller: recipePreparation,
              ),
              DropdownButton(
                borderRadius: BorderRadius.circular(10),
                dropdownColor: Color(0xFFFFAEC8),
                style: TextStyle(color: Colors.black, fontSize: 18),
                icon: Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  color: Colors.redAccent,
                ),
                value: Provider.of<CategoryProvider>(context).categryValue,
                hint: Text(
                  'Select Category',
                  style: TextStyle(fontSize: 18, color: Colors.redAccent),
                ),
                onChanged: (newValue) {
                  Provider.of<CategoryProvider>(context, listen: false)
                      .selectedCategory(newValue as String);
                },
                items: Provider.of<CategoryProvider>(context)
                    .categoryList
                    .map((category) {
                  return DropdownMenuItem(
                      value: category, child: Text(category));
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFFAEC8),
        onPressed: () async {
          await FireStorage.uploadImage(Provider.of<ImageHandler>(context,listen: false).selectedImage!.path, recipeName.text.trim());
          String url= await FirebaseStorage.instance.ref('usersImages/${recipeName.text.trim()}').getDownloadURL();
          await Provider.of<RecipeProvider>(context, listen: false)
              .addRecipe(RecipeModel(
                  recName: recipeName.text.trim(),
                  recIngredients: recipeIngredients.text,
                  recPreparation: recipePreparation.text,
                  recCategory:
                      Provider.of<CategoryProvider>(context, listen: false)
                          .categryValue,
            recImage: url,
          ),)
              .then((value) {
            recipeName.clear();
            recipePreparation.clear();
            recipeIngredients.clear();
            Provider.of<CategoryProvider>(context, listen: false)
                    .categryValue ==
                '';
            Provider.of<ImageHandler>(context,listen: false).selectedImage==null;
            return Navigator.pushNamed(context, HomePage.routeName);
          });
        },
        child: Icon(
          Icons.save,
          color: Colors.redAccent,
        ),
      ),
    );
  }
}
