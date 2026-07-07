import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/core/result.dart';
import 'package:recipe_app/featurs/favorite_meals/domain/entities/meal.dart';
import 'package:recipe_app/featurs/favorite_meals/presentation/controler/favoriteMeal_notifire_provider.dart';
import 'package:recipe_app/screen/meal_deatails.dart';
import 'package:recipe_app/widget/meals_card.dart';

class Favoritemeal extends ConsumerWidget {
  const Favoritemeal({super.key});
  void openMealDeatailsScreen(BuildContext context, Meal meal) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => MealDeatails(meal: meal)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealNotifireProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Meals',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: switch (favoriteMeals) {
        Success(data: final meals) =>
          meals.isEmpty
              ?  Center(child: Text('No favorite meals yet.', style: TextStyle(color: Theme.of(context).colorScheme.onSurface),))
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
        Loading() => const Center(child: CircularProgressIndicator()),
        Error() => const Center(child: Text('Error loading favorite meals')),
      },
    );
  }
}
