import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/provider/categoryMealProvider.dart';
import 'package:recipe_app/widget/category_card.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});
  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final category = ref.watch(categoryMealProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: category.when(
        data: (data) => data.isEmpty
            ? Center(
                child: Text(
                  "Somthing went wronge try again latter",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              )
            : GridView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                children: data.map((e) => CategoryCard(category: e)).toList(),
              ),
        error: (error, stackTrace) => Center(child: Text("Error: $error")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
