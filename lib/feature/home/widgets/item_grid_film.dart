import 'package:app/config/app_size.dart';
import 'package:app/feature/home/models/movie_information.dart';
import 'package:app/feature/home/watch_a_movie.dart';
import 'package:app/l10n/cubit/locale_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

// ignore: must_be_immutable
class ItemGridFilm extends StatelessWidget {
  ItemGridFilm({super.key, required this.itemsFilm, required this.onTap});
  List<MovieInformation> itemsFilm;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      sliver: SliverGrid.builder(
        itemCount: 9,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Số cột trong lưới
          mainAxisSpacing: 10, // Khoảng cách theo trục chính
          crossAxisSpacing: 10, // Khoảng cách theo trục phụ
          childAspectRatio: 0.6,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              onTap.call();
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: WatchAMovie(
                        slug: itemsFilm[index].slug,
                      )));
            },
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://img.phimapi.com/${itemsFilm[index].poster_url}',
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
                  // color: Colors.red,
                  height: 35,
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
      ),
    );
  }
}
