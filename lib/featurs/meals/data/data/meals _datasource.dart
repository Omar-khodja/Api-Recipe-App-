import 'dart:math';

import 'package:recipe_app/core/dio/dioCcientapi.dart';
import 'package:recipe_app/core/error/data_exception.dart';
import 'package:recipe_app/core/models/meal_moudel.dart';
import 'package:recipe_app/featurs/meals/data/data/meals_base_datasource.dart';

class MealDataSource extends MealsBaseDatasource {
  MealDataSource({required this.dioClient});
  final DioClientApi dioClient;
  String _randomlatter() {
    final random = Random();
    const letters = 'abcdefghijklmnopqrstuvwxyz';
    int index = random.nextInt(letters.length);
    final rlatter = letters[index];
    return rlatter;
  }

  @override
  Future<List<MealMoudel>> featchMeals() async {
    final latter = _randomlatter();

    try {
      dynamic response = await dioClient.dio.get('search.php?s=$latter');
      if (response.data['meals'] == null) {
        throw ApiExceptions("Somthing went wrong refresh the page");
      }
      final data = response.data['meals'] as List;

      final List<MealMoudel> mealsList = data
          .map((meal) => MealMoudel.fromJson(meal))
          .toList();
      return mealsList;
    } on ApiExceptions catch (e) {
      throw ApiExceptions(e.message);
    }
  }

  @override
  Future<List<MealMoudel>> searchByName(String name) async {
    try {
      dynamic response = await dioClient.dio.get('search.php?s=$name');
      if (response.data['meals'] == null) {
        throw ApiExceptions("No meals found for the given name.");
      }
      final data = response.data['meals'] as List;

      final List<MealMoudel> mealsList = data
          .map((meal) => MealMoudel.fromJson(meal))
          .toList();
      return mealsList;
    } on ApiExceptions catch (e) {
      throw ApiExceptions(e.message);
    }
  }

  @override
  Future<List<MealMoudel>> filterByCategory(String category) async {
    final meals = <MealMoudel>[];

    try {
      dynamic response = await dioClient.dio.get('filter.php?c=$category');
      if (response.data['meals'] == null) {
        throw ApiExceptions("No meals found for the given category.");
      }
      final mealsData = response.data["meals"] as List;

      for (var meal in mealsData) {
        final mealId = meal["idMeal"];
        final mealsDetailsResponse = await dioClient.dio.get(
          'lookup.php?i=$mealId',
        );
        final mealDetails = mealsDetailsResponse.data["meals"];
        if (mealDetails != null && mealDetails.isNotEmpty) {
          meals.add(MealMoudel.fromJson(mealDetails[0]));
        }
      }
      return meals; 


    } on ApiExceptions catch (e) {
      throw ApiExceptions(e.message);
    }
  }
}
