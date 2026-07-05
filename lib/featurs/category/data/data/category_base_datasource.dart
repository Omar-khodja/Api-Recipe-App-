import 'package:recipe_app/featurs/category/data/model/category_moudel.dart';

abstract class CategoryBaseDataSource  {
  Future<List<CategoryMoudel>> featchCategory();
}