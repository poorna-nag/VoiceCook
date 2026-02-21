import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voicecook/core/navigation_service.dart';
import 'package:voicecook/feature/user_profile/data/repo/user_repo_impl.dart';
import 'package:voicecook/feature/user_profile/presentation/bloc/user_event.dart';
import 'package:voicecook/feature/user_profile/presentation/bloc/user_state.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:voicecook/feature/feeding/data/repo/feed_repo_impl.dart';
import 'package:voicecook/feature/home/data/recipe_model.dart';
import 'package:voicecook/feature/video/data/video_model.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ImagePicker picker = ImagePicker();
  final FeedRepoImpl feedRepo = FeedRepoImpl();

  UserBloc() : super(UserInitState()) {
    on<GetUserEvent>(_onGetUserEvent);
    on<UploadPhotoEvent>(_onUploadPhotoEvent);
    on<AddFoodInfoEvent>(_onAddFoodInfoEvent);
    on<UploadProfilePhotoEvent>(_onUploadProfilePhotoEvent);
    on<EditProfileEvent>(_onEditProfileEvent);
  }

  FutureOr<void> _onGetUserEvent(
    GetUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoadingState());
    try {
      final userModel = await UserRepoImpl().getUser();
      final userId = FirebaseAuth.instance.currentUser?.uid;

      List<RecipeModel> recipes = [];
      List<VideoModel> videos = [];

      if (userId != null) {
        recipes = await feedRepo.getUserRecipes(userId);
        videos = await feedRepo.getUserVideos(userId);
      }

      emit(UserLoadedState(user: userModel, recipes: recipes, videos: videos));
    } catch (e) {
      emit(UserErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _onUploadPhotoEvent(
    UploadPhotoEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        emit(UploadImageState(image: File(image.path)));
      }
    } catch (e) {
      emit(UserErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _onAddFoodInfoEvent(
    AddFoodInfoEvent event,
    Emitter<UserState> emit,
  ) {
    NavigationService.pushNamed(routeName: AppRoutes.addInfo);
  }

  FutureOr<void> _onUploadProfilePhotoEvent(
    UploadProfilePhotoEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      final photo = await picker.pickImage(source: ImageSource.gallery);
      if (photo != null) {
        emit(UploadProfilePhotoState(photo: File(photo.path)));
      }
    } catch (_) {}
  }

  FutureOr<void> _onEditProfileEvent(
    EditProfileEvent event,
    Emitter<UserState> emit,
  ) {
    NavigationService.pushNamed(routeName: AppRoutes.editprofile);
  }
}
