import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:voicecook/feature/video/data/repo/video_repo.dart';
import 'package:voicecook/feature/video/data/video_model.dart';

class VideoRepoImpl extends VideoRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<List<VideoModel>> getVideo() async {
    final snapshot = await firestore.collection('videos').get();
    return snapshot.docs.map((doc) {
      return VideoModel.fromJson(doc.data(), doc.id);
    }).toList();
  }
}
