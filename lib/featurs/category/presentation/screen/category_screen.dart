
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/core/controler/meals_notifire_provider.dart';
import 'package:recipe_app/core/result.dart';
import 'package:recipe_app/featurs/category/domain/entities/category.dart';
import 'package:recipe_app/featurs/category/presentation/controler/category_meal_notifire_provider.dart';
import 'package:recipe_app/featurs/meals/presentation/screen/meals_screen.dart';
import 'package:recipe_app/featurs/category/presentation/widget/category_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});
  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  final emptycategory = Categoryentities(id: '', title: 'ssssss', imageUrl: '');

  void selectedCategory(BuildContext context, String categorie) async {
     ref.read(mealsListProvider.notifier).filterByCategory(categorie);
    if (mounted) {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealsScreen(title: categorie),
      ),
    );
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    final category = ref.watch(categoryMealProvider);
    return  Stack(
        children: [
          switch (category) {
            LoadingState() => Skeletonizer(
              effect: ShimmerEffect(
                baseColor: Theme.of(context).colorScheme.surfaceContainer,

              ),
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 200,
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: 6,
                itemBuilder: (context, index) => CategoryCard(
                  category: emptycategory,
                  onCategorySelected: () {},
                ),
              ),
            ),
            ErrorState() => const Center(
              child: Text("somthing went wrong try again later!"),
            ),
            SuccessState(data: final data) => GridView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 200,
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                
              ),
              itemCount: data.length,
              itemBuilder: (context, index) => CategoryCard(
                category: data[index],
                onCategorySelected: () {
                  selectedCategory(context, data[index].title);
                },
              ),
            ),
          },
        ],
      );
  }
}
