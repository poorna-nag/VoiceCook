import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voicecook/core/navigation_service.dart';
import 'package:voicecook/feature/home/data/recipe_model.dart';
import 'package:voicecook/feature/home/data/repo/recipe_repo_impl.dart';
import 'package:voicecook/feature/home/presentation/bloc/home_event.dart';
import 'package:voicecook/feature/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final RecipeRepoImpl _repo;
  List<RecipeModel> allRecipes = [];
  static const String _savedKey = 'saved_recipes';

  HomeBloc(this._repo) : super(InitState()) {
    on<NavToHomeEvent>(_onNavToHomeEvent);
    on<GetRecipeEvent>(_onGetRecipeEvent);
    on<NavToSeeMoreEvent>(_onSeeMoreEvent);
    on<NavToDeatilEvent>(_onNavToDeatailEvent);
    on<AddToFavoriteEvent>(_onAddToFavoriteEvent);
    on<NavToFavScreenEvent>(_onNavToFavScreen);
    on<SearchRecipeEvent>(_onSearchRecipeEvent);
    on<FetchSavedRecipesEvent>(_onFetchSavedRecipesEvent);
  }

  Future<void> _onGetRecipeEvent(
    GetRecipeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    try {
      final recipes = await _repo.getRecipe();
      emit(HomeLoadedState(recipe: recipes));
    } catch (e) {
      emit(HomeErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _onNavToHomeEvent(
    NavToHomeEvent event,
    Emitter<HomeState> emit,
  ) {
    Future.delayed(Duration(seconds: 2));
    NavigationService.pushNamed(routeName: AppRoutes.home);
  }

  FutureOr<void> _onSeeMoreEvent(
    NavToSeeMoreEvent event,
    Emitter<HomeState> emit,
  ) {
    NavigationService.pushNamed(
      routeName: AppRoutes.doc,
      arguments: {'recipes': event.recipes},
    );
  }

  FutureOr<void> _onNavToDeatailEvent(
    NavToDeatilEvent event,
    Emitter<HomeState> emit,
  ) {
    NavigationService.pushNamed(
      routeName: AppRoutes.details,
      arguments: {'recipes': event.recipe},
    );
  }

  Future<void> _onAddToFavoriteEvent(
    AddToFavoriteEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedList = prefs.getStringList(_savedKey) ?? [];

      // convert recipe to json
      final recipeJson = jsonEncode(event.recipe.toJson());

      // toggle save/remove
      if (savedList.any((r) => jsonDecode(r)['id'] == event.recipe.id)) {
        savedList.removeWhere((r) => jsonDecode(r)['id'] == event.recipe.id);
      } else {
        savedList.add(recipeJson);
      }

      await prefs.setStringList(_savedKey, savedList);

      // Optionally, emit updated list of saved recipes
      final savedRecipes = savedList
          .map((e) => RecipeModel.fromJson(jsonDecode(e)))
          .toList();
      emit(HomeLoadedState(recipe: savedRecipes));
    } catch (e) {
      emit(HomeErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _onNavToFavScreen(
    NavToFavScreenEvent event,
    Emitter<HomeState> emit,
  ) {
    NavigationService.pushNamed(
      routeName: AppRoutes.fav,
      arguments: {'recipes': _repo},
    );
  }

  // FutureOr<void> _onNavToSearchEvent(
  //   NavToSearchEvent event,
  //   Emitter<HomeState> emit,
  // ) {
  //   NavigationService.pushNamed(routeName: AppRoutes.search);
  // }

  FutureOr<void> _onSearchRecipeEvent(
    SearchRecipeEvent event,
    Emitter<HomeState> emit,
  ) {
    final filtered = allRecipes
        .where(
          (r) => r.name
              .toLowerCase()
              .split('')
              .contains(event.query.toLowerCase()),
        )
        .toList();

    if (filtered.isEmpty) {
      emit(HomeLoadedState(recipe: filtered));
    } else {
      emit(HomeErrorState(error: "No item found"));
    }
  }

  FutureOr<void> _onFetchSavedRecipesEvent(FetchSavedRecipesEvent event, Emitter<HomeState> emit)  async{
    try {
        final prefs = await SharedPreferences.getInstance();
        final savedList = prefs.getStringList(_savedKey) ?? [];
        final savedRecipes = savedList
            .map((e) => RecipeModel.fromJson(jsonDecode(e)))
            .toList();
        emit(HomeLoadedState(recipe: savedRecipes));
      } catch (e) {
        emit(HomeErrorState(error: e.toString()));
      }
  }
}
