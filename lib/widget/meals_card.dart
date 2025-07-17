import 'package:flutter/material.dart';
import 'package:recipe_app/model/meal_moudel.dart';
import 'package:recipe_app/widget/mealcard_content.dart';
import 'package:transparent_image/transparent_image.dart';

class MealsCard extends StatefulWidget {
  const MealsCard({super.key, required this.meal});
  final MealMoudel meal;
  @override
  State<MealsCard> createState() => _MealsCardState();
}

class _MealsCardState extends State<MealsCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          FadeInImage(
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(widget.meal.image!),
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
                    widget.meal.meal!,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
                    children: [
                      MealcardContent(
                        iCon: Icons.location_on,
                        title: widget.meal.area!,
                      ),
                      MealcardContent(
                        iCon: Icons.restaurant_menu,

                        title: widget.meal.category!,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
