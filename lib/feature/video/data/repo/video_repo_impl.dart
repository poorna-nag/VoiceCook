import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:voicecook/feature/video/data/repo/video_repo.dart';
import 'package:voicecook/feature/video/data/video_model.dart';

class VideoRepoImpl extends VideoRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<List<VideoModel>> getVideo() async {
    // Fetch from both collection names to ensure compatibility with old data
    final snapshotNew = await firestore.collection('videos').get();
    final snapshotOld = await firestore.collection('vedios').get();

    final newVideos = snapshotNew.docs.map((doc) {
      return VideoModel.fromJson(doc.data(), doc.id);
    }).toList();

    final oldVideos = snapshotOld.docs.map((doc) {
      return VideoModel.fromJson(doc.data(), doc.id);
    }).toList();

    return [...newVideos, ...oldVideos];
  }
}
