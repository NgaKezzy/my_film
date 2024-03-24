import 'package:app/component/loading_widget.dart';
import 'package:app/feature/home/cubit/movie_cubit.dart';
import 'package:app/feature/home/cubit/movie_state.dart';
import 'package:app/feature/home/widgets/video_player_widget.dart';
import 'package:app/l10n/cubit/locale_cubit.dart';
import 'package:app/my_home_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';

class WatchAMovie extends StatefulWidget {
  const WatchAMovie({super.key, required this.slug});
  final String slug;

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
        .getMovieDetails(widget.slug, localeCubit.state.languageCode)
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
        return WillPopScope(
          onWillPop: () async {
            Fluttertoast.showToast(
                msg: AppLocalizations.of(context)!.pressTheButtonToExit,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey.withOpacity(0.5),
                textColor: Colors.green,
                fontSize: 16.0);
            return false;
          },
          child: Scaffold(
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
                                  context.pop();
                                },
                                child: Text(AppLocalizations.of(context)!.ok)),
                          )
                        ],
                      )
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
                                        context.pop();
                                        FocusScope.of(context).unfocus();
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
