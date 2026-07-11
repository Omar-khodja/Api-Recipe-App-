import 'package:recipe_app/core/entities/meal.dart';
import 'package:recipe_app/core/result.dart';
import 'package:recipe_app/core/usecases/usecase.dart';
import 'package:recipe_app/featurs/search/domain/repo/search_base_repo.dart';

class SearchByNameUsecase implements UseCases<List<Meal>, String> {
  SearchByNameUsecase({required this.repo});
  final SearchBaseRepo repo;
  @override
  Future<ResultState<List<Meal>>> call(String params) async {
    return await repo.searchByName(params);
  }
}

