import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:recipe_app/database/localDataBase.dart';
import 'package:recipe_app/model/meal_moudel.dart';


final _looger = Logger("FavoriteMealProvider");


class FavoriteMealNotifire extends StateNotifier<AsyncValue<List<MealMoudel>>> {
  FavoriteMealNotifire() : super(const AsyncValue.data([]));
  final Localdatabase database =  Localdatabase();

  void featchData() async {
    try {
      final db = await database.getData();
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
        final db = await database.getData();
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
        final db = await database.getData();
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
