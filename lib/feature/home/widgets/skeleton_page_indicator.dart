import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonPageIndicator extends StatelessWidget {
  const SkeletonPageIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SkeletonTheme(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              10,
              (index) => Container(
                margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
                child: SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                    height: 10,
                    width: 10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
