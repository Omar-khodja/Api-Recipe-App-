import 'package:recipe_app/core/result.dart';
import 'package:recipe_app/featurs/category/domain/entities/category.dart';

abstract class CategoryBaseRepo {
  Future<ResultState<List<Categoryentities>>> featchCategory();
}