import 'package:recipe_app/core/result.dart';
import 'package:recipe_app/core/usecases/usecase.dart';
import 'package:recipe_app/featurs/favorite_meals/domain/entities/meal.dart';
import 'package:recipe_app/featurs/favorite_meals/domain/repo/favorite_meals_base_repo.dart';

class FavoriteMealUsecase implements UseCases<List<Meal>, NoParams> {
  FavoriteMealUsecase({required this.repo});
  final FavoriteMealBaseRepo repo;
  @override
  Future<ResultState<List<Meal>>> call(NoParams params) async {
    return await repo.getAllFavoriteMeals();
  }
}
