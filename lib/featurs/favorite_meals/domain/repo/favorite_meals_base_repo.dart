import 'package:recipe_app/core/result.dart';
import 'package:recipe_app/featurs/favorite_meals/domain/entities/meal.dart';

abstract class FavoriteMealBaseRepo {
  Future<ResultState<List<Meal>>> getAllFavoriteMeals();
  Future<ResultState<String>> addToFavorite(Meal meal);
  Future<ResultState<String>> deleteFromFavorite(Meal meal);
}