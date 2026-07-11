import 'package:recipe_app/core/entities/meal.dart';
import 'package:recipe_app/core/result.dart';

abstract class SearchBaseRepo {
    Future<ResultState<List<Meal>>> searchByName(String name);

}