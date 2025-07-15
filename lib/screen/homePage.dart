import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/provider/mealApiProvider.dart';
import 'package:recipe_app/servise/apiService.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});
  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  
  @override
  void initState() {
    ref.read(mealApiProvider.notifier).featchdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test", style: Theme.of(context).textTheme.titleLarge),

      ),
      
    );
  }
}
