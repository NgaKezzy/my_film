import 'package:app/component/loading_widget.dart';
import 'package:app/config/app_size.dart';
import 'package:app/config/print_color.dart';
import 'package:app/feature/home/cubit/movie_cubit.dart';
import 'package:app/feature/home/cubit/movie_state.dart';
import 'package:app/feature/home/models/movie_category.dart';
import 'package:app/feature/home/models/movie_information.dart';
import 'package:app/feature/home/widgets/video_player_widget.dart';
import 'package:app/l10n/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WatchAMovie extends StatefulWidget {
  const WatchAMovie({super.key, required this.movieInformation});
  final MovieInformation movieInformation;

  @override
  State<WatchAMovie> createState() => _WatchAMovieState();
}

class _WatchAMovieState extends State<WatchAMovie> {
  late MovieCubit movieCubit;
  bool isLoading = true;
  String linkPlay = '';
  List<String> actors = [];

  @override
  void initState() {
    super.initState();
    printYellow(widget.movieInformation.slug);
    movieCubit = context.read<MovieCubit>();

    movieCubit.getMovieDetails(widget.movieInformation.slug).then((value) => {
          setState(
            () {
              actors = movieCubit.state.dataFilm!.movie.actor;

              isLoading = false;
              linkPlay = context
                  .read<MovieCubit>()
                  .state
                  .dataFilm!
                  .episodes[0]
                  .server_data[0]
                  .link_m3u8;
            },
          )
        });
  }

  @override
  Widget build(BuildContext context) {
    final LocaleCubit localeCubit = context.watch<LocaleCubit>();
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        return Scaffold(
          body: isLoading
              ? const Center(
                  child: LoadingWidget(),
                )
              : context.watch<MovieCubit>().state.dataFilm == null
                  ? Center(
                      child: Text(AppLocalizations.of(context)!.movieUpdate))
                  : SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            VideoPlayerWidget(
                              url: linkPlay,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 20,
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
                                              ? widget.movieInformation.name
                                              : widget
                                                  .movieInformation.origin_name,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  titleAndContent(
                                      title:
                                          AppLocalizations.of(context)!.content,
                                      content: state.dataFilm!.movie.content),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  contentActor(
                                      items: state.dataFilm!.movie.actor),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  contentCategory(
                                      items: state.dataFilm!.movie.category),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
        );
      },
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

class contentCategory extends StatelessWidget {
  const contentCategory({super.key, required this.items});

  final List<MovieCategory> items;

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
          Text(
            textAlign: TextAlign.justify,
            content,
          ),
        ],
      ),
    );
  }
}
