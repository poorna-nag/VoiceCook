import 'package:voicecook/feature/category/data/category_model.dart';
import 'package:voicecook/feature/home/data/recipe_model.dart';

class CategoryState {}

class CategoryInitState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryLoadedState extends CategoryState {
  final List<CategoryModel> category;

  CategoryLoadedState({required this.category});
}

class CategoryErrorState extends CategoryState {
  final String error;

  CategoryErrorState({required this.error});
}

class GetCategoryRecipeState extends CategoryState {
  final List<RecipeModel> recipe;

  GetCategoryRecipeState({required this.recipe});
}
