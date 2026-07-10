import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/featurs/category/presentation/controler/category_meal_notifire_provider.dart';
import 'package:recipe_app/featurs/favorite_meals/presentation/controler/favoriteMeal_notifire_provider.dart';
import 'package:recipe_app/core/controler/meals_notifire_provider.dart';
import 'package:recipe_app/featurs/category/presentation/screen/category_screen.dart';
import 'package:recipe_app/featurs/favorite_meals/presentation/screen/favoriteMeal.dart';
import 'package:recipe_app/featurs/meals/presentation/screen/meals.dart';

class NavigatorScreen extends ConsumerStatefulWidget {
  const NavigatorScreen({super.key});
  @override
  ConsumerState<NavigatorScreen> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<NavigatorScreen> {
  int _selectedindex = 0;

  @override
  void initState() {
    super.initState();
    ref.read(favoriteMealNotifireProvider.notifier).featchFavoriteMeals();
    ref.read(categoryMealProvider.notifier).featchdata();
    ref.read(mealsListProvider.notifier).featchMeals();
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
