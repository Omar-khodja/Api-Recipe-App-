import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/core/app_logget.dart';
import 'package:recipe_app/core/result.dart';
import 'package:recipe_app/core/usecases/usecase.dart';
import 'package:recipe_app/core/entities/meal.dart';
import 'package:recipe_app/featurs/favorite_meals/domain/usecase/add_to_favorite_meal_usecase.dart';
import 'package:recipe_app/featurs/favorite_meals/domain/usecase/delete_from_favorite_meal_usecase.dart';
import 'package:recipe_app/featurs/favorite_meals/domain/usecase/favorite_meal_usecase.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recipe_app/featurs/favorite_meals/presentation/controler/favoirte_meal_provider.dart';

class FavoritemealNotifire extends StateNotifier<ResultState<List<Meal>>> {
  FavoritemealNotifire({
    required this.addToFavoriteMealUseCase,
    required this.deleteFromFavoriteMealUseCase,
    required this.favoriteMealUseCase,
  }) : super(const LoadingState());
  final AddToFavoriteMealUsecase addToFavoriteMealUseCase;
  final DeleteFromFavoriteMealUsecase deleteFromFavoriteMealUseCase;
  final FavoriteMealUsecase favoriteMealUseCase;
  Future<void> featchFavoriteMeals() async {
    await favoriteMealUseCase.call(const NoParams()).then((value) {
      state = value;
      if (value is ErrorState<List<Meal>>) {
        Fluttertoast.showToast(
          msg: value.errorMessage.message,
          backgroundColor: Colors.red,
          timeInSecForIosWeb: 2,
          gravity: ToastGravity.BOTTOM,
        );
      }
    });
  }

  Future<void> addToFavorite(Meal meal) async {
final bool isFavorite =
        state is SuccessState<List<Meal>> &&
        (state as SuccessState<List<Meal>>).data.any((m) => m.id == meal.id);
    AppLogger.i('isFavorite: $isFavorite');

    if (!isFavorite) {
      await addToFavoriteMealUseCase.call(meal).then((value) {
        if (value is SuccessState<String>) {
          Fluttertoast.showToast(
            msg: value.data,
            backgroundColor: Colors.green,
            timeInSecForIosWeb: 2,
            gravity: ToastGravity.BOTTOM,
          );
          state = SuccessState( [...(state as SuccessState<List<Meal>>).data, meal]);
        } else if (value is ErrorState<String>) {
          Fluttertoast.showToast(
            msg: value.errorMessage.message,
            backgroundColor: Colors.red,
            timeInSecForIosWeb: 2,
            gravity: ToastGravity.BOTTOM,
          );
        }
      });
    } else {
      await deleteFromFavoriteMealUseCase.call(meal).then((value) {
        if (value is SuccessState<String>) {
          Fluttertoast.showToast(
            msg: value.data,
            backgroundColor: Colors.red,
            timeInSecForIosWeb: 2,
            gravity: ToastGravity.BOTTOM,
          );
          state = SuccessState((state as SuccessState<List<Meal>>).data.where((m) => m.id != meal.id).toList());
        } else if (value is ErrorState<String>) {
          Fluttertoast.showToast(
            msg: value.errorMessage.message,
            backgroundColor: Colors.red,
            timeInSecForIosWeb: 2,
            gravity: ToastGravity.BOTTOM,
          );
        }
      });
    }
  }
}

final favoriteMealNotifireProvider =
    StateNotifierProvider<FavoritemealNotifire, ResultState<List<Meal>>>(
      (ref) => FavoritemealNotifire(
        addToFavoriteMealUseCase: ref.read(addToFavoriteMealUsecaseProvider),
        deleteFromFavoriteMealUseCase: ref.read(
          deleteFromFavoriteMealUsecaseProvider,
        ),
        favoriteMealUseCase: ref.read(favoriteMealUsecaseProvider),
      ),
    );
