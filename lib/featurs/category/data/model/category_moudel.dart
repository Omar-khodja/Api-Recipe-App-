import 'package:recipe_app/featurs/category/domain/entities/category.dart';

class CategoryMoudel extends Categoryentities {
  CategoryMoudel({
    required super.id,
    required super.title,
    required super.imageUrl,
  });

  factory CategoryMoudel.fromJson(Map<String, dynamic> json) {
    return CategoryMoudel(
      id: json['idCategory'] as String,
      title: json['strCategory'] as String,
      imageUrl: json['strCategoryThumb'] as String,
    );
  }
}
