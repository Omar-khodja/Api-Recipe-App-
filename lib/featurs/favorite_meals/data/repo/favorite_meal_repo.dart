import 'package:recipe_app/core/app_logget.dart';
import 'package:recipe_app/core/error/data_exception.dart';
import 'package:recipe_app/core/error/failure.dart';
import 'package:recipe_app/core/result.dart';
import 'package:recipe_app/featurs/favorite_meals/data/data/favoritemeal_base_datasouce.dart';
import 'package:recipe_app/featurs/favorite_meals/data/model/meal_moudel.dart';
import 'package:recipe_app/featurs/favorite_meals/domain/entities/meal.dart';
import 'package:recipe_app/featurs/favorite_meals/domain/repo/favorite_meals_base_repo.dart';

class FavoriteMealRepo implements FavoriteMealBaseRepo {
  final FavoriteMealBaseDatasource datasource;

  FavoriteMealRepo({required this.datasource});

  @override
  Future<Result<List<Meal>>> getAllFavoriteMeals() async {
    try {
      final result = await datasource.getAllFavoriteMeals();
      return Success(result);
    } on LocalDataBaseExceptions catch (e) {
      AppLogger.e(e.message, className: "FavoriteMealRepo");
      return const Error(LocalDataBaseFailure("Something went wrong while fetching favorite meals"));
    }
  }

  @override
  Future<Result<String>> addToFavorite(Meal meal) async {
    try {
      await datasource.addToFavorite(MealMoudel.fromEntity(meal));
      return const Success("Meal added to favorites");
    } on LocalDataBaseExceptions catch (e) {
      AppLogger.e(e.message, className: "FavoriteMealRepo");
      return const Error(LocalDataBaseFailure('Error adding meal to favorites List'));
    }
  }
  
  @override
  Future<Result<String>> deleteFromFavorite(Meal meal)async {
    try {
      await datasource.deletefromFavorite(MealMoudel.fromEntity(meal));
      return const Success("Meal deleted from favorites");
    }on LocalDataBaseExceptions catch (e) {
      AppLogger.e(e.message, className: "FavoriteMealRepo");
      return const Error(LocalDataBaseFailure('Error deleting meal from favorites List'));
    }

  }
}
