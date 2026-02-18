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
    on<NavToDetailEvent>(_onNavToDetailEvent);
    on<AddToFavoriteEvent>(_onAddToFavoriteEvent);
    on<NavToFavScreenEvent>(_onNavToFavScreen);
    on<SearchRecipeEvent>(_onSearchRecipeEvent);
    on<FetchSavedRecipesEvent>(_onFetchSavedRecipesEvent);
    on<NavToProfileEvent>(_onNavToProfileEvent);
    on<DeleteFavEvent>(_onDeleteFavEvent);
  }

  Future<void> _onGetRecipeEvent(
    GetRecipeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    try {
      final recipes = await _repo.getRecipe();

      allRecipes = recipes;
      emit(HomeLoadedState(recipe: recipes));
    } catch (e) {
      emit(HomeErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _onNavToHomeEvent(
    NavToHomeEvent event,
    Emitter<HomeState> emit,
  ) {
    NavigationService.pushReplacementNamed(routeName: AppRoutes.home);
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

  FutureOr<void> _onNavToDetailEvent(
    NavToDetailEvent event,
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

      final recipeJson = jsonEncode(event.recipe.toJson());

      if (savedList.any((r) => jsonDecode(r)['id'] == event.recipe.id)) {
        savedList.removeWhere((r) => jsonDecode(r)['id'] == event.recipe.id);
      } else {
        savedList.add(recipeJson);
      }

      await prefs.setStringList(_savedKey, savedList);
    } catch (e) {
      emit(HomeErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _onNavToFavScreen(
    NavToFavScreenEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedList = prefs.getStringList(_savedKey) ?? [];
      final savedRecipes = savedList
          .map((e) => RecipeModel.fromJson(jsonDecode(e)))
          .toList();
      NavigationService.pushNamed(
        routeName: AppRoutes.fav,
        arguments: {'favItems': savedRecipes},
      );
    } catch (e) {
      emit(HomeErrorState(error: e.toString()));
    }
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
    final q = event.query.trim().toLowerCase();
    final filtered = allRecipes.where((r) {
      final inName = r.name.toLowerCase().contains(q);
      final inDesc = r.description.toLowerCase().contains(q);
      return inName || inDesc;
    }).toList();

    if (filtered.isEmpty) {
      emit(HomeErrorState(error: "No item found"));
    } else {
      emit(HomeLoadedState(recipe: filtered));
    }
  }

  FutureOr<void> _onFetchSavedRecipesEvent(
    FetchSavedRecipesEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedList = prefs.getStringList(_savedKey) ?? [];
      final savedRecipes = savedList
          .map((e) => RecipeModel.fromJson(jsonDecode(e)))
          .toList();
      emit(FavoriteLoadedState(recipes: savedRecipes));
    } catch (e) {
      emit(HomeErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _onNavToProfileEvent(
    NavToProfileEvent event,
    Emitter<HomeState> emit,
  ) {
    NavigationService.pushNamed(routeName: AppRoutes.profile);
  }

  FutureOr<void> _onDeleteFavEvent(
    DeleteFavEvent event,
    Emitter<HomeState> emit,
  ) {}
}
