import 'package:image_picker/image_picker.dart';
import 'package:voicecook/feature/home/data/recipe_model.dart';
import 'package:voicecook/feature/video/data/video_model.dart';

class FeedEvent {}

class GetMediaEvent extends FeedEvent {
  final List<ImageSource> source;
  final bool isVideo;

  GetMediaEvent({required this.source, this.isVideo = false});
}

class FeedVideoEvent extends FeedEvent {
  final VideoModel videoModel;
  final List<XFile>? mediaFiles;

  FeedVideoEvent({required this.videoModel, this.mediaFiles});
}

class FeedRecipeEvent extends FeedEvent {
  final RecipeModel recipeModel;
  final List<XFile>? mediaFiles;

  FeedRecipeEvent({required this.recipeModel, this.mediaFiles});
}
