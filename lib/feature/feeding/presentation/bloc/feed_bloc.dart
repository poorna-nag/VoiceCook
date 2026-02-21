import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voicecook/core/navigation_service.dart';
import 'package:voicecook/feature/feeding/data/repo/feed_repo_impl.dart';
import 'package:voicecook/feature/feeding/presentation/bloc/feed_event.dart';
import 'package:voicecook/feature/feeding/presentation/bloc/feed_state.dart';
import 'package:voicecook/feature/home/data/recipe_model.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final ImagePicker picker = ImagePicker();
  final FeedRepoImpl repo = FeedRepoImpl();

  FeedBloc(super.initialState) {
    on<FeedVideoEvent>(_onFeedVideoEvent);
    on<FeedRecipeEvent>(_onFeedRecipeEvent);
    on<GetMediaEvent>(_onGetMediaEvent);
  }

  FutureOr<void> _onGetMediaEvent(
    GetMediaEvent event,
    Emitter<FeedState> emit,
  ) async {
    try {
      List<XFile> medias = [];

      if (event.isVideo) {
        final video = await picker.pickVideo(source: event.source.first);
        if (video != null) {
          medias = [video];
        }
      } else {
        if (event.source.length == 1 &&
            event.source.first == ImageSource.camera) {
          final image = await picker.pickImage(source: ImageSource.camera);
          if (image != null) {
            medias = [image];
          }
        } else {
          medias = await picker.pickMultipleMedia(imageQuality: 85);
        }
      }

      if (medias.isNotEmpty) {
        emit(GetMediaState(medias: medias));
      }
    } catch (e) {
      emit(FeedErrorState(error: 'Failed to pick media: $e'));
    }
  }

  FutureOr<void> _onFeedVideoEvent(
    FeedVideoEvent event,
    Emitter<FeedState> emit,
  ) async {
    emit(FeedLoadingState());
    try {
      String mediaUrl = '';
      if (event.mediaFiles != null && event.mediaFiles!.isNotEmpty) {
        final file = File(event.mediaFiles!.first.path);
        final fileName =
            'videos/${DateTime.now().millisecondsSinceEpoch}_${event.mediaFiles!.first.name}';
        mediaUrl = await repo.uploadMedia(file, fileName);
      }

      final updatedVideoModel = event.videoModel.copyWith(
        videoUrl: mediaUrl,
        imageUrl: '', // For now
        userId: FirebaseAuth.instance.currentUser?.uid,
      );

      await repo.addVideo(updatedVideoModel);
      emit(FeedSuccessState(message: 'Video added successfully!'));
      NavigationService.pushNamed(routeName: AppRoutes.profile);
    } catch (e) {
      emit(FeedErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _onFeedRecipeEvent(
    FeedRecipeEvent event,
    Emitter<FeedState> emit,
  ) async {
    emit(FeedLoadingState());
    try {
      String imageUrl = '';
      if (event.mediaFiles != null && event.mediaFiles!.isNotEmpty) {
        final file = File(event.mediaFiles!.first.path);
        final fileName =
            'recipes/${DateTime.now().millisecondsSinceEpoch}_${event.mediaFiles!.first.name}';
        imageUrl = await repo.uploadMedia(file, fileName);
      }

      final updatedRecipe = RecipeModel(
        id: '',
        name: event.recipeModel.name,
        categoryId: event.recipeModel.categoryId,
        description: event.recipeModel.description,
        ingredients: event.recipeModel.ingredients,
        steps: event.recipeModel.steps,
        imageUrl: imageUrl,
        time: event.recipeModel.time,
        difficulty: event.recipeModel.difficulty,
        calories: event.recipeModel.calories,
        userId: FirebaseAuth.instance.currentUser?.uid,
      );

      await repo.addRecipe(updatedRecipe);
      emit(FeedSuccessState(message: 'Recipe added successfully!'));
      NavigationService.pushNamed(routeName: AppRoutes.home);
    } catch (e) {
      emit(FeedErrorState(error: e.toString()));
    }
  }
}
