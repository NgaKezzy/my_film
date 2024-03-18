import 'package:app/config/app_size.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemGridFilm extends StatelessWidget {
  ItemGridFilm({super.key, required this.itemsFilm});
  List itemsFilm;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: itemsFilm.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Số cột trong lưới
        mainAxisSpacing: 20, // Khoảng cách theo trục chính
        crossAxisSpacing: 10, // Khoảng cách theo trục phụ
        childAspectRatio: 0.6,
      ),
      itemBuilder: (context, index) {
        return Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: itemsFilm[index],
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      width: MediaQuery.of(context).size.width * 0.28,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'Tập 1',
                          style: TextStyle(fontSize: AppSize.size12),
                        ),
                      ))
                ],
              ),
            ),
            Container(
              // color: Colors.red,
              height: 35,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: const Text(
                'Hôm nay ăn gì đc nhở hả bọn mày ơi cứu tao với',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            )
          ],
        );
      },
    );
  }
}
