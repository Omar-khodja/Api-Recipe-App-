import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/core/providers.dart';
import 'package:recipe_app/featurs/meals/data/data/meals%20_datasource.dart';
import 'package:recipe_app/featurs/meals/data/data/meals_base_datasource.dart';
import 'package:recipe_app/featurs/meals/data/repo/meals_repo_impl.dart';
import 'package:recipe_app/featurs/meals/domain/repo/meals_base_repo.dart';
import 'package:recipe_app/featurs/meals/domain/usecase/featch_meals_usecase.dart';
import 'package:recipe_app/featurs/meals/domain/usecase/filter_by_category_usecase.dart';
import 'package:recipe_app/featurs/meals/domain/usecase/search_byname_usecase.dart';

final mealsDateSourceProvider = Provider<MealsBaseDatasource>((ref) {
   return MealDataSource(dioClient: ref.read(dioClientProvider));
 });

 final mealsRepoProvider = Provider<MealsBaseRepo>((ref) {
   return MealsRepoImpl(datasource: ref.read(mealsDateSourceProvider));
 });

 final featchMealsUsecaseProvider = Provider((ref) {
   return FeatchMealsUsecase(repo: ref.read(mealsRepoProvider));
 });
final searchByNameUsecaseProvider = Provider((ref) {
  return SearchByNameUsecase(repo: ref.read(mealsRepoProvider));
});
final filterByCategoryUsecaseProvider = Provider((ref) => FilterByCategoryUsecase(repo: ref.read(mealsRepoProvider)),);