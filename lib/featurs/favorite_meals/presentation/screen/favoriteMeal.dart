import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/core/result.dart';
import 'package:recipe_app/core/entities/meal.dart';
import 'package:recipe_app/featurs/favorite_meals/presentation/controler/favoriteMeal_notifire_provider.dart';
import 'package:recipe_app/core/widget/meal_deatails.dart';
import 'package:recipe_app/core/widget/meals_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
        title: const Text(
          'Favorite Meals',
        
        ),
      ),
      body: switch (favoriteMeals) {
        SuccessState(data: final meals) =>
          meals.isEmpty
              ? Center(
                  child: Text(
                    'No favorite meals yet.',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
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
        LoadingState() => Skeletonizer(
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
                    color: Colors.grey[300],
                  ),
                ),
          ),
        ),
        ErrorState() => Center(
          child: RefreshIndicator(
            onRefresh: () => ref
                .read(favoriteMealNotifireProvider.notifier)
                .featchFavoriteMeals(),

            child: const Text('Error loading favorite meals'),
          ),
        ),
      },
    );
  }
}
