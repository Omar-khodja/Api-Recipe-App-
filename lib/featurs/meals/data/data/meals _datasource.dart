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
   
      final  data = response.data['meals'] as List;
   
      final List<MealMoudel> mealsList = data
          .map((meal) => MealMoudel.fromJson(meal)).toList();
      return mealsList;
    } on ApiExceptions catch (e) {
      throw ApiExceptions(e.message);
    }
  } 
}
