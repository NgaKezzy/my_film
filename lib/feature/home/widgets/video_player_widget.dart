import 'package:app/component/loading_widget.dart';
import 'package:app/config/app_size.dart';
import 'package:app/config/print_color.dart';
import 'package:app/feature/home/models/data_film.dart';
import 'package:app/feature/home/models/movie_category.dart';
import 'package:app/feature/home/models/movie_episodes.dart';
import 'package:app/l10n/cubit/locale_cubit.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget(
      {super.key, required this.url, required this.dataFilm});
  final String url;
  final DataFilm? dataFilm;

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
  }

  void playNewVideo() {
    setState(() {
      flickManager.handleChangeVideo(VideoPlayerController.networkUrl(
          Uri.parse("https://s2.phim1280.tv/20240302/ehRMDzoh/index.m3u8")));
    });
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LocaleCubit localeCubit = context.watch<LocaleCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
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
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height - 266,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 20,
                    child: Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.film,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: AppSize.size16),
                        ),
                        Text(
                          localeCubit.state.languageCode == 'vi'
                              ? widget.dataFilm!.movie.name
                              : widget.dataFilm!.movie.origin_name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  widget.dataFilm!.episodes[0].server_data.length == 1
                      ? const SizedBox()
                      : EpisodeNumberOfTheMovie(
                          items: widget.dataFilm!.episodes,
                          onTap: () {
                            playNewVideo();
                          },
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  titleAndContent(
                      title: AppLocalizations.of(context)!.content,
                      content: widget.dataFilm!.movie.content),
                  const SizedBox(
                    height: 10,
                  ),
                  contentActor(items: widget.dataFilm?.movie.actor ?? []),
                  const SizedBox(
                    height: 10,
                  ),
                  contentCategory(items: widget.dataFilm!.movie.category),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class EpisodeNumberOfTheMovie extends StatelessWidget {
  const EpisodeNumberOfTheMovie(
      {super.key, required this.items, required this.onTap});

  final List<MovieEpisodes> items;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.episode,
          style: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: AppSize.size16),
        ),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          spacing: 8.0, // Khoảng cách giữa các widget con
          runSpacing: 8.0, // Khoảng cách giữa các dòng
          alignment: WrapAlignment.center, // Căn giữa theo chiều ngang
          children: List.generate(
            items[0].server_data.length,
            (index) => InkWell(
              onTap: () {
                onTap.call();
              },
              child: Container(
                alignment: Alignment.center,
                width: 35,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.blue,
                ),
                child: Text('${index + 1}'),
              ),
            ),
          ),
        )
      ],
    );
  }
}

// ignore: camel_case_types
class contentActor extends StatelessWidget {
  const contentActor({super.key, required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.actor,
          style: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: AppSize.size16),
        ),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          spacing: 8.0, // Khoảng cách giữa các widget con
          runSpacing: 8.0, // Khoảng cách giữa các dòng
          alignment: WrapAlignment.center, // Căn giữa theo chiều ngang
          children: List.generate(
              items.length,
              (index) => Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(items[index]))),
        )
      ],
    );
  }
}

// ignore: camel_case_types
class contentCategory extends StatelessWidget {
  const contentCategory({super.key, required this.items});

  final List<MovieCategory> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.category,
          style: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: AppSize.size16),
        ),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          spacing: 8.0, // Khoảng cách giữa các widget con
          runSpacing: 8.0, // Khoảng cách giữa các dòng
          alignment: WrapAlignment.center, // Căn giữa theo chiều ngang
          children: List.generate(
              items.length,
              (index) => Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Text(items[index].name))),
        )
      ],
    );
  }
}

// ignore: camel_case_types
class titleAndContent extends StatelessWidget {
  const titleAndContent({super.key, this.title = '', this.content = ''});
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: AppSize.size16),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            textAlign: TextAlign.justify,
            content,
          ),
        ],
      ),
    );
  }
}
