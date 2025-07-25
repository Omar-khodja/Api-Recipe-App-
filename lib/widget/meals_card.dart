import 'package:flutter/material.dart';
import 'package:recipe_app/model/meal_moudel.dart';
import 'package:recipe_app/widget/mealcard_content.dart';
import 'package:transparent_image/transparent_image.dart';

class MealsCard extends StatelessWidget {
  const MealsCard({super.key, required this.meal,required this.openMealDeatailsScreen});
  final MealMoudel meal;
  final Function() openMealDeatailsScreen;
  @override
  Widget build(BuildContext context) {
    return InkWell(
    splashColor: Theme.of(context).colorScheme.primary.withValues(alpha: .3),

      borderRadius: BorderRadius.circular(12),
      onTap: openMealDeatailsScreen,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Hero(
              tag: meal.id!,
              child: FadeInImage(
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.image!),
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                height: 100,
                color: Colors.black45,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      meal.meal!,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
                      children: [
                        MealcardContent(
                          iCon: Icons.location_on,
                          title: meal.area!,
                        ),
                        MealcardContent(
                          iCon: Icons.restaurant_menu,
      
                          title: meal.category!,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
