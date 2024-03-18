import 'dart:async';
import 'package:app/config/app_size.dart';
import 'package:app/feature/home/cubit/movie_cubit.dart';
import 'package:app/feature/home/cubit/movie_state.dart';
import 'package:app/feature/home/widgets/item_film_horizontally.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'widgets/item_grid_film.dart';
import 'widgets/item_slider_image.dart';
import 'watch_a_movie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> items = [
    'https://img.phimapi.com/upload/vod/20240310-1/d3cf47550315de51adf340b68af8cae6.jpg',
    'https://img.phimapi.com/upload/vod/20240310-1/33e3f4325c95396f28ab762fbeff5d20.jpg',
    'https://img.phimapi.com/upload/vod/20240311-1/e9007462ef67483e58bef1b8e03b8d3e.jpg',
    'https://img.phimapi.com/upload/vod/20240310-1/66888488d881d52832849e9b78a15618.jpg',
    'https://img.phimapi.com/upload/vod/20240310-1/54ba0039692b13292120265ce201f33c.jpg',
    'https://img.phimapi.com/upload/vod/20240310-1/a2140d6775ee98b84e208ef1172e38db.jpg'
  ];
  final CarouselController carouselController = CarouselController();
  late Timer _timer;
  late MovieCubit movieCubit;
  @override
  void initState() {
    movieCubit = context.read<MovieCubit>();
    movieCubit.getMovie().then((value) => {
          if (movieCubit.state.movies.isNotEmpty)
            {
              _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
                carouselController.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.linear);
              })
            }
        });

    super.initState();
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

    return Scaffold(
      body: SafeArea(
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
                                    imageUrl: state.movies[index].poster_url,
                                    onTap: () {
                                      _timer.cancel();
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: WatchAMovie(
                                              movieInformation:
                                                  state.movies[index]),
                                        ),
                                      );
                                    },
                                  )),
                        ),
                      )
                    : const SliverToBoxAdapter(child: SizedBox()),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 30),
                ),
                ItemGridFilm(itemsFilm: items),
                const SliverToBoxAdapter(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Phim thịnh hành',
                      style: TextStyle(fontSize: AppSize.size20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )),
                ItemFilmHorizontally(itemsFilm: items),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 30),
                ),
                ItemGridFilm(itemsFilm: items),
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
