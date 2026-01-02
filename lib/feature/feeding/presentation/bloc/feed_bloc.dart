import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voicecook/feature/feeding/data/repo/feed_repo_impl.dart';
import 'package:voicecook/feature/feeding/presentation/bloc/feed_event.dart';
import 'package:voicecook/feature/feeding/presentation/bloc/feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final ImagePicker picker = ImagePicker();
  final FeedRepoImpl repo = FeedRepoImpl();

  FeedBloc(super.initialState) {
    on<FeedVideoEvent>(_onFeedVideoEvent);
    on<GetMediaEvent>(_onGetMediaEvent);
  }

  FutureOr<void> _onFeedVideoEvent(
    FeedVideoEvent event,
    Emitter<FeedState> emit,
  ) async {
    emit(FeedLoadingState());
    try {
      String imageUrl = event.videoModel.imageUrl;

      if (event.mediaFiles != null && event.mediaFiles!.isNotEmpty) {
        final file = File(event.mediaFiles!.first.path);
        final fileName =
            '${DateTime.now().millisecondsSinceEpoch}_${event.mediaFiles!.first.name}';
        imageUrl = await repo.uploadMedia(file, fileName);
      }

      final videoModel = event.videoModel.copyWith(imageUrl: imageUrl);

      await repo.addVideo(videoModel);
      emit(FeedSuccessState(message: 'Video added successfully!'));
    } catch (e) {
      emit(FeedErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _onGetMediaEvent(
    GetMediaEvent event,
    Emitter<FeedState> emit,
  ) async {
    try {
      List<XFile> medias = [];

      if (event.isVideo) {
        final video = await picker.pickVideo(source: event.source.first);
        if (video != null) {
          medias = [video];
        }
      } else {
        medias = await picker.pickMultipleMedia(imageQuality: 85);
      }

      if (medias.isNotEmpty) {
        emit(GetMediaState(medias: medias));
      }
    } catch (e) {
      emit(FeedErrorState(error: 'Failed to pick media: $e'));
    }
  }
}
