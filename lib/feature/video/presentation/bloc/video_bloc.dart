import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voicecook/feature/video/data/repo/video_repo_impl.dart';
import 'package:voicecook/feature/video/presentation/bloc/video_event.dart';
import 'package:voicecook/feature/video/presentation/bloc/video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoBloc() : super(VideoInitialState()) {
    on<FetchVideoEvent>(_onFeatchVideoEvent);
  }

  FutureOr<void> _onFeatchVideoEvent(
    FetchVideoEvent event,
    Emitter<VideoState> emit,
  ) async {
    try {
      final repo = await VideoRepoImpl().getVideo();
      emit(VideoLoadedState(videos: repo));
    } catch (e) {
      throw Exception(e);
    }
  }
}
