import 'package:recipe_app/core/models/meal_moudel.dart';

abstract class FavoriteMealBaseDatasource {
  Future<List<MealMoudel>> getAllFavoriteMeals();
  Future<bool> addToFavorite(MealMoudel meal);
  Future<bool> deletefromFavorite(MealMoudel meal);
}