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

  Future<List<VideoModel>> getUserVideos(String userId) async {
    final snapshot = await firestore
        .collection('videos')
        .where('userId', isEqualTo: userId)
        .get();
    return snapshot.docs
        .map((doc) => VideoModel.fromJson(doc.data(), doc.id))
        .toList();
  }

  Future<List<RecipeModel>> getUserRecipes(String userId) async {
    final snapshot = await firestore
        .collection('recipes')
        .where('userId', isEqualTo: userId)
        .get();
    return snapshot.docs
        .map((doc) => RecipeModel.fromJson(doc.data(), doc.id))
        .toList();
  }

  Future<String> uploadMedia(File file, String fileName) async {
    try {
      final ref = storage.ref().child(fileName);
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload media: $e');
    }
  }
}
