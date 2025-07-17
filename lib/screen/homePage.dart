import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/model/meal_moudel.dart';
import 'package:recipe_app/provider/mealApiProvider.dart';
import 'package:recipe_app/screen/meal_deatails.dart';
import 'package:recipe_app/widget/meals_card.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});
  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  late final Future<void> provider;

  void openMealDeatailsScreen(BuildContext context, MealMoudel meal) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => MealDeatails(meal: meal)));
  }

  @override
  void initState() {
    super.initState();
    provider = ref.read(mealApiProvider.notifier).featchdata();
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealApiProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Test", style: Theme.of(context).textTheme.titleLarge),
      ),
      body: FutureBuilder(
        future: provider,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: meals.length,
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) => MealsCard(
              meal: meals[index],
              openMealDeatailsScreen: () {
                openMealDeatailsScreen(context, meals[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
