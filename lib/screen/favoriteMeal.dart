import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/model/meal_moudel.dart';
import 'package:recipe_app/provider/favoriteMealProvider.dart';
import 'package:recipe_app/screen/meal_deatails.dart';
import 'package:recipe_app/widget/meals_card.dart';

class Favoritemeal extends ConsumerWidget {
  const Favoritemeal({super.key});
  void openMealDeatailsScreen(BuildContext context, MealMoudel meal) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => MealDeatails(meal: meal)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Meals'),
        
      ),
      body: favoriteMeals.when(
        data: (meals) => meals.isEmpty
            ? Center(
                child: Text(
                  "Favorite meals is empty ",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              )
            : ListView.builder(
                itemCount: meals.length,
                itemBuilder: (context, index) {
                  final meal = meals[index];
                  return MealsCard(
                    meal: meal,
                    openMealDeatailsScreen: () {
                      openMealDeatailsScreen(context, meal);
                    },
                  );
                },
              ),
        error: (error, stack) => Center(child: Text("Error: $error")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
