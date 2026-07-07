import 'package:recipe_app/core/result.dart';
import 'package:recipe_app/core/usecases/usecase.dart';
import 'package:recipe_app/featurs/favorite_meals/domain/entities/meal.dart';
import 'package:recipe_app/featurs/favorite_meals/domain/repo/favorite_meals_base_repo.dart';

class DeleteFromFavoriteMealUsecase implements UseCases<String, Meal> {
  DeleteFromFavoriteMealUsecase({required this.repo});
  final FavoriteMealBaseRepo repo;
  @override
  Future<Result<String>> call(Meal meal) async {
    return await repo.deleteFromFavorite(meal);
  }
}
