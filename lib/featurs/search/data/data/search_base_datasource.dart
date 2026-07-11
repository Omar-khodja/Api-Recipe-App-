import 'package:recipe_app/core/models/meal_moudel.dart';

abstract class SearchBaseDateSource {
    Future<List<MealMoudel>> searchByName(String name);

}