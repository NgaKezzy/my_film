import 'package:app/component/loading_widget.dart';
import 'package:app/config/print_color.dart';
import 'package:app/feature/home/cubit/movie_cubit.dart';
import 'package:app/feature/home/cubit/movie_state.dart';
import 'package:app/feature/home/watch_a_movie.dart';
import 'package:app/l10n/cubit/locale_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  late MovieCubit movieCubit;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieCubit = context.read<MovieCubit>();
    movieCubit.moviesSearch('Siêu anh hùng').then((value) => {
          setState(
            () {
              isLoading = false;
            },
          )
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: LoadingWidget(),
              )
            : Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        cursorColor: theme.colorScheme.onPrimary,
                        autofocus: false,
                        controller: searchController,
                        onChanged: (value) {
                          movieCubit.moviesSearch(value.trim());
                        },
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.search,
                              color: theme.colorScheme.tertiary),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          fillColor: theme.colorScheme.tertiary,
                          hintText: AppLocalizations.of(context)!.search,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 1,
                              color: theme.colorScheme.tertiary,
                              style: BorderStyle.solid,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 1,
                              color: theme.colorScheme.tertiary,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<MovieCubit, MovieState>(
                    builder: (context, state) {
                      return Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 50),
                          itemCount: state.moviesSearch.length,
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: InkWell(
                                onTap: () {
                                  printRed(state.moviesSearch[index].slug);
                                  FocusScope.of(context).unfocus();

                                  context.goNamed('watchAMovieSearch',
                                      queryParameters: {
                                        'slug': state.moviesSearch[index].slug
                                      });
                                },
                                child: Row(children: [
                                  SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'https://img.phimapi.com/${state.moviesSearch[index].poster_url}',
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
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
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      context
                                                  .watch<LocaleCubit>()
                                                  .state
                                                  .languageCode ==
                                              'en'
                                          ? state
                                              .moviesSearch[index].origin_name
                                          : state.moviesSearch[index].name,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ]),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  )
                ],
              ),
      ),
    );
  }
}
