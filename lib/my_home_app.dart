import 'package:app/feature/favorite/favorite_movie_page.dart';
import 'package:app/feature/home/home_page.dart';
import 'package:app/feature/setting/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyHomeApp extends StatefulWidget {
  const MyHomeApp({super.key});

  @override
  State<MyHomeApp> createState() => _MyHomeAppState();
}

class _MyHomeAppState extends State<MyHomeApp> {
  int pageIndex = 0;
  List<Widget> pages = [
    const HomePage(),
    // const SearchPage(),
    const FavoriteMoviePage(),
    const SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final app = AppLocalizations.of(context);
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: pages[pageIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: theme.colorScheme.surface,
          type: BottomNavigationBarType.fixed,
          currentIndex: pageIndex,
          unselectedIconTheme: IconThemeData(color: theme.colorScheme.tertiary),
          showUnselectedLabels: true,
          showSelectedLabels: true,
          unselectedItemColor: theme.colorScheme.tertiary,
          selectedItemColor: theme.colorScheme.onPrimary,
          onTap: (value) {
            setState(() {
              pageIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
                color: theme.colorScheme.tertiary,
              ),
              label: app?.home,
              activeIcon: SvgPicture.asset(
                'assets/icons/home.svg',
                color: theme.colorScheme.onPrimary,
              ),
            ),
            // BottomNavigationBarItem(
            //   icon: SvgPicture.asset(
            //     'assets/icons/search.svg',
            //     color: theme.colorScheme.tertiary,
            //   ),
            //   label: app?.search,
            //   activeIcon: SvgPicture.asset(
            //     'assets/icons/search.svg',
            //     color: theme.colorScheme.onPrimary,
            //   ),
            // ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/heart.svg',
                color: theme.colorScheme.tertiary,
              ),
              label: app?.favorite,
              activeIcon: SvgPicture.asset(
                'assets/icons/heart.svg',
                color: theme.colorScheme.onPrimary,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/setting.svg',
                color: theme.colorScheme.tertiary,
              ),
              label: app?.setting,
              activeIcon: SvgPicture.asset(
                'assets/icons/setting.svg',
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
