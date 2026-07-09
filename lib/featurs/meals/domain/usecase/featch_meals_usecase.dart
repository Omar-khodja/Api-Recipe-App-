import 'package:recipe_app/core/entities/meal.dart';
import 'package:recipe_app/core/result.dart';
import 'package:recipe_app/core/usecases/usecase.dart';
import 'package:recipe_app/featurs/meals/domain/repo/meals_base_repo.dart';

class FeatchMealsUsecase implements UseCases<List<Meal>, NoParams> {
  FeatchMealsUsecase({required this.repo});
  final MealsBaseRepo repo;
  @override
  Future<ResultState<List<Meal>>> call(NoParams params) async {
    return await repo.featchMeals();
  }

}