import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/core/entities/meal.dart';
import 'package:recipe_app/core/result.dart';
import 'package:recipe_app/core/controler/meals_notifire_provider.dart';
import 'package:recipe_app/core/widget/meal_deatails.dart';
import 'package:recipe_app/core/widget/meals_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MealsScreen extends ConsumerStatefulWidget {
  const MealsScreen({super.key, this.title});
  final String? title;
  @override
  ConsumerState<MealsScreen> createState() => _MealsState();
}

class _MealsState extends ConsumerState<MealsScreen> {

  void openMealDeatailsScreen(BuildContext context, Meal meal) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => MealDeatails(meal: meal)));
  }

  @override
  Widget build(BuildContext context) {
    final mealsList = ref.watch(mealsListProvider);
    return Scaffold(
      appBar: widget.title != null ? AppBar(title: Text(widget.title!)) : null,
      body: switch (mealsList) {
        LoadingState() => Skeletonizer(
          effect: ShimmerEffect(
            baseColor: Theme.of(context).colorScheme.surfaceContainer,
          ),
          enabled: true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) => Card(
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
        ),
        ErrorState(errorMessage: final error) => Center(
          child: Text(
            error.message,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SuccessState(data: final meals) => RefreshIndicator(
          onRefresh: () async {
            ref.read(mealsListProvider.notifier).featchMeals();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
        ),
      },
    );
  }
}
