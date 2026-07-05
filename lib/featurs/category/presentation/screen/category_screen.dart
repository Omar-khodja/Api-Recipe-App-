import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/core/result.dart';
import 'package:recipe_app/featurs/category/presentation/controler/category_meal_notifire_provider.dart';
import 'package:recipe_app/provider/mealApiProvider.dart';
import 'package:recipe_app/screen/meals.dart';
import 'package:recipe_app/widget/category_card.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});
  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
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
            Loading() => const Center(child: CircularProgressIndicator()),
            Error(errorMessage: final message) => Center(
              child: Text(message.message),
            ),
            Success(data: final data) => GridView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 200,
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              children: data
                  .map(
                    (e) => CategoryCard(
                      category: e,
                      onCategorySelected: () {
                        selectedCategory(context, e.title);
                      },
                    ),
                  )
                  .toList(),
            ),
          },
        ],
      ),
    );
  }
}
