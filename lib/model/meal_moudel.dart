class MealMoudel {
  final String? id;
  final String? meal;
  final String? category;
  final String? area;
  final String? instructions;
  final String? image;
  final String? youtube;

  const MealMoudel({
    required this.id,
    required this.meal,
    required this.area,
    required this.category,
    required this.image,
    required this.instructions,
    required this.youtube,
  });
  factory MealMoudel.fromJson(Map<String, dynamic> json) {
    return MealMoudel(
      id: json["idMeal"],
      meal: json["strMeal"],
      area: json["strArea"],
      category: json["strCategory"],
      image: json["strMealThumb"],
      instructions: json["strInstructions"],
      youtube: json["strYoutube"],
    );
  }
}
