import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/provider/categoryMealProvider.dart';
import 'package:recipe_app/provider/mealApiProvider.dart';
import 'package:recipe_app/screen/meals.dart';
import 'package:recipe_app/widget/category_card.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});
  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  bool _isLoading = false;

  void selectedCategory(BuildContext context, String categorie) async {
    setState(() {
      _isLoading = true;
    });
    await ref.read(mealApiProvider.notifier).filterByCategory(categorie);
    if (!mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Meals(showSearchbar: false, title: categorie),
      ),
    );
    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final category = ref.watch(categoryMealProvider);
    return Scaffold(
      appBar: AppBar(title:  Text('Categories',style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),),),
      body: Stack(
        children: [
          category.when(
            data: (data) => data.isEmpty
                ? Center(
                    child: Text(
                      "Somthing went wronge try again latter",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  )
                : GridView(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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

            error: (error, stackTrace) => Center(child: Text("Error: $error")),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
          if (_isLoading)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(
                  color: Colors.black.withValues(alpha: 0.5),
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
