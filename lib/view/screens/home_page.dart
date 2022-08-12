import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:food_recipes/controller/providers/category.dart';
import 'package:food_recipes/controller/providers/recipe_provider.dart';
import 'package:food_recipes/model/recipe_model.dart';
import 'package:food_recipes/view/screens/add_recipe.dart';
import 'package:food_recipes/view/screens/recipe_details.dart';
import 'package:food_recipes/view/widgets/category_card.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'HomePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:() async{
        return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('You Really want to leave?'),
            actions: [
              TextButton(
                  onPressed:(){
                    SystemNavigator.pop();
                  },
                  child: Text('Yes')),
              TextButton(
                  onPressed:(){
                    Navigator.pop(context);
                  },
                  child: Text('No')),
            ],
          ),
        ));
      }
      ,
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Mis Recetas',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.redAccent,
                      fontFamily: 'CormorantSC'),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 50,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 10,
                    );
                  },
                  itemCount: Provider.of<CategoryProvider>(context, listen: false)
                      .categoryList
                      .length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Provider.of<CategoryProvider>(context, listen: false)
                              .selectedHomeCategory(index);
                        },
                        child: CategoryCard(context, index));
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder<List<RecipeModel>>(
                  future: Provider.of<RecipeProvider>(context, listen: false)
                      .getRecipes(Provider.of<CategoryProvider>(context)
                                  .homeCategory ==
                              null
                          ? Provider.of<CategoryProvider>(context, listen: false)
                              .homeCategory = 'Carne'
                          : Provider.of<CategoryProvider>(context).homeCategory!),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? snapshot.data!.isEmpty
                            ? const Center(
                                heightFactor: 11,
                                child: Text(
                                  'There are no Recipes',
                                  style: TextStyle(
                                      fontSize: 28,
                                      color: Colors.redAccent,
                                      fontStyle: FontStyle.italic),
                                ),
                              )
                            : Expanded(
                                child: ListView.separated(
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 10,
                                  );
                                },
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return Slidable(
                                   key: UniqueKey(),
                                    startActionPane: ActionPane(
                                      motion: StretchMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (BuildContext context) {
                                            setState(() {});
                                            Provider.of<RecipeProvider>(context,
                                                    listen: false)
                                                .deleteRecipe(
                                                    snapshot.data![index].id!);
                                          },
                                          label: 'Delete',
                                          icon: Icons.delete_forever,
                                          backgroundColor: Colors.red,
                                        )
                                      ],
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, RecipeDetails.routeName,
                                            arguments: RecipeModel(
                                              id: snapshot.data![index].id,
                                              recImage:
                                                  snapshot.data![index].recImage!,
                                              recName:
                                                  snapshot.data![index].recName!,
                                              recIngredients: snapshot
                                                  .data![index].recIngredients!,
                                              recPreparation: snapshot
                                                  .data![index].recPreparation!,
                                              recCategory: snapshot
                                                  .data![index].recCategory!,
                                            ));
                                      },
                                      child: Hero(
                                        tag: snapshot.data![index].recName!,
                                        child: Card(
                                            elevation: 4,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(10.0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(20),
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      width: 100,
                                                      height: 100,
                                                      imageUrl: snapshot
                                                          .data![index].recImage!,
                                                      placeholder: (context,
                                                              url) =>
                                                          Center(
                                                              child: LoadingAnimationWidget
                                                                  .inkDrop(
                                                                      color: Colors
                                                                          .redAccent,
                                                                      size: 40)),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 20),
                                                  child: Text(
                                                    snapshot
                                                        .data![index].recName!,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontFamily: 'CormorantSC',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                )
                                              ],
                                            )),
                                      ),
                                    ),
                                  );
                                },
                              ))
                        : snapshot.hasError
                            ? Center(
                                child: Text(snapshot.error.toString()),
                              )
                            : Center(
                                child: LoadingAnimationWidget.beat(
                                    color: Colors.redAccent, size: 10),
                              );
                  })
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFFFFAEC8),
          onPressed: () {
            Navigator.pushNamed(context, AddRecipe.routeName);
          },
          child: const Icon(
            Icons.add,
            color: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}
