import 'package:food_recipes/model/constants.dart';
import 'package:food_recipes/model/recipe_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHandler {
  static final DataBaseHandler instance = DataBaseHandler._init();

  DataBaseHandler._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _openDB();
    return _database!;
  }

  Future<Database> _openDB()   async {
    String path = join(await getDatabasesPath(), 'recipeDatabase.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
     CREATE TABLE $recipesTable(
     $recipeID $idType,
     $recipeName $textType,
     $recipeIngredients $textType,
     $recipePreparation $textType,
     $recipeCategory $textType,
     $recipeImage $textType
     )
      ''');
  }


  Future<void> addRecipe(RecipeModel recipeModel) async {
    final db = await instance.database;
    await db.insert(recipesTable, recipeModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }


  Future<void> updateRecipe(RecipeModel recipeModel) async {
    final db = await instance.database;
    await db.update(recipesTable, recipeModel.toMap(),
        where: '$recipeID= ?',
        whereArgs:[recipeModel.id]);
  }


  Future<void> deleteRecipe(int id) async {
    final db = await instance.database;
    await db.delete(recipesTable,
        where: '$recipeID= ?',
        whereArgs:[id]);
  }


  Future<List<RecipeModel>> getRecipes() async{
    final db=await instance.database;
    List<Map<String,dynamic>> maps = await db.query(recipesTable);
    return maps.isNotEmpty ?
    maps.map((note) => RecipeModel.fromMap(note)).toList(): [];


  }

//
// Future<void> deleteTable() async{
//   final db =await instance.database;
//   await db.execute("DROP TABLE IF EXISTS $recipesTable");
//
//   await db.execute('''
//    CREATE TABLE $recipesTable(
//    $recipeID $idType,
//    $recipeName $textType,
//    $recipeIngredients $textType,
//    $recipePreparation $textType,
//    $recipeCategory $textType,
//    $recipeImage $textType
//    )
//     ''');
// }

}
