import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:recipe_app/model/meal_moudel.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as p;
import 'package:sqflite/sqlite_api.dart';

final _looger = Logger("FavoriteMealProvider");
Future<Database> _getData() async {
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

class FavoriteMealNotifire extends StateNotifier<AsyncValue<List<MealMoudel>>> {
  FavoriteMealNotifire() : super(const AsyncValue.data([]));

  void featchData() async {
    try {
      final db = await _getData();
      final data = await db.query('Meals');
      state = AsyncValue.data(
        data.map((e) => MealMoudel.fromDatabase(e)).toList(),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      _looger.severe("Error fetching favorite meals", e, st);
    }
  }

  void insertData(MealMoudel meal) async {
    final bool exists =
        state.value?.any((element) => element.id == meal.id) ?? false;
    if (!exists) {
      try {
        final db = await _getData();
        await db.insert('Meals', {
          "id": meal.id,
          "meal": meal.meal,
          "area": meal.area,
          "category": meal.category,
          "image": meal.image,
          "instructions": meal.instructions,
          "youtube": meal.youtube,
          "isFavorite": 1,
        });
        final currentlist = state.value ?? [];
        state = AsyncValue.data([...currentlist, meal]);
      } catch (e, st) {
        state = AsyncValue.error(e, st);
        _looger.severe("Error inserting favorite meal", e, st);
      }
    } else {
      try {
        final db = await _getData();
        await db.delete('Meals', where: 'id = ?', whereArgs: [meal.id]);
        final currentlist = state.value ?? [];
        state = AsyncValue.data(
          currentlist.where((element) => element.id != meal.id).toList(),
        );
      } catch (e, st) {
        state = AsyncValue.error(e, st);
        _looger.severe("Error deleting favorite meal", e, st);
      }
    }
  }
}

final favoriteMealProvider =
    StateNotifierProvider<FavoriteMealNotifire, AsyncValue<List<MealMoudel>>>((
      ref,
    ) {
      return FavoriteMealNotifire();
    });
