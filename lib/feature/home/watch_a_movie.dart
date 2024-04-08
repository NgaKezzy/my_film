import 'package:app/component/loading_widget.dart';
import 'package:app/feature/home/cubit/movie_cubit.dart';
import 'package:app/feature/home/cubit/movie_state.dart';
import 'package:app/feature/home/models/movie_information.dart';
import 'package:app/feature/home/widgets/video_player_widget.dart';
import 'package:app/l10n/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WatchAMovie extends StatefulWidget {
  const WatchAMovie({super.key, required this.movieInformation});
  final MovieInformation? movieInformation;

  @override
  State<WatchAMovie> createState() => _WatchAMovieState();
}

class _WatchAMovieState extends State<WatchAMovie> {
  late MovieCubit movieCubit;
  late LocaleCubit localeCubit;

  bool isLoading = true;
  String linkPlay = '';

  @override
  void initState() {
    super.initState();
    movieCubit = context.read<MovieCubit>();
    localeCubit = context.read<LocaleCubit>();

    movieCubit
        .getMovieDetails(
            widget.movieInformation!.slug, localeCubit.state.languageCode)
        .then((value) => {
              // actors = movieCubit.state.dataFilm!.movie.actor,
              isLoading = false,
              if (movieCubit.state.dataFilm != null)
                {
                  linkPlay = context
                      .read<MovieCubit>()
                      .state
                      .dataFilm!
                      .episodes[0]
                      .server_data[0]
                      .link_m3u8,
                },

              setState(
                () {},
              )
            });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        // ignore: deprecated_member_use
        return Scaffold(
          body: isLoading
              ? const Center(
                  child: LoadingWidget(),
                )
              : context.watch<MovieCubit>().state.dataFilm == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child:
                              Text(AppLocalizations.of(context)!.movieUpdate),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(AppLocalizations.of(context)!.ok)),
                        )
                      ],
                    )
                  : WillPopScope(
                      onWillPop: () async {
                        Fluttertoast.showToast(
                            msg: AppLocalizations.of(context)!
                                .pressTheButtonToExit,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.SNACKBAR,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.red,
                            fontSize: 16.0);
                        return false;
                      },
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                VideoPlayerWidget(
                                    movieInformation: widget.movieInformation,
                                    url: linkPlay,
                                    dataFilm: state.dataFilm),
                                Positioned(
                                    left: 20,
                                    top: 20,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
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
