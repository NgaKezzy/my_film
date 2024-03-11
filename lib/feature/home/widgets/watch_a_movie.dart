import 'package:app/component/loading_widget.dart';
import 'package:app/feature/home/widgets/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:video_player/video_player.dart';

class WatchAMovie extends StatefulWidget {
  const WatchAMovie({super.key});

  @override
  State<WatchAMovie> createState() => _WatchAMovieState();
}

class _WatchAMovieState extends State<WatchAMovie> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: VideoPlayerWidget(
      url:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    ));
  }
}
