import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/core/entities/meal.dart';
import 'package:recipe_app/core/result.dart';
import 'package:recipe_app/core/widget/meal_deatails.dart';
import 'package:recipe_app/core/widget/meals_card.dart';
import 'package:recipe_app/featurs/search/presentation/controler/search_notifire_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchState();
}

class _SearchState extends ConsumerState<SearchScreen> {
  void openMealDeatailsScreen(BuildContext context, Meal meal) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => MealDeatails(meal: meal)));
  }

  @override
  Widget build(BuildContext context) {
    final mealsList = ref.watch(searchNotifireProvider);
    return switch (mealsList) {
      LoadingState() => Skeletonizer(
        effect: ShimmerEffect(
          baseColor: Theme.of(context).colorScheme.primary,
        ),
        enabled: true,
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
              height: 150,
              color: Colors.black,
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
      SuccessState(data: final meals) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
          
            Expanded(
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
          ],
        ),
      ),
    };
  }
}
