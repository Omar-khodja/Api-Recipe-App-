import 'package:recipe_app/core/dio/dioCcientapi.dart';
import 'package:recipe_app/core/error/data_exception.dart';
import 'package:recipe_app/featurs/category/data/data/category_base_datasource.dart';
import 'package:recipe_app/featurs/category/data/model/category_moudel.dart';

class CategoryApiDatasource implements CategoryBaseDataSource {
  CategoryApiDatasource({required this.client});
  final DioClientApi client;

  @override
  Future<List<CategoryMoudel>> featchCategory() async {
    try {
      final respons = await client.dio.get("categories.php");
      final data = respons.data;
      final meals = data["categories"] as List;
      return meals.map((e) => CategoryMoudel.fromJson(e)).toList();
    } on ApiExceptions catch (e) {
      throw ApiExceptions(e.message);
    }
  }
}
