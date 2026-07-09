import 'package:recipe_app/featurs/favorite_meals/domain/entities/meal.dart';

class MealMoudel extends Meal {


   MealMoudel({
    required super.id,
    required super.meal,
    required super.area,
    required super.category,
    required super.image,
    required super.instructions,
    required super.youtube,
    bool? isFavorite ,
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

  Map<String, dynamic> toDatabase(MealMoudel meal) {
    return {
      'id': meal.id,
      'meal': meal.meal,
      'area': meal.area,
      'category': meal.category,
      'image': meal.image,
      'instructions': meal.instructions,
      'youtube': meal.youtube,
      'isFavorite': meal.isFavorite ? 1 : 0,
    };
  }
  factory MealMoudel.fromEntity(Meal meal) {
    return MealMoudel(
      id: meal.id,
      meal: meal.meal,
      area: meal.area,
      category: meal.category,
      image: meal.image,
      instructions: meal.instructions,
      youtube: meal.youtube,
    );
  }
}
