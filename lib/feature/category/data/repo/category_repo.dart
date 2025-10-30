import 'package:voicecook/feature/category/data/category_model.dart';

abstract class CategoryRepo {
  Future<List<CategoryModel>> getCategory();
}
