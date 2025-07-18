import 'package:flutter/material.dart';
import 'package:recipe_app/model/meal_moudel.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class MealDeatails extends StatelessWidget {
  const MealDeatails({super.key, required this.meal});
  final MealMoudel meal;
  void youtubevideo() async {
    if (meal.youtube == null) {
      return;
    }
    final Uri? url = Uri.tryParse(meal.youtube!);
    if (!await launchUrl(url!, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          meal.meal!,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
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
                right: 10,
                bottom: 10,
                child: meal.youtube != null
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

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 50),
                child: Column(
                  children: [
                     Text(
                      textAlign: TextAlign.center,
                      meal.meal!,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                     ),
                     const SizedBox(height: 10,),
                    Text(
                      "Instructions",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      textAlign: TextAlign.start,
                      meal.instructions!,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
