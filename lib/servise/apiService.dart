import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:recipe_app/model/meal_moudel.dart';

class Apiservice {
  final _logger = Logger("api service");
  final http.Client client;
  Apiservice({required this.client});

  Future<List<MealMoudel>> featchData() async {
    final url = Uri.parse(
      "https://www.themealdb.com/api/json/v1/1/search.php?s=chicken",
    );
    try {
      final respons = await client.get(url);
      if (respons.statusCode == 200) {
        final data =  json.decode(respons.body);
        final meals =  data["meals"] as List;
        return meals.map((e) => MealMoudel.fromJson(e)).toList();
      } else {
        _logger.warning("failed to featch data : ${respons.statusCode}");
      }
    } catch (e, stackTrace) {
      _logger.severe("Exception occurred: $e", e, stackTrace);
    }
    return [];
  }
}
