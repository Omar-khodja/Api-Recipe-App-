import 'package:recipe_app/core/result.dart';
import 'package:recipe_app/core/usecases/usecase.dart';
import 'package:recipe_app/featurs/category/domain/entities/category.dart';
import 'package:recipe_app/featurs/category/domain/repo/category_base_repo.dart';

class FetchCategoryUseCase implements UseCases<List<Categoryentities>, NoParams > {
  FetchCategoryUseCase({required this.categoryBaseRepo});
  final CategoryBaseRepo   categoryBaseRepo;
  @override
  Future<ResultState<List<Categoryentities>>> call(NoParams params) async {
    return await categoryBaseRepo.featchCategory();
  }
}