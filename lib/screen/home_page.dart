import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/model/meal_moudel.dart';
import 'package:recipe_app/provider/favoriteMealProvider.dart';
import 'package:recipe_app/provider/mealApiProvider.dart';
import 'package:recipe_app/screen/favoriteMeal.dart';
import 'package:recipe_app/screen/meal_deatails.dart';
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
    ref.read(mealApiProvider.notifier).featchdata();
  }

  void selectedpage(int index) {
    setState(() {
      _selectedindex = index;
    });
  }
 

  @override
  Widget build(BuildContext context) {
    Widget currentpage = const Meals();
    if (_selectedindex == 1) {
      currentpage = const Favoritemeal();
    }
    return Scaffold(
      body: currentpage,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        currentIndex: _selectedindex,
        fixedColor: Colors.green,
        onTap: (value) {
          selectedpage(value);
        },
        items: const [
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
