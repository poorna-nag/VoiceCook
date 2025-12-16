import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voicecook/core/navigation_service.dart';
import 'package:voicecook/feature/user_profile/data/repo/user_repo_impl.dart';
import 'package:voicecook/feature/user_profile/presentation/bloc/user_event.dart';
import 'package:voicecook/feature/user_profile/presentation/bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ImagePicker picker = ImagePicker();
  UserBloc() : super(UserInitState()) {
    on<GetUserEvent>(_onGetUserEvent);
    on<UploadPhotoEvent>(_onUploadPhotoEvent);
    on<AddFoodInfoEvent>(_onAddFoodInfoEvent);
    on<UploadProfilePhotoEvent>(_onUploadProfilePhotoEvent);
    // on<EditProfileEvent>(_onEditProfileEvent);
  }

  FutureOr<void> _onGetUserEvent(
    GetUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoadingState());
    try {
      final repo = await UserRepoImpl().getUser();
      emit(UserLoadedState(user: repo));
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
      NavigationService.pushNamed(routeName: AppRoutes.editprofile);
      if (image != null) {
        emit(UploadImageState(image: File(image.path)));
      }
    } catch (e) {
      emit(UserErrorState(error: state.toString()));
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

  // FutureOr<void> _onEditProfileEvent(
  //   EditProfileEvent event,
  //   Emitter<UserState> emit,
  // ) {
  //   NavigationService.pushNamed(routeName: AppRoutes.editprofile);
  // }
}
