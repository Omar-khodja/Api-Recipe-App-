
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/core/providers.dart';
import 'package:recipe_app/featurs/search/data/data/search_datasource.dart';
import 'package:recipe_app/featurs/search/data/repo/search_repo_impl.dart';
import 'package:recipe_app/featurs/search/domain/usecase/search_byname_usecase.dart';

final searchDataSourceProvider = Provider((ref) => SearchDatasource(dioClient: ref.read(dioClientProvider)),);
final searchRepoProvider = Provider((ref) => SearchRepoImpl(datasource: ref.read(searchDataSourceProvider)),);


final searchByNameUsecaseProvider = Provider((ref) {
  return SearchByNameUsecase(repo: ref.read(searchRepoProvider));
});
