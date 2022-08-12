import 'package:bulleted_list/bulleted_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:food_recipes/controller/providers/recipe_provider.dart';
import 'package:food_recipes/view/screens/home_page.dart';
import 'package:food_recipes/view/widgets/custome_text_field.dart';
import 'package:provider/provider.dart';
import '../../model/recipe_model.dart';

class RecipeDetails extends StatefulWidget {
  static const String routeName = 'RecipeDetails';

  const RecipeDetails({Key? key}) : super(key: key);

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  final ingredientController = TextEditingController();
  final preparationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as RecipeModel;
    ingredientController.text = arguments.recIngredients!;
    preparationController.text = arguments.recPreparation!;
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Estás seguro, esto descartará tus cambios.'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, HomePage.routeName);
                          Provider.of<RecipeProvider>(context,listen: false).editMode=false;
                        },
                        child: const Text('Yes')),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('No')),
                  ],
                ));
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        arguments.recName!,
                        style: const TextStyle(
                            fontSize: 26, color: Colors.redAccent),
                      ),
                      IconButton(
                        onPressed: () {
                          Provider.of<RecipeProvider>(context, listen: false)
                              .changeMode();
                        },
                        icon: const Icon(Icons.edit),
                        color: Colors.redAccent,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Hero(
                    tag: arguments.recName!,
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          width: 300,
                          height: 300,
                          imageUrl: arguments.recImage!,
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    height: 40,
                    thickness: 5,
                  ),
                  const Text(
                    'Ingredients:',
                    style: TextStyle(fontSize: 24, color: Colors.redAccent),
                  ),
                  Provider.of<RecipeProvider>(context).editMode == false
                      ? BulletedList(
                          listItems: arguments.recIngredients!.split('\n'),
                          bullet: const Icon(
                            Icons.star,
                            color: Colors.lightGreen,
                          ),
                          style: const TextStyle(fontSize: 18),
                        )
                      : CustomFormField(
                          controller: ingredientController,
                        ),
                  const Divider(
                    height: 40,
                    thickness: 5,
                  ),
                  const Text('Preparation:',
                      style: TextStyle(fontSize: 24, color: Colors.redAccent)),
                  Provider.of<RecipeProvider>(context).editMode == false
                      ? BulletedList(
                          listItems: arguments.recPreparation!.split('\n'),
                          bullet: const Icon(
                            Icons.ac_unit_sharp,
                            color: Colors.lightBlueAccent,
                          ),
                          style: const TextStyle(fontSize: 18),
                        )
                      : CustomFormField(
                          controller: preparationController,
                        )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Visibility(
          visible: Provider.of<RecipeProvider>(context).editMode!,
          child: FloatingActionButton(
            onPressed: () {
              EasyLoading.show(status: 'Updating...');
              Provider.of<RecipeProvider>(context, listen: false)
                  .updateRecipe(RecipeModel(
                    id: arguments.id,
                    recName: arguments.recName,
                    recPreparation: preparationController.text,
                    recCategory: arguments.recCategory,
                    recImage: arguments.recImage,
                    recIngredients: ingredientController.text,
                  ))
                  .then((value) => EasyLoading.dismiss().then((value) =>
                      Navigator.pushNamed(context, HomePage.routeName)));
              Provider.of<RecipeProvider>(context, listen: false).editMode =
                  false;
            },
            backgroundColor: Colors.redAccent,
            child: const Icon(
              Icons.save,
              color: Colors.lightBlueAccent,
            ),
          ),
        ),
      ),
    );
  }
}
