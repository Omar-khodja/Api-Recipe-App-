import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/database/localDataBase.dart';
import 'package:recipe_app/model/meal_moudel.dart';
import 'package:recipe_app/provider/mealApiProvider.dart';
import 'package:recipe_app/screen/meal_deatails.dart';
import 'package:recipe_app/widget/meals_card.dart';
import 'package:recipe_app/widget/searchbar.dart';

class Meals extends ConsumerStatefulWidget {
  const Meals({super.key,required this.showSearchbar,this.title});
  final bool showSearchbar;
  final String? title;
  @override
  ConsumerState<Meals> createState() => _MealsState();
}

class _MealsState extends ConsumerState<Meals>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchControler = TextEditingController();
  final Localdatabase localDatabase = Localdatabase();

  late final AnimationController _controller;
  void openMealDeatailsScreen(BuildContext context, MealMoudel meal) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => MealDeatails(meal: meal)));
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _controller.forward();
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
        backgroundColor: widget.showSearchbar? Theme.of(context).colorScheme.primaryContainer: Theme.of(context).colorScheme.primaryContainer,
        title: widget.showSearchbar ? Searchtextfailed(controller: _searchControler) :  Text(widget.title!,style: Theme.of(context).textTheme.titleLarge,),
      ),
      body: mealsAsync.when(
        data: (meals) {
          return meals.isEmpty
                ? const Center(child: Text("No Meals Found"))
                : RefreshIndicator(
                    onRefresh: () =>
                        ref.read(mealApiProvider.notifier).featchdata(),
                    child: AnimatedBuilder(
                      animation: _controller,
                      child: ListView.builder(
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
                      builder: (context, child) {
                        return SlideTransition(
                          position: _controller.drive(
                            Tween<Offset>(
                              begin: const Offset(0, 1),
                              end: Offset.zero,
                            ),
                          ),
                          child: child,
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
