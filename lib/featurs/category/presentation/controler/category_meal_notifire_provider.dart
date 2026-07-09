import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/core/result.dart';
import 'package:recipe_app/core/usecases/usecase.dart';
import 'package:recipe_app/featurs/category/domain/entities/category.dart';
import 'package:recipe_app/featurs/category/domain/usecase/featch_category_usecase.dart';
import 'package:recipe_app/featurs/category/presentation/controler/category_provider.dart';


class CategoryMealNotifire
    extends StateNotifier<ResultState<List<Categoryentities>>> {
  CategoryMealNotifire({required this.usecase}) : super(const LoadingState());
  final FetchCategoryUseCase usecase;

  Future<void> featchdata() async {
    state = const LoadingState();
    final category = await usecase.call(const NoParams());

    state = category;
  }
}

final categoryMealProvider =
    StateNotifierProvider<
      CategoryMealNotifire,
      ResultState<List<Categoryentities>>
    >(
      (ref) {
        return CategoryMealNotifire(usecase: ref.read(categoryUseCaseProvider));
      },
    );
