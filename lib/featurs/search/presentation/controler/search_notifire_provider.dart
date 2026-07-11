import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/core/entities/meal.dart';
import 'package:recipe_app/core/result.dart';
import 'package:recipe_app/featurs/search/domain/usecase/search_byname_usecase.dart';
import 'package:recipe_app/featurs/search/presentation/controler/search_providers.dart';

class SearchNotifire extends StateNotifier<ResultState<List<Meal>>> {
  SearchNotifire({required this.searchByNameUsecase})
    : super(const SuccessState([]));
  final SearchByNameUsecase searchByNameUsecase;

  Future<void> searchByName(String name) async {
    state = const LoadingState();
    final meals = await searchByNameUsecase.call(name);
    state = meals;
  }
}

final searchNotifireProvider = StateNotifierProvider(
  (ref) => SearchNotifire(
    searchByNameUsecase: ref.read(searchByNameUsecaseProvider),
  ),
);
