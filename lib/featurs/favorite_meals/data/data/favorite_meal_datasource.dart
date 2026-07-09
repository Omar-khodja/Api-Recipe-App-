import 'package:recipe_app/core/error/data_exception.dart';
import 'package:recipe_app/featurs/favorite_meals/data/data/favoritemeal_base_datasouce.dart';
import 'package:recipe_app/core/models/meal_moudel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as p;

class FavoriteMealDatasource implements FavoriteMealBaseDatasource {
  @override
  Future<List<MealMoudel>> getAllFavoriteMeals() async {
    try {
      final db = await getData();
      final data = await db.query('Meals');

      return data.map((e) => MealMoudel.fromDatabase(e)).toList();
    } on LocalDataBaseExceptions catch (e) {
      throw LocalDataBaseExceptions('Error fetching favorite meals: $e');
    }
  }

  @override
  Future<bool> addToFavorite(MealMoudel meal) async {
    try {
      final db = await getData();
      await db.insert('Meals', meal.toDatabase(meal));
      return true;
    } on LocalDataBaseExceptions catch (e) {
      throw LocalDataBaseExceptions('Error adding to favorite meals: $e');
    }
  }

  @override
  Future<bool> deletefromFavorite(MealMoudel meal) async {
    try {
      final db = await getData();

      await db.delete('Meals', where: 'id = ?', whereArgs: [meal.id]);
      return true;
    } on LocalDataBaseExceptions catch (e) {
      throw LocalDataBaseExceptions('Error deleting from favorite meals: $e');
    }
  }

  Future<Database> getData() async {
    try {
      final dbpath = await sql.getDatabasesPath();
      final path = p.join(dbpath, 'favorite_meals.db');
      final db = await sql.openDatabase(
        path,
        onCreate: (db, version) => db.execute(
          "CREATE TABLE Meals(id TEXT PRIMARY KEY , meal TEXT , area TEXT,category TEXT , image TEXT,instructions TEXT ,youtube TEXT,isFavorite INTEGER)",
        ),
        version: 1,
      );
      return db;
    } catch (e, st) {
      throw Exception('Error opening database: $e\n$st');
    }
  }
}
