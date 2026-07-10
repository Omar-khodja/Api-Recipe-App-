import 'package:recipe_app/core/entities/meal.dart';
import 'package:recipe_app/core/result.dart';
import 'package:recipe_app/core/usecases/usecase.dart';
import 'package:recipe_app/featurs/meals/domain/repo/meals_base_repo.dart';

class FilterByCategoryUsecase extends UseCases<List<Meal>, String> {
  FilterByCategoryUsecase({required this.repo});
  final MealsBaseRepo repo;

  @override
  Future<ResultState<List<Meal>>> call(String params)async {
    return await repo.filterByCategory(params);
  }

  
}