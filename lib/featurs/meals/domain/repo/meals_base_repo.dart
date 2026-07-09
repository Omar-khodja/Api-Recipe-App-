import 'package:recipe_app/core/entities/meal.dart';
import 'package:recipe_app/core/result.dart';

abstract class MealsBaseRepo {
  Future<ResultState<List<Meal>>> featchMeals();

}