import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/model/category_moudel.dart';
import 'package:transparent_image/transparent_image.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});
  final CategoryMoudel category;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      splashColor: Colors.green.withValues(alpha: .3),
      highlightColor: Colors.green.withValues(alpha: .3),
      onTap: () {},
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(category.imageUrl),
              fit: BoxFit.fill,
              height: 100,
              width: double.infinity,
            ),
            Positioned(
              bottom: 5,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  category.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
