import 'package:app/feature/home/cubit/movie_cubit.dart';
import 'package:app/feature/home/models/movie_information.dart';
import 'package:app/feature/home/watch_a_movie.dart';
import 'package:app/l10n/cubit/locale_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable

// ignore: must_be_immutable
class ItemFilmHorizontally extends StatelessWidget {
  ItemFilmHorizontally({
    super.key,
    this.itemsFilm = const [],
  });
  List<MovieInformation> itemsFilm;

  @override
  Widget build(BuildContext context) {
    final MovieCubit movieCubit = context.read<MovieCubit>();

    return SliverToBoxAdapter(
      child: SizedBox(
        height: 300, //
        child: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          scrollDirection: Axis.horizontal,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 1,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                movieCubit.addToWatchHistory(itemFilm: itemsFilm[index]);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            WatchAMovie(movieInformation: itemsFilm[index])));
              },
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: itemsFilm[index].poster_url,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      context.watch<LocaleCubit>().state.languageCode == 'en'
                          ? itemsFilm[index].origin_name
                          : itemsFilm[index].name,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  )
                ],
              ),
            );
          },
          itemCount: 20, // Số lượng mục trong danh sách
        ),
      ),
    );
  }
}

class ItemFilmHorizontallyShimmer extends StatelessWidget {
  const ItemFilmHorizontallyShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final MovieCubit movieCubit = context.read<MovieCubit>();

    return SliverToBoxAdapter(
      child: SizedBox(
        height: 300, //
        child: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          scrollDirection: Axis.horizontal,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 1,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade400,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade400,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          itemCount: 20, // Số lượng mục trong danh sách
        ),
      ),
    );
  }
}
