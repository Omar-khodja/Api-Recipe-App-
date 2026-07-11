import 'package:recipe_app/core/app_logget.dart';
import 'package:recipe_app/core/entities/meal.dart';
import 'package:recipe_app/core/error/data_exception.dart';
import 'package:recipe_app/core/error/failure.dart';
import 'package:recipe_app/core/result.dart';
import 'package:recipe_app/featurs/search/data/data/search_base_datasource.dart';
import 'package:recipe_app/featurs/search/domain/repo/search_base_repo.dart';

class SearchRepoImpl implements SearchBaseRepo {
  SearchRepoImpl({required this.datasource});
  final SearchBaseDateSource datasource;
    @override
  Future<ResultState<List<Meal>>> searchByName(String name) async {
    try {
      final result = await datasource.searchByName(name);
      return SuccessState(result);
    } on ApiExceptions catch (e) {
      AppLogger.e(e.message, className: e.runtimeType.toString());
      return ErrorState(ApiFailure(e.message));
    } catch (e) {
      AppLogger.e(e.toString(), className: e.runtimeType.toString());
      return ErrorState(ApiFailure(e.toString()));
    }
  }
  
}