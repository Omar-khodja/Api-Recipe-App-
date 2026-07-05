import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/core/dio/dioCcientapi.dart';
import 'package:recipe_app/featurs/category/data/data/category_api_datasource.dart';
import 'package:recipe_app/featurs/category/data/repo/category_repo.dart';
import 'package:recipe_app/featurs/category/domain/usecase/featch_category_usecase.dart';

final categoryBaseDataSourceProvider = Provider((ref) {
  final DioClientApi client = DioClientApi();
  return CategoryApiDatasource(client: client);
});

final categoryRepoProvider = Provider((ref) {
  return CategoryRepo(datasource: ref.read(categoryBaseDataSourceProvider));
});
/////////use case
final categoryUseCaseProvider = Provider((ref) {
  final repo = ref.read(categoryRepoProvider);
  return FetchCategoryUseCase(categoryBaseRepo: repo);
});
