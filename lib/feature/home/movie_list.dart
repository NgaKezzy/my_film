import 'package:app/component/header_title_app.dart';
import 'package:app/config/app_size.dart';
import 'package:app/feature/home/models/movie_information.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MovieList extends StatelessWidget {
  const MovieList({super.key, this.title = '', this.itemFilms = const []});
  final String title;
  final List<MovieInformation> itemFilms;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final app = AppLocalizations.of(context);

    return Scaffold(
      body: Column(
        children: [
          HeaderTitleApp(
            onTap: () {
              context.pop();
            },
            title: title,
          ),
          itemFilms.isEmpty
              ? Container(
                  alignment: Alignment.center,
                  height: height - 136,
                  width: width,
                  child: Text(app!.movieListIsEmpty),
                )
              : Expanded(
                  child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            context.goNamed('watchAMovie', queryParameters: {
                              'slug': itemFilms[index].slug
                            });
                          },
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: SizedBox(
                                  width: width * 0.4,
                                  height: 80,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://img.phimapi.com/${itemFilms[index].thumb_url}',
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.warning),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 80,
                                width: width * 0.6 - 20,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        itemFilms[index].name,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Text(itemFilms[index]
                                              .year
                                              .toString())),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: AppSize.size10,
                          ),
                      itemCount: itemFilms.length),
                )
        ],
      ),
    );
  }
}
