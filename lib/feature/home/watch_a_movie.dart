import 'package:app/component/loading_widget.dart';
import 'package:app/config/print_color.dart';
import 'package:app/feature/home/cubit/movie_cubit.dart';
import 'package:app/feature/home/models/movie_details.dart';
import 'package:app/feature/home/models/movie_information.dart';
import 'package:app/feature/home/widgets/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchAMovie extends StatefulWidget {
  const WatchAMovie({super.key, required this.movieInformation});
  final MovieInformation movieInformation;

  @override
  State<WatchAMovie> createState() => _WatchAMovieState();
}

class _WatchAMovieState extends State<WatchAMovie> {
  MovieDetails? movieDetails;
  late MovieCubit movieCubit;

  @override
  void initState() {
    super.initState();
    printYellow(widget.movieInformation.slug);
    movieCubit = context.read<MovieCubit>();

    movieCubit.getMovieDetails(widget.movieInformation.slug);
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayerWidget(
        url: "https://s2.phim1280.tv/20240313/P2ZCmeLi/index.m3u8");
  }
}
