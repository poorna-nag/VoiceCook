import 'dart:io';

import 'package:voicecook/feature/user_profile/data/user_model.dart';

class UserState {}

class UserInitState extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final UserModel user;

  UserLoadedState({required this.user});
}

class UserErrorState extends UserState {
  final String error;

  UserErrorState({required this.error});
}

class UploadImageState extends UserState {
  final File? image;

  UploadImageState({ required this.image});
}
class UploadProfilePhotoState extends UserState{
  final File? photo;

  UploadProfilePhotoState({required this.photo});
}