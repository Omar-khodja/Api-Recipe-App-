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
      "http://www.themealdb.com/api/json/v1/1/search.php?s=Arrabiata",
    );
    try {
      final respons = await client.get(url);
      if (respons.statusCode == 200) {
        final data = await json.decode(respons.body);
        _logger.info("Data featched $data");
        final meals = await data["meals"] as List;
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
