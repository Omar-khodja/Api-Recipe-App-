import 'package:recipe_app/core/models/meal_moudel.dart';

abstract class MealsBaseDatasource {
  Future<List<MealMoudel>> featchMeals();

}