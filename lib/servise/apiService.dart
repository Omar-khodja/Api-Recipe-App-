import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:recipe_app/model/category_moudel.dart';
import 'package:recipe_app/model/meal_moudel.dart';

String _randomlatter() {
  final random = Random();
  const letters = 'abcdefghijklmnopqrstuvwxyz';
  int index = random.nextInt(letters.length);
  final rlatter = letters[index];
  print(rlatter);
  return rlatter;
}

class Apiservice {
  final _logger = Logger("api service");
  final http.Client client;
  Apiservice({required this.client});

  Future<List<MealMoudel>> featchData() async {
    final latter = _randomlatter();
    final url = Uri.parse(
      "https://www.themealdb.com/api/json/v1/1/search.php?s=$latter",
    );
    try {
      final respons = await client.get(url);
      if (respons.statusCode == 200) {
        _logger.info("Meal Response status: ${respons.statusCode}");

        final data = json.decode(respons.body);
        final meals = data["meals"] as List;
        return meals.map((e) => MealMoudel.fromJson(e)).toList();
      } else {
        _logger.warning("failed to featch data (Meals): ${respons.statusCode}");
      }
    } catch (e, stackTrace) {
      _logger.severe("Exception occurred: $e", e, stackTrace);
    }
    return [];
  }

  Future<List<MealMoudel>> apiSearchByName(String qury) async {
    final url = Uri.parse(
      "https://www.themealdb.com/api/json/v1/1/search.php?s=$qury",
    );
    try {
      final respons = await client.get(url);
      _logger.info("Search Response status: ${respons.statusCode}");

      if (respons.statusCode == 200) {
        final data = json.decode(respons.body);
        _logger.info(data);
        final meals = data["meals"] as List;
        return meals.map((e) => MealMoudel.fromJson(e)).toList();
      } else {
        _logger.warning("failed to featch data (Search) : ${respons.statusCode}");
      }
    } catch (e, stackTrace) {
      _logger.severe("Exception occurred: $e", e, stackTrace);
    }
    return [];
  }

  Future<List<CategoryMoudel>> featchCategory() async {
    final url = Uri.parse(
      "https://www.themealdb.com/api/json/v1/1/categories.php",
    );
    try {
      final respons = await client.get(url);
      _logger.info("Category Response status: ${respons.statusCode}");
      if (respons.statusCode == 200) {
        final data = json.decode(respons.body);
        final meals = data["categories"] as List;
        return meals.map((e) => CategoryMoudel.fromJson(e)).toList();
      } else {
        _logger.warning("failed to featch Category data  : ${respons.statusCode}");
      }
    } catch (e, stackTrace) {
      _logger.severe("Exception occurred: $e", e, stackTrace);
    }
    return [];
  }
  Future<List<MealMoudel>> filterByCategory(String category) async {
    final meals = <MealMoudel>[];
    final url = Uri.parse(
      "https://www.themealdb.com/api/json/v1/1/filter.php?c=$category",
    );

    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final mealsData = data["meals"] as List;

        for (var meal in mealsData) {
          final mealId = meal["idMeal"];
          final detailUrl = Uri.parse(
            "https://www.themealdb.com/api/json/v1/1/lookup.php?i=$mealId",
          );

          final detailResponse = await client.get(detailUrl);
          if (detailResponse.statusCode == 200) {
            final detailData = json.decode(detailResponse.body);
            final mealDetails = detailData["meals"];
            if (mealDetails != null && mealDetails.isNotEmpty) {
              meals.add(MealMoudel.fromJson(mealDetails[0]));
            }
          } else {
            _logger.warning("Failed to fetch meal details for id $mealId");
          }
        }

        return meals;
      } else {
        _logger.warning(
          "Failed to fetch category data: ${response.statusCode}",
        );
      }
    } catch (e, stackTrace) {
      _logger.severe("Exception in filterByCategory: $e", e, stackTrace);
    }

    return [];
  }

}
