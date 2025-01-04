// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/component/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemMovieInformation extends StatelessWidget {
  const ItemMovieInformation({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.year,
  });
  final String imageUrl;
  final String name;
  final String year;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            width: width * 0.4,
            height: 100,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              placeholder: (context, url) => const Center(
                child: LoadingWidget(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.warning),
            ),
          ),
        ),
        SizedBox(
          height: 80,
          width: width * 0.6 - 20,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                ),
                Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(year)),
              ],
            ),
          ),
        )
      ],
    );
  }
}
