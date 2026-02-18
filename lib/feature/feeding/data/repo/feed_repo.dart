import 'package:voicecook/feature/home/data/recipe_model.dart';
import 'package:voicecook/feature/video/data/video_model.dart';

abstract class FeedRepo {
  Future<void> addVideo(VideoModel video);
  Future<void> addRecipe(RecipeModel recipe);
}
