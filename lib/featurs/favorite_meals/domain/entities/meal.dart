class Meal {
  Meal({
    required this.id,
    required this.meal,
    required this.area,
    required this.category,
    required this.image,
    required this.instructions,
    required this.youtube,
    bool? isFavorite,
  }) : isFavorite = isFavorite ?? false;
  final String? id;
  final String? meal;
  final String? category;
  final String? area;
  final String? instructions;
  final String? image;
  final String? youtube;
  bool isFavorite;
}
