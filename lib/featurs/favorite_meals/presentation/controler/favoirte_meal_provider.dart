



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/featurs/favorite_meals/data/data/favorite_meal_datasource.dart';
import 'package:recipe_app/featurs/favorite_meals/data/repo/favorite_meal_repo.dart';
import 'package:recipe_app/featurs/favorite_meals/domain/usecase/add_to_favorite_meal_usecase.dart';
import 'package:recipe_app/featurs/favorite_meals/domain/usecase/delete_from_favorite_meal_usecase.dart';
import 'package:recipe_app/featurs/favorite_meals/domain/usecase/favorite_meal_usecase.dart';

final favoriteMealDataSourceProvider = Provider(
  (ref) => FavoriteMealDatasource(),
);

final favoriteMealRepoProvider = Provider(
  (ref) => FavoriteMealRepo(datasource: ref.read(favoriteMealDataSourceProvider)),
);
//use case
final addToFavoriteMealUsecaseProvider = Provider(
  (ref) => AddToFavoriteMealUsecase(repo: ref.read(favoriteMealRepoProvider)),
);
final deleteFromFavoriteMealUsecaseProvider = Provider(
  (ref) => DeleteFromFavoriteMealUsecase(repo: ref.read(favoriteMealRepoProvider)),
);
final favoriteMealUsecaseProvider = Provider(
  (ref) => FavoriteMealUsecase(repo: ref.read(favoriteMealRepoProvider)),
);