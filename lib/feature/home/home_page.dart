import 'dart:async';
import 'package:app/component/loading_widget.dart';
import 'package:app/config/app_size.dart';
import 'package:app/feature/home/cubit/home_page_cubit.dart';
import 'package:app/feature/home/cubit/home_page_state.dart';
import 'package:app/feature/home/cubit/movie_cubit.dart';
import 'package:app/feature/home/cubit/movie_state.dart';
import 'package:app/feature/home/models/movie_information.dart';
import 'package:app/feature/home/movie_list.dart';
import 'package:app/feature/home/watch_a_movie.dart';
import 'package:app/feature/home/widgets/item_film_horizontally.dart';
import 'package:app/feature/home/widgets/item_grid_and_title.dart';
import 'package:app/feature/home/widgets/item_slider_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
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
              )
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
        return context.read<HomePageCubit>().state.isConnectNetwork == false
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.wifi_off, size: 80),
                    Text(AppLocalizations.of(context)!.noNetworkConnection),
                  ],
                ),
              )
            : isLoading
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
                                    child: SizedBox(
                                        height: height * 0.4,
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
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            WatchAMovie(
                                                                slug: state
                                                                    .movies[
                                                                        index]
                                                                    .slug)));
                                              },
                                            );
                                          },
                                        )))
                                : const SliverToBoxAdapter(),

                            /// phim lẻ
                            ItemGridAndTitle(
                              itemFilms: state.singleMovies,
                              title: app!.singleMovie,
                            ),

                            /// phim hoạt hình
                            state.cartoon.isEmpty
                                ? const SliverToBoxAdapter()
                                : TitleAndChevronRight(
                                    itemFilms: state.cartoon,
                                    title: app.cartoon,
                                    color: theme.colorScheme.tertiary),
                            state.cartoon.isEmpty
                                ? const SliverToBoxAdapter()
                                : ItemFilmHorizontally(
                                    itemsFilm: state.cartoon,
                                  ),

                            ///phim bộ
                            ItemGridAndTitle(
                              itemFilms: state.seriesMovies,
                              title: app.seriesMovie,
                            ),
                            const SliverToBoxAdapter(
                              child: SizedBox(height: 30),
                            )
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
  const TitleAndChevronRight(
      {super.key,
      this.title = '',
      this.color = Colors.black,
      this.itemFilms = const []});

  final String title;
  final Color color;
  final List<MovieInformation> itemFilms;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 10),
      sliver: SliverToBoxAdapter(
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MovieList(
                          itemFilms: itemFilms,
                          title: title,
                        )));
          },
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
      ),
    );
  }
}
