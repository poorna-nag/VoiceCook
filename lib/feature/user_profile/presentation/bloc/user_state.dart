import 'dart:io';

import 'package:voicecook/feature/home/data/recipe_model.dart';
import 'package:voicecook/feature/video/data/video_model.dart';
import 'package:voicecook/feature/user_profile/data/user_model.dart';

class UserState {}

class UserInitState extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final UserModel user;
  final List<RecipeModel> recipes;
  final List<VideoModel> videos;

  UserLoadedState({
    required this.user,
    required this.recipes,
    required this.videos,
  });
}

class UserErrorState extends UserState {
  final String error;

  UserErrorState({required this.error});
}

class UploadImageState extends UserState {
  final File? image;

  UploadImageState({required this.image});
}

class UploadProfilePhotoState extends UserState {
  final File? photo;

  UploadProfilePhotoState({required this.photo});
}
