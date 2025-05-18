import 'package:app/component/loading_widget.dart';
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
                      crossAxisCount:
                          3, // nếu muốn hiển thị số lượng phim theo hàng ngang
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 0.6,
                    ),
                    itemCount: itemCount, // Số lượng items trong grid view
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          context.push(
                              '${AppRouteConstant.myHomeApp}${AppRouteConstant.watchAVideo}',
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
                                  placeholder: (context, url) => Center(
                                    child: LoadingWidget(),
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
                      // mạc định hiển thị 9 phim, ấn xem thêm thì gán bằng 15 và ngược lại
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
