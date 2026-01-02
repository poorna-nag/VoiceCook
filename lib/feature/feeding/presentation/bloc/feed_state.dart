import 'package:image_picker/image_picker.dart';
import 'package:voicecook/feature/video/data/video_model.dart';

class FeedState {}

class FeedInitState extends FeedState {}

class FeedLoadingState extends FeedState {}

class FeedVideoState extends FeedState {
  final List<VideoModel> videoModel;

  FeedVideoState({required this.videoModel});
}

class GetMediaState extends FeedState {
  final List<XFile> medias;

  GetMediaState({required this.medias});
}

class FeedErrorState extends FeedState {
  final String error;

  FeedErrorState({required this.error});
}

class FeedSuccessState extends FeedState {
  final String message;

  FeedSuccessState({required this.message});
}
