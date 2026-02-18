import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
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
    return BlocBuilder<VideoBloc, VideoState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is VideoLoadedState) {
          if (state.videos.isEmpty) {
            return const Center(child: Text('No videos available'));
          }
          return _VideoViewState(videoModel: state.videos);
        } else if (state is VideoErrorState) {
          return Center(child: Text('Error: ${state.error}'));
        }
        return const Center(child: CircularProgressIndicator());
      },
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
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: widget.videoModel.length,
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      itemBuilder: (context, index) {
        final video = widget.videoModel[index];
        return VideoPlayerItem(video: video, isActive: _currentIndex == index);
      },
    );
  }
}

class VideoPlayerItem extends StatefulWidget {
  final VideoModel video;
  final bool isActive;

  const VideoPlayerItem({
    super.key,
    required this.video,
    required this.isActive,
  });

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() {
    if (widget.video.videoUrl.isNotEmpty) {
      _controller =
          VideoPlayerController.networkUrl(Uri.parse(widget.video.videoUrl))
            ..initialize().then((_) {
              setState(() {
                _isInitialized = true;
              });
              if (widget.isActive) {
                _controller.play();
                _controller.setLooping(true);
              }
            });
    }
  }

  @override
  void didUpdateWidget(VideoPlayerItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isInitialized) {
      if (widget.isActive) {
        _controller.play();
      } else {
        _controller.pause();
      }
    }
  }

  @override
  void dispose() {
    if (widget.video.videoUrl.isNotEmpty) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Video Player or Thumbnail
        if (widget.video.videoUrl.isNotEmpty)
          _isInitialized
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    });
                  },
                  child: VideoPlayer(_controller),
                )
              : const Center(child: CircularProgressIndicator())
        else if (widget.video.imageUrl.isNotEmpty)
          Image.network(
            widget.video.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Container(color: Colors.black),
          )
        else
          Container(color: Colors.black),

        // Gradient Overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.transparent,
                Colors.transparent,
                Colors.black.withOpacity(0.8),
              ],
              stops: const [0.0, 0.2, 0.7, 1.0],
            ),
          ),
        ),

        // Content details
        Positioned(
          left: 16,
          bottom: 40,
          right: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.video.name,
                style: GoogleFonts.playfairDisplay(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.video.description,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildReelChip(Icons.timer_outlined, widget.video.cookTime),
                  const SizedBox(width: 12),
                  _buildReelChip(
                    Icons.local_fire_department_rounded,
                    '${widget.video.calories} kcal',
                  ),
                ],
              ),
            ],
          ),
        ),

        // Side Actions
        Positioned(
          right: 16,
          bottom: 40,
          child: Column(
            children: [
              _buildReelAction(Icons.favorite_border, "Like"),
              const SizedBox(height: 20),
              _buildReelAction(Icons.comment_outlined, "Comment"),
              const SizedBox(height: 20),
              _buildReelAction(Icons.share_outlined, "Share"),
              const SizedBox(height: 20),
              if (_isInitialized && !_controller.value.isPlaying)
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.play_arrow_rounded, color: Colors.white),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReelChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReelAction(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 32),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}
