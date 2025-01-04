import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonItemFilmHorizontal extends StatelessWidget {
  const SkeletonItemFilmHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SkeletonTheme(
                  child: SkeletonLine(
                      style: SkeletonLineStyle(
                    height: 24,
                    width: size.width * 0.5,
                    borderRadius: BorderRadius.circular(8),
                  )),
                ),
                SkeletonTheme(
                  child: SkeletonLine(
                      style: SkeletonLineStyle(
                    height: 24,
                    width: 24,
                    borderRadius: BorderRadius.circular(8),
                  )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 250, //
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),

              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    SkeletonTheme(
                      child: SkeletonLine(
                          style: SkeletonLineStyle(
                        height: 200,
                        width: size.width * 0.4,
                        borderRadius: BorderRadius.circular(8),
                      )),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SkeletonTheme(
                      child: SkeletonLine(
                          style: SkeletonLineStyle(
                        height: 18,
                        width: size.width * 0.4,
                        borderRadius: BorderRadius.circular(8),
                      )),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    SkeletonTheme(
                      child: SkeletonLine(
                          style: SkeletonLineStyle(
                        height: 18,
                        width: size.width * 0.4,
                        borderRadius: BorderRadius.circular(8),
                      )),
                    ),
                  ],
                );
              },
              itemCount: 20, // Số lượng mục trong danh sách
            ),
          ),
        ],
      ),
    );
  }
}
