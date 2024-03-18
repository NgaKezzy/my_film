import 'package:app/component/loading_widget.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    super.key,
    required this.url,
  });
  final String url;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      autoPlay: true,
      autoInitialize: true,
      videoPlayerController: VideoPlayerController.networkUrl(
        Uri.parse(widget.url),
      ),
    );
    // flickManager.flickVideoManager?.addListener(() {
    //   if (flickManager.flickVideoManager!.isVideoEnded) {
    //     // Khi video hiện tại kết thúc, chuyển sang video tiếp theo
    //     setState(() {});
    //   }
    // });
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: FlickVideoPlayer(
        flickManager: flickManager,
        flickVideoWithControls: FlickVideoWithControls(
          videoFit: BoxFit.cover,
          controls: FlickPortraitControls(
            progressBarSettings: FlickProgressBarSettings(
              playedColor: Colors.blue,
            ),
          ),
          playerLoadingFallback: const LoadingWidget(),
        ),
      ),
    );
  }
}
