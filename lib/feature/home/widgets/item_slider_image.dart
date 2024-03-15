import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';


class ItemSliderImage extends StatelessWidget {
  const ItemSliderImage(
      {super.key, required this.imageUrl, required this.onTap});
  final String imageUrl;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          CachedNetworkImage(
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
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          // Positioned(
          //   left: 10,
          //   bottom: 10,
          //   child: SizedBox(
          //     height: 60,
          //     width: width * 0.5,
          //     child: const Text(
          //       'Đấu phá khung thương ',
          //       overflow: TextOverflow.ellipsis,
          //       maxLines: 2,
          //       style: TextStyle(fontSize: AppSize.size25, color: Colors.white),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
