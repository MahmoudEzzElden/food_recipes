import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:food_recipes/controller/providers/category.dart';
import 'package:food_recipes/controller/providers/home_category.dart';
import 'package:food_recipes/controller/providers/image_handler.dart';
import 'package:food_recipes/controller/providers/recipe_provider.dart';
import 'package:food_recipes/view/screens/add_recipe.dart';
import 'package:food_recipes/view/screens/category_page.dart';
import 'package:food_recipes/view/screens/home_page.dart';
import 'package:food_recipes/view/screens/recipe_details.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<CategoryProvider>(
        create: (context) => CategoryProvider()),
    ChangeNotifierProvider<HomeCategory>(
        create: (context) => HomeCategory()),
    ChangeNotifierProvider<RecipeProvider>(
        create: (context) => RecipeProvider()),
    ChangeNotifierProvider<ImageHandler>(
        create: (context) => ImageHandler()),
  ],
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        routes: {
        AddRecipe.routeName:(context)=>AddRecipe(),
          HomePage.routeName:(context)=>HomePage(),
          CategoryPage.routeName:(context)=>CategoryPage(),
          RecipeDetails.routeName:(context)=>RecipeDetails(),
        },
        home: AnimatedSplashScreen(
          backgroundColor: Color(0xFFFFAEC8),
          nextScreen: HomePage(),
          splash: Image.asset('assets/mi_receta_splash.png'),
          splashIconSize: 400,
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.bottomToTop,
        ),
builder: EasyLoading.init(),
    );
  }
}
