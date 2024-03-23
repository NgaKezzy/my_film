import 'package:app/feature/home/models/movie_information.dart';
import 'package:app/feature/home/watch_a_movie.dart';
import 'package:app/l10n/cubit/locale_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';

// ignore: must_be_immutable
class ItemFilmHorizontally extends StatelessWidget {
  ItemFilmHorizontally({
    super.key,
    this.itemsFilm = const [],
  });
  List<MovieInformation> itemsFilm;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: SizedBox(
          height: 230, //
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1.5,
            ),
            itemBuilder: (BuildContext context, int index) {
              // Tạo và trả về mục hiển thị trong danh sách
              return InkWell(
                onTap: () {
                  context.goNamed('watchAMovie',
                      queryParameters: {'slug': itemsFilm[index].slug});
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
                      // height: 35,
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
            itemCount: itemsFilm.length, // Số lượng mục trong danh sách
          ),
        ),
      ),
    );
  }
}
