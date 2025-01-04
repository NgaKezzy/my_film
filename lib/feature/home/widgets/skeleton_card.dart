import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonMovieCard extends StatelessWidget {
  const SkeletonMovieCard({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SliverToBoxAdapter(
      child: SkeletonTheme(
        child: Container(
          margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: SkeletonLine(
              style: SkeletonLineStyle(
                height: height * 0.23,
                width: width,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
