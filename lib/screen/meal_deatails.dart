import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/model/meal_moudel.dart';
import 'package:recipe_app/provider/favoriteMealProvider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class MealDeatails extends ConsumerStatefulWidget {
  const MealDeatails({super.key, required this.meal});
  final MealMoudel meal;

  @override
  ConsumerState<MealDeatails> createState() => _MealDeatailsState();
}

class _MealDeatailsState extends ConsumerState<MealDeatails> {

  void youtubevideo() async {
    if (widget.meal.youtube == null) {
      return;
    }
    final Uri? url = Uri.tryParse(widget.meal.youtube!);
    if (!await launchUrl(url!, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
  void saveToFavorite(bool isFavorite)  {
    setState(() {
      widget.meal.isFavorite = !isFavorite;
    });
     ref.read(favoriteMealProvider.notifier).insertData(widget.meal);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text(
          !isFavorite ? 'Added to Favorites' : 'Removed from Favorites',style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    final favoritemeal = ref.watch(favoriteMealProvider);
    final isFavorite = favoritemeal.value?.any((meal) => meal.id == widget.meal.id) ?? false;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 350,
            elevation: 0,
            centerTitle: false,
            title: Text(
              widget.meal.meal!,
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(color: Colors.white),
            ),
            actions: [
              IconButton(
                onPressed: () {
                 saveToFavorite(isFavorite);
                },
                icon: isFavorite
                    ? const Icon(Icons.favorite_outlined, size: 24,color: Colors.red,)
                    : const Icon(Icons.favorite_border, size: 24,color: Colors.red),
              ),
            ],

            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Hero(
                    tag: widget.meal.id!,
                    child: FadeInImage(
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: MemoryImage(kTransparentImage),
                      image: NetworkImage(widget.meal.image!),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: widget.meal.youtube != null
                        ? Container(
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black87,
                            ),
                            child: IconButton(
                              onPressed: youtubevideo,
                              icon: const Icon(Icons.play_arrow),
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
          ),
          
          SliverList(
            delegate: SliverChildBuilderDelegate(childCount: 1, (
              context,
              index,
            ) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Instructions",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.5),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        textAlign: TextAlign.justify,
                        widget.meal.instructions!,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
