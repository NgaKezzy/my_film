import 'dart:async';
import 'package:app/component/loading_widget.dart';
import 'package:app/config/app_size.dart';
import 'package:app/feature/home/cubit/movie_cubit.dart';
import 'package:app/feature/home/cubit/movie_state.dart';
import 'package:app/feature/home/widgets/item_film_horizontally.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'widgets/item_grid_film.dart';
import 'widgets/item_slider_image.dart';
import 'watch_a_movie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselController carouselController = CarouselController();
  late Timer _timer;
  late MovieCubit movieCubit;
  bool isLoading = true;
  @override
  void initState() {
    movieCubit = context.read<MovieCubit>();
    initialization().then((value) => {
          setState(
            () {
              isLoading = false;
            },
          ),
          if (movieCubit.state.movies.isNotEmpty)
            {
              _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
                carouselController.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.linear);
              })
            },
        });
    super.initState();
  }

  Future<void> initialization() async {
    movieCubit.getMovie();
    movieCubit.getAListOfIndividualMovies();
    movieCubit.getTheListOfMoviesAndSeries();
    movieCubit.getTheListOfCartoons();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final app = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: isLoading
          ? const Center(
              child: LoadingWidget(),
            )
          : SafeArea(
              child: BlocBuilder<MovieCubit, MovieState>(
                builder: (context, state) {
                  return CustomScrollView(
                    slivers: [
                      state.movies.isNotEmpty
                          ? SliverToBoxAdapter(
                              child: CarouselSlider(
                                carouselController: carouselController,
                                options: CarouselOptions(
                                  height: height * 0.5,
                                  viewportFraction: 1.0,
                                  autoPlay: true,
                                ),
                                items: List.generate(
                                    10,
                                    (index) => ItemSliderImage(
                                          imageUrl:
                                              state.movies[index].poster_url,
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                child: WatchAMovie(
                                                  slug:
                                                      state.movies[index].slug,
                                                ),
                                              ),
                                            );
                                          },
                                        )),
                              ),
                            )
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
            ),
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
              style: TextStyle(
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
