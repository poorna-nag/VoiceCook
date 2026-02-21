import 'package:voicecook/feature/home/data/recipe_model.dart';

class HomeEvent {}

class GetRecipeEvent extends HomeEvent {}

class NavToHomeEvent extends HomeEvent {}

class NavToSeeMoreEvent extends HomeEvent {
  final List<RecipeModel> recipes;
  NavToSeeMoreEvent(this.recipes);
}

class NavToDetailEvent extends HomeEvent {
  final RecipeModel recipe;

  NavToDetailEvent({required this.recipe});
}

class SearchRecipeEvent extends HomeEvent {
  final String query;
  SearchRecipeEvent(this.query);
}

class AddToFavoriteEvent extends HomeEvent {
  final RecipeModel recipe;

  AddToFavoriteEvent({required this.recipe});
}

class FetchSavedRecipesEvent extends HomeEvent {}

class NavToFavScreenEvent extends HomeEvent {}

class NavToSearchEvent extends HomeEvent {}

class DeleteFavEvent extends HomeEvent {
  final RecipeModel recipe;
  DeleteFavEvent({required this.recipe});
}

class NavToProfileEvent extends HomeEvent {}
