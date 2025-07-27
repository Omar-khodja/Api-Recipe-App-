import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/database/localDataBase.dart';
import 'package:recipe_app/model/meal_moudel.dart';
import 'package:recipe_app/provider/mealApiProvider.dart';
import 'package:recipe_app/screen/meal_deatails.dart';
import 'package:recipe_app/widget/meals_card.dart';
import 'package:recipe_app/widget/searchbar.dart';

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
  @override
  void dispose() {
    super.dispose();
    _searchControler.dispose();
  }

  void openMealDeatailsScreen(BuildContext context, MealMoudel meal) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => MealDeatails(meal: meal)));
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<MealMoudel>> mealsAsync = ref.watch(mealApiProvider);
    return Scaffold(
      appBar: AppBar(
        title: widget.showSearchbar
            ? Searchtextfailed(controller: _searchControler)
            : Text(
                widget.title!,
                style: Theme.of(context).textTheme.titleLarge,
              ),
      ),
      body: mealsAsync.when(
        data: (meals) {
          return meals.isEmpty
              ? const Center(child: Text("No Meals Found"))
              : RefreshIndicator(
                  onRefresh: () =>
                      ref.read(mealApiProvider.notifier).featchdata(),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: meals.length,
                    itemBuilder: (context, index) {
                      final meal = meals[index];
                      return MealsCard(
                        meal: meal,
                        openMealDeatailsScreen: () =>
                            openMealDeatailsScreen(context, meal),
                      );
                    },
                  ),
                );
        },
        error: (error, stack) => Center(child: Text("Error: $error")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
