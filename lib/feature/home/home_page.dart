import 'dart:async';

import 'package:app/config/app_size.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../component/item_grid_film.dart';
import '../../component/item_slider_image.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> items = [
    'https://scontent-hkg4-1.xx.fbcdn.net/v/t39.30808-6/369675092_972893223923222_6594530155185599788_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=dd5e9f&_nc_eui2=AeFkmm6keKiWURpCoG-apk7Mg3V-cjViJ-2DdX5yNWIn7YUrvN4pUWNLsdoyypfejyLMV5qMmpRTrcGcUmky-g-3&_nc_ohc=1VobmT98Bq4AX__xbQa&_nc_ht=scontent-hkg4-1.xx&oh=00_AfBFGVS2nR3KvDoYkO9cfFIZq8WacD1INDkyekcNFeavrw&oe=65EB26B1',
    'https://scontent-hkg1-1.xx.fbcdn.net/v/t39.30808-6/416159356_1040767100469167_4160449824371492216_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=dd5e9f&_nc_eui2=AeFqonbkVsqKlHzeK4sq-uAEh1lM89ufeHyHWUzz2594fKFMPOi0swwrBPxgtq7RAl5Ji4FgBeWlr_5J5bEoZ5bg&_nc_ohc=WSYsm8swqV0AX_oZujW&_nc_oc=AQk1WXUlH-3Ox0xKYWaxsM-4PqF8z8CdZgsPzmoP2g18QofV42MouA5gPAJsUXHBWhpapgYpxdSvcPUn1Wng6fPN&_nc_ht=scontent-hkg1-1.xx&oh=00_AfCfPqyejjB7r0iR4X9m11HZzKAyxzEN1lMRaUjKd2b04w&oe=65EB7D50',
    'https://scontent-hkg1-2.xx.fbcdn.net/v/t39.30808-6/404928254_1021163959096148_4125032703481119641_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=dd5e9f&_nc_eui2=AeES_VoT7ifCxEB6gB-PvNOFJIaXXosR9KQkhpdeixH0pIxjY-z7qJvfhx56D808g8Irc3BdKPirOA3FgPmY1IJ1&_nc_ohc=_FXJu0taJOUAX-nUThD&_nc_ht=scontent-hkg1-2.xx&oh=00_AfDGWv48BZnnWtMbC9ooidCfi-xmbhJzTLm3a1refd2Cqw&oe=65EB761A',
    'https://scontent-hkg1-2.xx.fbcdn.net/v/t39.30808-6/404001288_1018261012719776_8046360455298572426_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=dd5e9f&_nc_eui2=AeHZEKVMQMpK9hq_qPuPXulhOyrbKw_XRPc7KtsrD9dE94sh1DRgi9CEm3asHqJEoo9VDBJl_u-S-FamGAutNXlo&_nc_ohc=gQBna7Me29QAX_ZWN1e&_nc_ht=scontent-hkg1-2.xx&oh=00_AfASZDXFewbeiLJJjJFCt_VLy1aVGEW0-tZHT1LdZQMJ3Q&oe=65EC3B75',
    'https://scontent-hkg1-2.xx.fbcdn.net/v/t39.30808-6/339466707_742082007454510_5150962880705956640_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=dd5e9f&_nc_eui2=AeG48UbLTZsuYbwq5htGDfZrTKaDXDzTiGlMpoNcPNOIaTgBSqI2tniRrRbQgdwZT010lWDiuDYkl2PXMEhS-kc2&_nc_ohc=f43At1Y3wWIAX8RCvav&_nc_ht=scontent-hkg1-2.xx&oh=00_AfDK-UChm2GMTSLk8BgxK4NJ8hQcsAqIRWlSSWuOokSR5w&oe=65ECA5D6',
  ];
  final CarouselController carouselController = CarouselController();
  late Timer _timer;
  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      carouselController.nextPage(
          duration: const Duration(milliseconds: 400), curve: Curves.linear);
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: CarouselSlider(
                  carouselController: carouselController,
                  options: CarouselOptions(
                    height: height * 0.5,
                    viewportFraction: 1.0,
                    autoPlay: true,
                  ),
                  items: List.generate(
                      items.length,
                      (index) => ItemSliderImage(
                            imageUrl: items[index],
                          )),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 10),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 10),
              ),
              ItemGridFilm(itemsFilm: items),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      color: index.isOdd ? Colors.white : Colors.black12,
                      height: 100.0,
                      child: Center(
                        child: Text(
                          '$index',
                        ),
                      ),
                    );
                  },
                  childCount: 10,
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      color: index.isOdd ? Colors.red : Colors.blue,
                      height: 100.0,
                      child: Center(
                        child: Text(
                          '$index',
                        ),
                      ),
                    );
                  },
                  childCount: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
