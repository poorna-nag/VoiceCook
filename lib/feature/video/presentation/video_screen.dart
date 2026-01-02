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
  void initState() {
    super.initState();
    context.read<VideoBloc>().add(FetchVideoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<VideoBloc, VideoState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is VideoLoadedState) {
            if (state.videos.isEmpty) {
              return Center(child: Text('No videos available'));
            }
            return _VideoViewState(videoModel: state.videos);
          } else if (state is VideoErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.error}'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<VideoBloc>().add(FetchVideoEvent());
                    },
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
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
        return Card(
          margin: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (video.imageUrl.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                  child: Image.network(
                    video.imageUrl,
                    fit: BoxFit.cover,
                    height: 220,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 220,
                        color: Colors.grey[300],
                        child: Icon(Icons.broken_image),
                      );
                    },
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      video.description,
                      style: TextStyle(fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 16),
                        SizedBox(width: 4),
                        Text('${video.cookTime}'),
                        SizedBox(width: 16),
                        Icon(Icons.local_fire_department, size: 16),
                        SizedBox(width: 4),
                        Text('${video.calories} cal'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
