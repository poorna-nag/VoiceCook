import 'package:voicecook/feature/home/data/recipe_model.dart';

class HomeEvent {}

class GetRecipeEvent extends HomeEvent {}

class ToggleFavoriteEvent extends HomeEvent {
  final RecipeModel recipe;
  ToggleFavoriteEvent({required this.recipe});
}

class NavToHomeEvent extends HomeEvent {}

class NavToSeeMoreEvent extends HomeEvent {
  final List<RecipeModel> recipes;
  NavToSeeMoreEvent(this.recipes);
}

class NavToDeatilEvent extends HomeEvent {
  final RecipeModel recipe;

  NavToDeatilEvent({required this.recipe});
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

class DeleteFavEvent extends HomeEvent {}

class NavToProfileEvent extends HomeEvent {}

class DeleteFavItemEvent extends HomeEvent {}
