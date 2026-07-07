import 'package:recipe_app/core/result.dart';
import 'package:recipe_app/featurs/favorite_meals/domain/entities/meal.dart';

abstract class FavoriteMealBaseRepo {
  Future<Result<List<Meal>>> getAllFavoriteMeals();
  Future<Result<String>> addToFavorite(Meal meal);
  Future<Result<String>> deleteFromFavorite(Meal meal);
}