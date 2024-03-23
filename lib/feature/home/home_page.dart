import 'dart:async';
import 'package:app/component/loading_widget.dart';
import 'package:app/config/app_size.dart';
import 'package:app/feature/home/cubit/home_page_cubit.dart';
import 'package:app/feature/home/cubit/home_page_state.dart';
import 'package:app/feature/home/cubit/movie_cubit.dart';
import 'package:app/feature/home/cubit/movie_state.dart';
import 'package:app/feature/home/widgets/item_film_horizontally.dart';
import 'package:app/feature/home/widgets/item_slider_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'widgets/item_grid_film.dart';
import 'watch_a_movie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MovieCubit movieCubit;
  late HomePageCubit homePageCubit;
  bool isLoading = true;

  Future<void> checkStatusNetwork() async {
    homePageCubit.checkNetwork().then((value) async => {
          if (homePageCubit.state.isConnectNetwork == false)
            {
              Future.delayed(const Duration(seconds: 1), () {
                checkStatusNetwork();
              }),
            }
          else
            {
              await initialization(),
              setState(
                () {
                  isLoading = false;
                },
              ),
            }
        });
  }

  @override
  void initState() {
    super.initState();
    movieCubit = context.read<MovieCubit>();
    homePageCubit = context.read<HomePageCubit>();
    checkStatusNetwork();
  }

  Future<void> initialization() async {
    movieCubit.getMovie();
    movieCubit.getAListOfIndividualMovies();
    movieCubit.getTheListOfMoviesAndSeries();
    movieCubit.getTheListOfCartoons();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final app = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        return Scaffold(
          body: context.read<HomePageCubit>().state.isConnectNetwork == false
              ? Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.wifi_off, size: 80),
                        Text(AppLocalizations.of(context)!.noNetworkConnection),
                      ],
                    ),
                  ),
                )
              : isLoading
                  ? const Center(
                      child: LoadingWidget(),
                    )
                  : BlocBuilder<MovieCubit, MovieState>(
                      builder: (context, state) {
                        return CustomScrollView(
                          slivers: [
                            state.movies.isNotEmpty
                                ? SliverToBoxAdapter(
                                    child: SizedBox(
                                        height: height * 0.35,
                                        width: width,
                                        child: Swiper(
                                          autoplay: true,
                                          autoplayDelay: 3000,
                                          itemCount: state.movies.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return ItemSliderImage(
                                              imageUrl: state
                                                  .movies[index].poster_url,
                                              onTap: () {
                                                context.goNamed('watchAMovie',
                                                    queryParameters: {
                                                      'slug': state
                                                          .movies[index].slug
                                                    });
                                              },
                                            );
                                          },
                                        )))
                                : const SliverToBoxAdapter(),
                            const SliverToBoxAdapter(
                              child: SizedBox(height: 30),
                            ),
                            state.singleMovies.isEmpty
                                ? const SliverToBoxAdapter()
                                : TitleAndChevronRight(
                                    title: app!.singleMovie,
                                    color: theme.colorScheme.tertiary),
                            state.singleMovies.isEmpty
                                ? const SliverToBoxAdapter()
                                : ItemGridFilm(
                                    itemsFilm: state.singleMovies,
                                  ),
                            const SliverToBoxAdapter(
                              child: SizedBox(height: 30),
                            ),
                            state.cartoon.isEmpty
                                ? const SliverToBoxAdapter()
                                : TitleAndChevronRight(
                                    title: app!.cartoon,
                                    color: theme.colorScheme.tertiary),
                            state.cartoon.isEmpty
                                ? const SliverToBoxAdapter()
                                : ItemFilmHorizontally(
                                    itemsFilm: state.cartoon,
                                  ),
                            const SliverToBoxAdapter(
                              child: SizedBox(height: 30),
                            ),
                            state.seriesMovies.isEmpty
                                ? const SliverToBoxAdapter()
                                : TitleAndChevronRight(
                                    title: app!.seriesMovie,
                                    color: theme.colorScheme.tertiary),
                            state.seriesMovies.isEmpty
                                ? const SliverToBoxAdapter()
                                : ItemGridFilm(
                                    itemsFilm: state.seriesMovies,
                                  ),
                            const SliverToBoxAdapter(
                              child: SizedBox(height: 30),
                            ),
                          ],
                        );
                      },
                    ),
        );
      },
    );
  }
}

class TitleAndChevronRight extends StatelessWidget {
  const TitleAndChevronRight({
    super.key,
    this.title = '',
    this.color = Colors.black,
  });

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: AppSize.size20, fontWeight: FontWeight.w600),
            ),
            SvgPicture.asset(
              'assets/icons/chevron-right.svg',
              color: color,
            )
          ],
        ),
      ),
    );
  }
}
