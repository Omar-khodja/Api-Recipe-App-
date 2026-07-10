import 'package:recipe_app/core/models/meal_moudel.dart';

abstract class MealsBaseDatasource {
  Future<List<MealMoudel>> featchMeals();
  Future<List<MealMoudel>> searchByName(String name);
  Future<List<MealMoudel>> filterByCategory(String category);
}
