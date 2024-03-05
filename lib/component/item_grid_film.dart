import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ItemGridFilm extends StatelessWidget {
  ItemGridFilm({super.key, required this.itemsFilm});
  List itemsFilm;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: itemsFilm.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Số cột trong lưới
        mainAxisSpacing: 5, // Khoảng cách theo trục chính
        crossAxisSpacing: 5, // Khoảng cách theo trục phụ
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        return ClipRRect(
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
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        );
      },
    );
  }
}
