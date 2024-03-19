import 'package:app/component/loading_widget.dart';
import 'package:app/feature/home/cubit/movie_cubit.dart';
import 'package:app/feature/home/cubit/movie_state.dart';
import 'package:app/feature/home/models/movie_information.dart';
import 'package:app/feature/home/widgets/video_player_widget.dart';
import 'package:app/l10n/cubit/locale_cubit.dart';
import 'package:app/my_home_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

class WatchAMovie extends StatefulWidget {
  const WatchAMovie({super.key, required this.movieInformation});
  final MovieInformation movieInformation;

  @override
  State<WatchAMovie> createState() => _WatchAMovieState();
}

class _WatchAMovieState extends State<WatchAMovie> {
  late MovieCubit movieCubit;
  late LocaleCubit localeCubit;

  bool isLoading = true;
  String linkPlay = '';
  List<String> actors = [];
  String content = '';
  String languageCode = '';

  @override
  void initState() {
    super.initState();
    movieCubit = context.read<MovieCubit>();
    localeCubit = context.read<LocaleCubit>();

    movieCubit
        .getMovieDetails(
            widget.movieInformation.slug, localeCubit.state.languageCode)
        .then((value) => {
              // actors = movieCubit.state.dataFilm!.movie.actor,
              isLoading = false,
              linkPlay = context
                  .read<MovieCubit>()
                  .state
                  .dataFilm!
                  .episodes[0]
                  .server_data[0]
                  .link_m3u8,
              setState(
                () {},
              )
            });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            body: isLoading
                ? const Center(
                    child: LoadingWidget(),
                  )
                : context.watch<MovieCubit>().state.dataFilm == null
                    ? Center(
                        child: Text(AppLocalizations.of(context)!.movieUpdate))
                    : SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                VideoPlayerWidget(
                                    url: linkPlay, dataFilm: state.dataFilm),
                                Positioned(
                                    left: 20,
                                    top: 20,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          PageTransition(
                                            type:
                                                PageTransitionType.topToBottom,
                                            duration: const Duration(
                                                milliseconds: 600),
                                            child:
                                                const MyHomeApp(), // Màn hình tiếp theo
                                          ),
                                          (route) => false,
                                        );
                                      },
                                      child: SvgPicture.asset(
                                        'assets/icons/chevron_down.svg',
                                        color: Colors.red,
                                        width: 30,
                                      ),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
          ),
        );
      },
    );
  }
}
