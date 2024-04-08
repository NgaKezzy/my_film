import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemSliderImage extends StatelessWidget {
  const ItemSliderImage(
      {super.key, required this.imageUrl, required this.onTap});
  final String imageUrl;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: CachedNetworkImage(
        width: width,
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fill,
            ),
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.warning),
      ),
    );
  }
}
