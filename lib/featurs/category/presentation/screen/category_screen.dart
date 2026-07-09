import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/core/result.dart';
import 'package:recipe_app/featurs/category/domain/entities/category.dart';
import 'package:recipe_app/featurs/category/presentation/controler/category_meal_notifire_provider.dart';
import 'package:recipe_app/provider/mealApiProvider.dart';
import 'package:recipe_app/screen/meals.dart';
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
    await ref.read(mealApiProvider.notifier).filterByCategory(categorie);
    if (!mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Meals(showSearchbar: false, title: categorie),
      ),
    );
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    final category = ref.watch(categoryMealProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categories',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          switch (category) {
            LoadingState() => Skeletonizer(
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
      ),
    );
  }
}
