import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/core/entities/meal.dart';
import 'package:recipe_app/core/result.dart';
import 'package:recipe_app/core/usecases/usecase.dart';
import 'package:recipe_app/featurs/meals/domain/usecase/featch_meals_usecase.dart';
import 'package:recipe_app/featurs/meals/presentation/controler/meals_provider.dart';

class MealsNotifire extends StateNotifier<ResultState<List<Meal>>> {
  MealsNotifire({required this.featchMealsUsecase})
    : super(const LoadingState());
  final FeatchMealsUsecase featchMealsUsecase;
  Future<void> featchMeals() async {
    state = const LoadingState();
    final meals = await featchMealsUsecase.call(const NoParams());
    state = meals;
  }
}
final mealsListProvider = StateNotifierProvider<MealsNotifire, ResultState<List<Meal>>>(
  (ref) {
    return MealsNotifire(featchMealsUsecase: ref.read(featchMealsUsecaseProvider));
  },
);