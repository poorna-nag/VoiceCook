import 'package:voicecook/feature/category/data/category_model.dart';

class CategoryEvent {}

class GetCategoryEvent extends CategoryEvent {}

class GetCategoryListEvent extends CategoryEvent {
  final CategoryModel recipe;

  GetCategoryListEvent({required this.recipe});
}
