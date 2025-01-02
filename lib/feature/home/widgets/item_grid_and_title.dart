import 'package:app/config/app_size.dart';
import 'package:app/feature/home/cubit/movie_cubit.dart';
import 'package:app/feature/home/models/movie_information.dart';
import 'package:app/feature/home/movie_list.dart';
import 'package:app/l10n/cubit/locale_cubit.dart';
import 'package:app/routers/router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

// ignore: must_be_immutable
class ItemGridAndTitle extends StatefulWidget {
  ItemGridAndTitle({
    super.key,
    required this.itemFilms,
    required this.title,
  });
  List<MovieInformation> itemFilms;
  final String title;

  @override
  State<ItemGridAndTitle> createState() => _ItemGridAndTitleState();
}

class _ItemGridAndTitleState extends State<ItemGridAndTitle> {
  bool isDetail = false;
  int itemCount = 9;

  @override
  Widget build(BuildContext context) {
    final MovieCubit movieCubit = context.read<MovieCubit>();
    final theme = Theme.of(context);
    final app = AppLocalizations.of(context);

    return SliverToBoxAdapter(
      child: widget.itemFilms.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          SwipeablePageRoute(
                              builder: (context) => MovieList(
                                    itemFilms: widget.itemFilms,
                                    title: widget.title,
                                  )));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                              fontSize: AppSize.size20,
                              fontWeight: FontWeight.w600),
                        ),
                        SvgPicture.asset(
                          'assets/icons/chevron-right.svg',
                          color: theme.colorScheme.tertiary,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 0.6,
                    ),
                    itemCount: itemCount, // Số lượng items trong grid view
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          movieCubit.addToWatchHistory(
                              itemFilm: widget.itemFilms[index]);
                          context.push(
                              '${AppRouteConstant.myHomeApp}/${AppRouteConstant.watchAVideo}',
                              extra: widget.itemFilms[index].slug);
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: widget.itemFilms[index].thumb_url,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.warning),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 40,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                context
                                            .watch<LocaleCubit>()
                                            .state
                                            .languageCode ==
                                        'en'
                                    ? widget.itemFilms[index].origin_name
                                    : widget.itemFilms[index].name,
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
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      isDetail = !isDetail;

                      if (isDetail) {
                        itemCount = 15;
                      } else {
                        itemCount = 9;
                      }
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(isDetail ? app!.hideLess : app!.seeMore),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

// ignore: must_be_immutable
class ItemGridAndTitleShimmer extends StatefulWidget {
  const ItemGridAndTitleShimmer({
    super.key,
    required this.title,
  });
  final String title;

  @override
  State<ItemGridAndTitleShimmer> createState() =>
      _ItemGridAndTitleShimmerState();
}

class _ItemGridAndTitleShimmerState extends State<ItemGridAndTitleShimmer> {
  bool isDetail = false;
  int itemCount = 9;

  @override
  Widget build(BuildContext context) {
    final MovieCubit movieCubit = context.read<MovieCubit>();
    final theme = Theme.of(context);
    final app = AppLocalizations.of(context);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: AppSize.size20, fontWeight: FontWeight.w600),
                ),
                SvgPicture.asset(
                  'assets/icons/chevron-right.svg',
                  colorFilter: ColorFilter.mode(
                      theme.colorScheme.tertiary, BlendMode.srcIn),
                )
              ],
            ),
            const SizedBox(height: 10.0),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.6,
              ),
              itemCount: itemCount, // Số lượng items trong grid view
              itemBuilder: (context, index) {
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
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              height: 30,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8)),
              child: Text(isDetail ? app!.hideLess : app!.seeMore),
            )
          ],
        ),
      ),
    );
  }
}
