class CategoryMoudel {
  final String id;
  final String title;
  final String imageUrl;

  CategoryMoudel({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  factory CategoryMoudel.fromJson(Map<String, dynamic> json) {
    return CategoryMoudel(
      id: json['idCategory'] as String,
      title: json['strCategory'] as String,
      imageUrl: json['strCategoryThumb'] as String,
    );
  }
}