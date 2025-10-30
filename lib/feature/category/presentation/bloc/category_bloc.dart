import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voicecook/core/navigation_service.dart';
import 'package:voicecook/feature/category/data/repo/category_repo_impl.dart';
import 'package:voicecook/feature/category/presentation/bloc/categoty_event.dart';
import 'package:voicecook/feature/category/presentation/bloc/categoty_state.dart';
import 'package:voicecook/feature/home/data/recipe_model.dart';
import 'package:voicecook/feature/home/data/repo/recipe_repo_impl.dart';

class CategoryBloc extends Bloc<CategotyEvent, CategoryState> {
  CategoryBloc() : super(CategotyInitState()) {
    on<GetCategotyEvent>(_onGetCategotyEvent);
    on<GetCategotyListEvent>(_onGetCategotyListEvent);
  }

  FutureOr<void> _onGetCategotyEvent(
    GetCategotyEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoadingState());
    try {
      final category = await CategoryRepoImpl().getCategory();
      emit(CategoryLoadedState(category: category));
    } catch (e) {
      emit(CategoryErrorState(error: " ${e.toString()}"));
    }
  }

  FutureOr<void> _onGetCategotyListEvent(
    GetCategotyListEvent event,
    Emitter<CategoryState> emit,
  ) async {
    List<RecipeModel> allRecipes = await RecipeRepoImpl().getRecipe();

    final filtered = allRecipes
        .where(
          (r) =>
              r.categoryId.toLowerCase() ==
              event.recipe.categoryName.toLowerCase(),
        )
        .toList();

    emit(GetCategoryRecipeState(recipe: filtered));

    NavigationService.pushNamed(
      routeName: AppRoutes.categoryList,
      arguments: {'recipes': filtered},
    );
  }
}
