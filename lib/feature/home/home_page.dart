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
import 'package:app/feature/home/search_movie.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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

  Future<void> permissionHandle() async {
    if (await Permission.notification.request().isDenied) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.notification),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(AppLocalizations.of(context)!
                      .allowAppsToAccessNotifications),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.cancel),
                onPressed: () {
                  homePageCubit.notificationsEnabled();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.ok),
                onPressed: () {
                  homePageCubit.notificationsEnabled();
                  Navigator.of(context).pop();
                  openAppSettings();
                },
              ),
            ],
          );
        },
      );
    }
  }

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
              Future.delayed(const Duration(seconds: 1), () {
                homePageCubit.loadingHomeIsFalse();
              }),
            }
        });
  }

  @override
  void initState() {
    super.initState();
    movieCubit = context.read<MovieCubit>();
    homePageCubit = context.read<HomePageCubit>();
    homePageCubit.state.isNotification ? {} : permissionHandle();

    checkStatusNetwork();
  }

  Future<void> initialization() async {
    movieCubit.getMovie();
    movieCubit.getAListOfIndividualMovies();
    movieCubit.getTheListOfMoviesAndSeries();
    movieCubit.getTheListOfCartoons();
  }

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final app = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final HomePageCubit homePageCubitWatch = context.watch<HomePageCubit>();

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<HomePageCubit, HomePageState>(
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
              : homePageCubitWatch.state.isLoadingHome
                  ? const Center(
                      child: LoadingWidget(),
                    )
                  : Scaffold(
                      appBar: AppBar(
                        backgroundColor: theme.colorScheme.primary,
                        automaticallyImplyLeading: false,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _scrollController.animateTo(0.0,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut);
                              },
                              child: SvgPicture.asset(
                                'assets/icons/icon_app.svg',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: const SearchMovie(),
                                        type: PageTransitionType.leftToRight));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                alignment: Alignment.centerLeft,
                                height: 32,
                                width: width * 0.8,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: theme.colorScheme.tertiary,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      app!.search,
                                      style: TextStyle(
                                          fontSize: AppSize.size13,
                                          fontWeight: FontWeight.w200,
                                          color: theme.colorScheme.tertiary),
                                    ),
                                    Icon(
                                      Icons.search,
                                      color: theme.colorScheme.tertiary,
                                      size: 15,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      body: BlocBuilder<MovieCubit, MovieState>(
                        builder: (context, state) {
                          return CustomScrollView(
                            controller: _scrollController,
                            slivers: [
                              state.movies.isNotEmpty
                                  ? SliverToBoxAdapter(
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 8),
                                        height: height * 0.23,
                                        width: width,
                                        child: CarouselSlider.builder(
                                          itemCount: state.movies.length,
                                          itemBuilder: (BuildContext context,
                                                  int itemIndex,
                                                  int pageViewIndex) =>
                                              ItemSliderImage(
                                            imageUrl: state
                                                .movies[itemIndex].poster_url,
                                            onTap: () {
                                              movieCubit.addToWatchHistory(
                                                  itemFilm:
                                                      state.movies[itemIndex]);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      WatchAMovie(
                                                    movieInformation:
                                                        state.movies[itemIndex],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          options: CarouselOptions(
                                            autoPlay: true,
                                            enlargeCenterPage: true,
                                            viewportFraction: 0.75,
                                            onPageChanged: (index, reason) {
                                              homePageCubit.setPageIndex(index);
                                            },
                                            // aspectRatio: 2.0,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SliverToBoxAdapter(),
                              SliverToBoxAdapter(
                                child: Center(
                                  child: state.movies.isNotEmpty
                                      ? Column(
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SmoothPageIndicator(
                                                controller: PageController(
                                                    initialPage: homePageCubit
                                                        .state
                                                        .currentIndexPage), // PageController
                                                count: state.movies.length,
                                                effect: WormEffect(
                                                    dotWidth: 10,
                                                    dotHeight: 10,
                                                    activeDotColor: theme
                                                        .colorScheme
                                                        .onPrimary), // your preferred effect
                                                onDotClicked: (index) {}),
                                          ],
                                        )
                                      : const SizedBox(),
                                ),
                              ),

                              /// phim lẻ
                              ItemGridAndTitle(
                                itemFilms: state.singleMovies,
                                title: app.singleMovie,
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
      ),
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
        child: GestureDetector(
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
