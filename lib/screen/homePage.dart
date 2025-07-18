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
  final TextEditingController _searchControler = TextEditingController();

  void openMealDeatailsScreen(BuildContext context, MealMoudel meal) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => MealDeatails(meal: meal)));
  }

  @override
  void initState() {
    super.initState();
 ref.read(mealApiProvider.notifier).featchdata();
  }

  @override
  void dispose() {
    super.dispose();
    _searchControler.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<MealMoudel>> mealsAsync = ref.watch(mealApiProvider);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchControler,
          style: const TextStyle(color: Colors.white, fontSize: 18),
           autofocus: false,
          decoration: InputDecoration(
            hintText: "Search...",
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            fillColor: Theme.of(context).colorScheme.primaryContainer,
            filled: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(13)),
          ),
          onSubmitted: (value) => ref
              .read(mealApiProvider.notifier)
              .searchByName(_searchControler.text),
        ),
      ),
      body: mealsAsync.when(
        data: (meals) {
          return meals.isEmpty
              ? const Center(child: Text("No Meals Found"))
              : RefreshIndicator(
                onRefresh: () => ref.read(mealApiProvider.notifier).featchdata(),
                child: ListView.builder(
                    itemCount: meals.length,
                    itemBuilder: (context, index) {
                      final meal = meals[index];
                      return MealsCard(
                        meal: meal,
                        openMealDeatailsScreen: () => openMealDeatailsScreen(context, meal),
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
