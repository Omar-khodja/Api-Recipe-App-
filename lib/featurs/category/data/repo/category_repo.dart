import 'package:recipe_app/core/app_logget.dart';
import 'package:recipe_app/core/error/data_exception.dart';
import 'package:recipe_app/core/error/failure.dart';
import 'package:recipe_app/core/result.dart';
import 'package:recipe_app/featurs/category/data/data/category_base_datasource.dart';
import 'package:recipe_app/featurs/category/domain/entities/category.dart';
import 'package:recipe_app/featurs/category/domain/repo/category_base_repo.dart';

class CategoryRepo implements CategoryBaseRepo {
  CategoryRepo({required this.datasource});
  final CategoryBaseDataSource datasource;
  @override
  Future<Result<List<Categoryentities>>> featchCategory() async {
    try {
      final result = await datasource.featchCategory();
      return Success(result);
    } on ApiExceptions catch (e) {
      AppLogger.e("Error fetching categories: $e", className: "CategoryRepo");
      return Error(ApiFailure(e.message));
    }
  }
}
