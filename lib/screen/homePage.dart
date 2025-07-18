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
  final TextEditingController _searchControler = TextEditingController();

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
  void dispose() {
    super.dispose();
    _searchControler.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<MealMoudel> meals = ref.watch(mealApiProvider);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchControler,
          style: const TextStyle(color: Colors.white, fontSize: 18),
          decoration: InputDecoration(
            hintText: "Search...",
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            fillColor: Theme.of(context).colorScheme.primaryContainer,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              
            ),
          ),
          onSubmitted: (value) => ref.read(mealApiProvider.notifier).searchByName(_searchControler.text),
        ),
      
      ),
      body: FutureBuilder(
        future: provider,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if(meals.isNotEmpty){

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
          }
          return  Center(child: Text("No meal founde",style: Theme.of(context).textTheme.titleLarge,));
        },
      ),
    );
  }
}
