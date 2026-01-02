import 'package:voicecook/feature/video/data/video_model.dart';

abstract class FeedRepo {
  Future<List<VideoModel>> addVideo(VideoModel videos);
}
