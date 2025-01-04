import 'package:app/config/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonItemGridAndTitle extends StatelessWidget {
  const SkeletonItemGridAndTitle({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          children: [
            Row(
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
            const SizedBox(height: 10.0),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.6,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Expanded(
                      child: SkeletonTheme(
                        child: SkeletonLine(
                            style: SkeletonLineStyle(
                          height: size.height * 0.18,
                          width: size.width * 0.31,
                          borderRadius: BorderRadius.circular(8),
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SkeletonTheme(
                      child: SkeletonLine(
                          style: SkeletonLineStyle(
                        height: 18,
                        width: size.width * 0.31,
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
                        width: size.width * 0.31,
                        borderRadius: BorderRadius.circular(8),
                      )),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SkeletonTheme(
                  child: SkeletonLine(
                      style: SkeletonLineStyle(
                    height: 30,
                    width: size.width * 0.8,
                    borderRadius: BorderRadius.circular(8),
                  )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
