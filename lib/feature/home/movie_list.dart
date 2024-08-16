import 'package:app/component/header_title_app.dart';
import 'package:app/config/app_size.dart';
import 'package:app/feature/home/models/movie_information.dart';
import 'package:app/feature/home/watch_a_movie.dart';
import 'package:app/feature/home/widgets/item_movie_information.dart';
import 'package:flutter/material.dart';
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
              Navigator.pop(context);
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
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WatchAMovie(
                                          movieInformation: itemFilms[index])));
                            },
                            child: ItemMovieInformation(
                              imageUrl: itemFilms[index].thumb_url,
                              name: itemFilms[index].name,
                              year: itemFilms[index].year.toString(),
                            ));
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
