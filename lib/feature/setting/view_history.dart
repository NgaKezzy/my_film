import 'package:app/component/header_title_app.dart';
import 'package:app/config/print_color.dart';
import 'package:app/feature/home/cubit/movie_cubit.dart';
import 'package:app/feature/home/cubit/movie_state.dart';
import 'package:app/feature/home/watch_a_movie.dart';
import 'package:app/feature/home/widgets/item_movie_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ViewHistory extends StatelessWidget {
  const ViewHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final MovieCubit movieCubit = context.read<MovieCubit>();
    final app = AppLocalizations.of(context);
    return Scaffold(
      body: Column(
        children: [
          HeaderTitleApp(
            title: app!.viewHistory,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          BlocBuilder<MovieCubit, MovieState>(
            builder: (context, state) {
              return Expanded(
                child: state.viewHistory.isEmpty
                    ? Center(
                        child: Text(app.viewHistoryIsEmpty),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.only(bottom: 50, top: 10),
                        itemCount: state.viewHistory.length,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: GestureDetector(
                                onTap: () {
                                  printRed(state.viewHistory[index]!.slug);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WatchAMovie(
                                          slug:
                                              state.viewHistory[index]?.slug ??
                                                  ''),
                                    ),
                                  );
                                },
                                child: ItemMovieInformation(
                                  imageUrl: state.viewHistory[index]!.thumb_url,
                                  name: state.viewHistory[index]!.name,
                                  year:
                                      state.viewHistory[index]!.year.toString(),
                                )),
                          );
                        },
                      ),
              );
            },
          )
        ],
      ),
    );
  }
}
