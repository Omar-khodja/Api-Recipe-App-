import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as p;
import 'package:sqflite/sqlite_api.dart';

class Localdatabase {
  Localdatabase();
  final List<String> _category = [
    "Any",
    "Beef",
    "Breakfast",
    "Chicken",
    "Dessert",
    "Goat",
    "Lamb",
    "Miscellaneous",
    "Pasta",
    "Pork",
    "Seafood",
    "Side",
    "Starter",
    "Vegan",
    "Vegetarian",
  ];
  final List<String> _countries = [
    "Any",
    "American",
    "British",
    "Canadian",
    "Chinese",
    "Croatian",
    "Dutch",
    "Egyptian",
    "Filipino",
    "French",
    "Greek",
    "Indian",
    "Irish",
    "Italian",
    "Jamaican",
    "Japanese",
    "Kenyan",
    "Malaysian",
    "Mexican",
    "Moroccan",
    "Polish",
    "Portuguese",
    "Russian",
    "Spanish",
    "Thai",
    "Tunisian",
    "Turkish",
    "Unknown",
    "Vietnamese",
  ];
  List<String> get category => _category;
  List<String> get countries => _countries;

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
