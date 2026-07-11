import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/core/entities/meal.dart';
import 'package:recipe_app/core/result.dart';
import 'package:recipe_app/core/usecases/usecase.dart';
import 'package:recipe_app/featurs/meals/domain/usecase/featch_meals_usecase.dart';
import 'package:recipe_app/featurs/meals/domain/usecase/filter_by_category_usecase.dart';
import 'package:recipe_app/featurs/meals/presentation/controler/meals_provider.dart';

class MealsNotifire extends StateNotifier<ResultState<List<Meal>>> {
  MealsNotifire({
    required this.featchMealsUsecase,
    required this.filterByCategoryUsecase,
  }) : super(const LoadingState());
  final FeatchMealsUsecase featchMealsUsecase;
  final FilterByCategoryUsecase filterByCategoryUsecase;
  Future<void> featchMeals() async {
    state = const LoadingState();
    final meals = await featchMealsUsecase.call(const NoParams());
    state = meals;
  }
  Future<void> filterByCategory(String category) async {
    state = const LoadingState();
    final meals = await filterByCategoryUsecase.call(category);
    state = meals;
  }

}
final mealsListProvider =
    StateNotifierProvider<MealsNotifire, ResultState<List<Meal>>>((ref) {
      return MealsNotifire(
        featchMealsUsecase: ref.read(featchMealsUsecaseProvider),
        filterByCategoryUsecase: ref.read(filterByCategoryUsecaseProvider),
      );
    });
