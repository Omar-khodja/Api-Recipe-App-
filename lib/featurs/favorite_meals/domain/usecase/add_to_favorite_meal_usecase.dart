import 'package:recipe_app/core/result.dart';
import 'package:recipe_app/core/usecases/usecase.dart';
import 'package:recipe_app/core/entities/meal.dart';
import 'package:recipe_app/featurs/favorite_meals/domain/repo/favorite_meals_base_repo.dart';

class AddToFavoriteMealUsecase implements UseCases<String, Meal> {
  AddToFavoriteMealUsecase({required this.repo});
  final FavoriteMealBaseRepo repo;
  @override
  Future<ResultState<String>> call(Meal meal) async {
    return await repo.addToFavorite(meal);
  }
}
