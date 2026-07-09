import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/core/entities/meal.dart';
import 'package:recipe_app/core/result.dart';
import 'package:recipe_app/database/localDataBase.dart';
import 'package:recipe_app/featurs/meals/presentation/controler/meals_notifire_provider.dart';
import 'package:recipe_app/screen/meal_deatails.dart';
import 'package:recipe_app/core/widget/meals_card.dart';
import 'package:recipe_app/widget/searchbar.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Meals extends ConsumerStatefulWidget {
  const Meals({super.key, required this.showSearchbar, this.title});
  final bool showSearchbar;
  final String? title;
  @override
  ConsumerState<Meals> createState() => _MealsState();
}

class _MealsState extends ConsumerState<Meals> {
  final TextEditingController _searchControler = TextEditingController();
  final Localdatabase localDatabase = Localdatabase();
  final Meal mealsempty = Meal(
    id: "",
    meal: "",
    category: "",
    area: "",
    instructions: "",
    image: "",
    youtube: "",
    isFavorite: false,
  );
  @override
  void dispose() {
    super.dispose();
    _searchControler.dispose();
  }

  void openMealDeatailsScreen(BuildContext context, Meal meal) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => MealDeatails(meal: meal)));
  }

  @override
  Widget build(BuildContext context) {
    final mealsList = ref.watch(mealsListProvider);
    return Scaffold(
      appBar: AppBar(
        title: widget.showSearchbar
            ? Searchtextfailed(controller: _searchControler)
            : Text(
                widget.title!,
                style: Theme.of(context).textTheme.titleLarge,
              ),
      ),
      body: switch (mealsList) {
        LoadingState() => Skeletonizer(
            effect: ShimmerEffect(
            baseColor: Colors.grey[800]!, // dark base
            highlightColor: Colors.grey[600]!, // lighter shimmer
          ),
          enabled: true,
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) =>
                 Card(
                  shadowColor: Colors.black,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    width: double.infinity,
                    height: 250,
                    color: Colors.black,
                  ),
                ),
          ),
        ),
        ErrorState(errorMessage: final error) => Center(
          child: Text(error.message),
        ),
        SuccessState(data: final meals) => RefreshIndicator(
          onRefresh: () async {
            ref.read(mealsListProvider.notifier).featchMeals();
          },
          child: ListView.builder(
            itemCount: meals.length,
            itemBuilder: (context, index) => MealsCard(
              meal: meals[index],
              openMealDeatailsScreen: () {
                openMealDeatailsScreen(context, meals[index]);
              },
            ),
          ),
        ),
      },
    );
  }
}
