class MealMoudel {
  final String? id;
  final String? meal;
  final String? category;
  final String? area;
  final String? instructions;
  final String? image;
  final String? youtube;
   bool isFavorite;

   MealMoudel({
    required this.id,
    required this.meal,
    required this.area,
    required this.category,
    required this.image,
    required this.instructions,
    required this.youtube,
    bool? isFavorite ,
  }):isFavorite = isFavorite ?? false;
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
  factory MealMoudel.fromDatabase(Map<String, dynamic> json) {
    return MealMoudel(
      id: json["id"],
      meal: json["meal"],
      area: json["area"],
      category: json["category"],
      image: json["image"],
      instructions: json["instructions"],
      youtube: json["youtube"],
      isFavorite: json["isFavorite"] == 1 ? true : false,
    );
  }
}
