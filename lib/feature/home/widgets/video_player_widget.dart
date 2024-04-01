import 'package:app/component/loading_widget.dart';
import 'package:app/config/app_size.dart';
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

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LocaleCubit localeCubit = context.watch<LocaleCubit>();
    final double height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height * 0.3,
          child: FlickVideoPlayer(
            wakelockEnabled: true,
            flickManager: flickManager,
            flickVideoWithControls: FlickVideoWithControls(
              aspectRatioWhenLoading: 16 / 9,
              videoFit: BoxFit.fill,
              controls: FlickPortraitControls(
                progressBarSettings: FlickProgressBarSettings(
                  playedColor: Colors.blue,
                ),
              ),
              playerLoadingFallback: const LoadingWidget(),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
          height: height - (height * 0.3 + 32),
          child: SingleChildScrollView(
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
                        flickManager: flickManager,
                        items: widget.dataFilm!.episodes,
                      ),
                const SizedBox(
                  height: 10,
                ),
                TitleAndContent(
                    title: AppLocalizations.of(context)!.content,
                    content: widget.dataFilm!.movie.content),
                const SizedBox(
                  height: 10,
                ),
                ContentActor(items: widget.dataFilm?.movie.actor ?? []),
                const SizedBox(
                  height: 10,
                ),
                ContentCategory(items: widget.dataFilm!.movie.category),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class EpisodeNumberOfTheMovie extends StatefulWidget {
  const EpisodeNumberOfTheMovie(
      {super.key, required this.items, required this.flickManager});

  final List<MovieEpisodes> items;
  final FlickManager flickManager;

  @override
  State<EpisodeNumberOfTheMovie> createState() =>
      _EpisodeNumberOfTheMovieState();
}

class _EpisodeNumberOfTheMovieState extends State<EpisodeNumberOfTheMovie> {
  int indexSelected = 0;

  void playNewVideo(FlickManager flickManager, String url) {
    setState(() {
      flickManager
          .handleChangeVideo(VideoPlayerController.networkUrl(Uri.parse(url)));
    });
  }

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
            widget.items[0].server_data.length,
            (index) => InkWell(
              onTap: () {
                if (indexSelected != index) {
                  setState(() {
                    indexSelected = index;
                    print(indexSelected);
                  });
                  playNewVideo(widget.flickManager,
                      widget.items[0].server_data[index].link_m3u8);
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: 35,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: indexSelected == index ? Colors.pink : Colors.grey,
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
class ContentActor extends StatelessWidget {
  const ContentActor({super.key, required this.items});

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
                  width: handleWidthActor(items, context),
                  child: Text(items[index]))),
        )
      ],
    );
  }
}

// ignore: camel_case_types
class ContentCategory extends StatelessWidget {
  const ContentCategory({super.key, required this.items});

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
                  width: handleWidthCategory(items, context),
                  child: Text(items[index].name))),
        )
      ],
    );
  }
}

class TitleAndContent extends StatelessWidget {
  const TitleAndContent({super.key, this.title = '', this.content = ''});
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

double handleWidthCategory(List items, BuildContext context) {
  double width = 0;
  if (items.length == 1) {
    width = MediaQuery.of(context).size.width - 20;
  } else if (items.length == 2) {
    width = (MediaQuery.of(context).size.width - 20) * 0.45;
  } else {
    width = (MediaQuery.of(context).size.width - 20) * 0.3;
  }
  return width;
}

double handleWidthActor(List items, BuildContext context) {
  double width = 0;
  if (items.length == 1) {
    width = MediaQuery.of(context).size.width - 0.95;
  } else {
    width = (MediaQuery.of(context).size.width - 20) * 0.45;
  }
  return width;
}
