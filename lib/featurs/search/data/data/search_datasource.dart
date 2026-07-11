import 'package:recipe_app/core/dio/dioCcientapi.dart';
import 'package:recipe_app/core/error/data_exception.dart';
import 'package:recipe_app/core/models/meal_moudel.dart';
import 'package:recipe_app/featurs/search/data/data/search_base_datasource.dart';

class SearchDatasource implements SearchBaseDateSource {
  SearchDatasource({required this.dioClient});
    final DioClientApi dioClient;

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

}