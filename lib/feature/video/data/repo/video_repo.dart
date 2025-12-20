import 'package:voicecook/feature/video/data/video_model.dart';

abstract class VideoRepo {
  Future<List<VideoModel>> getVideo();
}
