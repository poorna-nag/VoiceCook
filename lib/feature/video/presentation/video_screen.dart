import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voicecook/feature/video/data/video_model.dart';
import 'package:voicecook/feature/video/presentation/bloc/video_bloc.dart';
import 'package:voicecook/feature/video/presentation/bloc/video_event.dart';
import 'package:voicecook/feature/video/presentation/bloc/video_state.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VideoBloc()..add(FetchVideoEvent()),
      child: Scaffold(
        body: BlocBuilder<VideoBloc, VideoState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is VideoLoadedState) {
              return _VideoViewState(videoModel: state.videos);
            } else if (state is VideoErrorState) {
              return Text(state.error);
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _VideoViewState extends StatefulWidget {
  final List<VideoModel> videoModel;
  const _VideoViewState({required this.videoModel});

  @override
  State<_VideoViewState> createState() => __VideoViewStateState();
}

class __VideoViewStateState extends State<_VideoViewState> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.videoModel.length,
      itemBuilder: (context, index) {
        final video = widget.videoModel[index];
        return Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              height: 220,
              width: double.infinity,
              child: Image.network(video.imageUrl, fit: BoxFit.cover),
            ),
          ],
        );
      },
    );
  }
}
