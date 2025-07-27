import 'package:flutter/material.dart';
import 'package:recipe_app/model/category_moudel.dart';
import 'package:transparent_image/transparent_image.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({
    super.key,
    required this.category,
    required this.onCategorySelected,
  });
  final Function() onCategorySelected;
  final CategoryMoudel category;

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      splashColor: Colors.green.withValues(alpha: .3),
      highlightColor: Colors.green.withValues(alpha: .3),
      
      onTap: () {
        widget.onCategorySelected();
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(widget.category.imageUrl),
              fit: BoxFit.fitWidth,
              height: 150,
              width: double.infinity,
            ),

            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  widget.category.title,
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
