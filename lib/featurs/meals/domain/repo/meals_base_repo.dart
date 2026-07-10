import 'package:recipe_app/core/entities/meal.dart';
import 'package:recipe_app/core/result.dart';

abstract class MealsBaseRepo {
  Future<ResultState<List<Meal>>> featchMeals();
  Future<ResultState<List<Meal>>> searchByName(String name);
  Future<ResultState<List<Meal>>> filterByCategory(String category);
}
