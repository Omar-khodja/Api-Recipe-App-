import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/featurs/category/presentation/controler/category_meal_notifire_provider.dart';
import 'package:recipe_app/featurs/favorite_meals/presentation/controler/favoriteMeal_notifire_provider.dart';
import 'package:recipe_app/core/controler/meals_notifire_provider.dart';
import 'package:recipe_app/featurs/category/presentation/screen/category_screen.dart';
import 'package:recipe_app/featurs/favorite_meals/presentation/screen/favorite_meal_screen.dart';
import 'package:recipe_app/featurs/meals/presentation/screen/meals_screen.dart';
import 'package:recipe_app/featurs/search/presentation/screen/search_screen.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:recipe_app/featurs/search/presentation/widget/searchbar.dart';

class NavigatorScreen extends ConsumerStatefulWidget {
  const NavigatorScreen({super.key});
  @override
  ConsumerState<NavigatorScreen> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<NavigatorScreen> {
  int _selectedindex = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final TextEditingController _searchControler = TextEditingController();
  final screens = const [
    CategoryScreen(),
    MealsScreen(),
    SearchScreen(),
    FavoriteMealScreen(),
  ];
  final titles = const ["Category", "Random Meals", "", "Favorites Meals"];

  @override
  void initState() {
    super.initState();
    ref.read(favoriteMealNotifireProvider.notifier).featchFavoriteMeals();
    ref.read(categoryMealProvider.notifier).featchdata();
    ref.read(mealsListProvider.notifier).featchMeals();
  }

  @override
  void dispose() {
    _searchControler.dispose();
    super.dispose();
  }

  void selectedpage(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _selectedindex == 2
            ? Searchtextfailed(controller: _searchControler)
            : Text(titles[_selectedindex]),
        
      ),
      body: screens[_selectedindex],
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        buttonBackgroundColor: Theme.of(context).colorScheme.secondary,
        backgroundColor: Theme.of(context).colorScheme.surface,
        color: Theme.of(context).colorScheme.secondary,
        key: _bottomNavigationKey,
        index: _selectedindex,
        onTap: (index) => setState(() => selectedpage(index)),
        items: const [
          CurvedNavigationBarItem(child: Icon(Icons.food_bank),
        
          ),
          CurvedNavigationBarItem(child: Icon(Icons.dinner_dining_outlined),
        
          ),
          CurvedNavigationBarItem(child: Icon(Icons.search)),
          CurvedNavigationBarItem(child: Icon(Icons.bookmark_outlined),
        
          ),
        ],
      ),
    );
  }
}
