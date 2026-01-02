import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:voicecook/feature/feeding/data/repo/feed_repo.dart';
import 'package:voicecook/feature/video/data/video_model.dart';

class FeedRepoImpl extends FeedRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Future<List<VideoModel>> addVideo(VideoModel video) async {
    await firestore.collection('videos').add(video.toFirestore());

    final querySnapshot = await firestore.collection('videos').get();
    final videos = querySnapshot.docs
        .map((doc) => VideoModel.fromJson(doc.data(), doc.id))
        .toList();

    return videos;
  }

  Future<String> uploadMedia(File file, String fileName) async {
    try {
      final ref = storage.ref().child('videos/$fileName');
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload media: $e');
    }
  }
}
