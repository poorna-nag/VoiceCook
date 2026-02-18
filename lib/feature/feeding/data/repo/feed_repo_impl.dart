import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:voicecook/feature/feeding/data/repo/feed_repo.dart';
import 'package:voicecook/feature/home/data/recipe_model.dart';
import 'package:voicecook/feature/video/data/video_model.dart';

class FeedRepoImpl extends FeedRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Future<void> addVideo(VideoModel video) async {
    await firestore.collection('videos').add(video.toFirestore());
  }

  @override
  Future<void> addRecipe(RecipeModel recipe) async {
    await firestore.collection('recipes').add(recipe.toJson());
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
