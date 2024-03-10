import 'package:app/config/app_size.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ItemFilmHorizontally extends StatelessWidget {
  const ItemFilmHorizontally({super.key, this.itemsFilm = const []});
  final List itemsFilm;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SliverToBoxAdapter(
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
            return Stack(
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
                    errorWidget: (context, url, error) => Icon(Icons.error),
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
            );
          },
          itemCount: itemsFilm.length, // Số lượng mục trong danh sách
        ),
      ),
    );
  }
}
