import 'package:recipe_app/core/app_logget.dart';
import 'package:recipe_app/core/entities/meal.dart';
import 'package:recipe_app/core/error/data_exception.dart';
import 'package:recipe_app/core/error/failure.dart';
import 'package:recipe_app/core/result.dart';
import 'package:recipe_app/featurs/meals/data/data/meals_base_datasource.dart';
import 'package:recipe_app/featurs/meals/domain/repo/meals_base_repo.dart';

class MealsRepoImpl implements MealsBaseRepo {
  MealsRepoImpl({required this.datasource});
  final MealsBaseDatasource datasource;
  @override
  Future<ResultState<List<Meal>>> featchMeals() async {
    try {
      final result = await datasource.featchMeals();
      return SuccessState(result);
    }on ApiExceptions catch (e) {
      AppLogger.e(e.message,className: e.runtimeType.toString());
      return ErrorState(ApiFailure(e.message));
    }
    
  }
}