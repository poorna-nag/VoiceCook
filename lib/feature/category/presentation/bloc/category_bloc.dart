import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voicecook/core/navigation_service.dart';
import 'package:voicecook/feature/category/data/repo/category_repo_impl.dart';
import 'package:voicecook/feature/category/presentation/bloc/category_event.dart';
import 'package:voicecook/feature/category/presentation/bloc/category_state.dart';
import 'package:voicecook/feature/home/data/recipe_model.dart';
import 'package:voicecook/feature/home/data/repo/recipe_repo_impl.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitState()) {
    on<GetCategoryEvent>(_onGetCategoryEvent);
    on<GetCategoryListEvent>(_onGetCategoryListEvent);
  }

  FutureOr<void> _onGetCategoryEvent(
    GetCategoryEvent event,
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

  FutureOr<void> _onGetCategoryListEvent(
    GetCategoryListEvent event,
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

    // Navigation happens here, but we stay in CategoryLoadedState so icons don't vanish
    NavigationService.pushNamed(
      routeName: AppRoutes.categoryList,
      arguments: {'recipes': filtered},
    );
  }
}
