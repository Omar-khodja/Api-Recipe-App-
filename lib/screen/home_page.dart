import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/provider/categoryMealProvider.dart';
import 'package:recipe_app/provider/favoriteMealProvider.dart';
import 'package:recipe_app/provider/mealApiProvider.dart';
import 'package:recipe_app/screen/category_screen.dart';
import 'package:recipe_app/screen/favoriteMeal.dart';
import 'package:recipe_app/screen/meals.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedindex = 0;

  @override
  void initState() {
    super.initState();
    ref.read(favoriteMealProvider.notifier).featchData();
    ref.read(categoryMealProvider.notifier).featchdata();
    ref.read(mealApiProvider.notifier).featchdata();
  }

  void selectedpage(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentpage = const CategoryScreen();
    if (_selectedindex == 1) {
      currentpage = const Meals(showSearchbar: true);
    } else if (_selectedindex == 2) {
      currentpage = const Favoritemeal();
    }
    return Scaffold(
      body: currentpage,
      bottomNavigationBar: BottomNavigationBar(
     
        currentIndex: _selectedindex,
        onTap: (value) {
          selectedpage(value);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dinner_dining),
            label: 'Meals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Favorite Meals',
          ),
        ],
      ),
    );
  }
}
