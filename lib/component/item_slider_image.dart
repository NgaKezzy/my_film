import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../config/app_size.dart';

class ItemSliderImage extends StatelessWidget {
  const ItemSliderImage({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          width: width,
          imageUrl: imageUrl,
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
        Positioned(
          left: 10,
          bottom: 10,
          child: SizedBox(
            width: width * 0.5,
            child: const Text(
              'Đấu phá khung thương',
              style: TextStyle(fontSize: AppSize.size25, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
