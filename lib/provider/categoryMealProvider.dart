import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/model/category_moudel.dart';
import 'package:recipe_app/provider/mealApiProvider.dart';
import 'package:recipe_app/servise/apiService.dart';

class CategoryMealNotifire extends StateNotifier<AsyncValue<List<CategoryMoudel>>> {
  CategoryMealNotifire(this.api) : super(const AsyncValue.loading());
  final Apiservice api;
  
  Future<void> featchdata()async {
    try{

    final category = await api.featchCategory();
    state = AsyncValue.data(category);
    }catch(e,st){
      state = AsyncValue.error(e, st);
    }


  }
}

final categoryMealProvider = StateNotifierProvider<CategoryMealNotifire,AsyncValue<List<CategoryMoudel>>>((ref) {
  final Apiservice api = ref.watch(apiServiceProvider);
  return CategoryMealNotifire(api);
});
