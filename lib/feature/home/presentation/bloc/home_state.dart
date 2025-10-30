import 'package:voicecook/feature/home/data/recipe_model.dart';

abstract class HomeState {}

class InitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<RecipeModel> recipe;
  HomeLoadedState({required this.recipe});
}

class FavoriteLoadedState extends HomeState {
  final List<RecipeModel> recipes;
  FavoriteLoadedState({required this.recipes});
}

class HomeErrorState extends HomeState {
  final String error;
  HomeErrorState({required this.error});
}
