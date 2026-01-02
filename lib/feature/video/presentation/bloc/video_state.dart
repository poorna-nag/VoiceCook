import 'package:equatable/equatable.dart';
import 'package:voicecook/feature/video/data/video_model.dart';

class VideoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VideoInitialState extends VideoState {}

class LoadingState extends VideoState {}

class VideoLoadedState extends VideoState {
  final List<VideoModel> videos;

  VideoLoadedState({required this.videos});
  @override
  List<Object?> get props => [videos];
}

class VideoErrorState extends VideoState {
  final String error;

  VideoErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}
