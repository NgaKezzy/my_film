import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'config/print_color.dart';
import 'feature/download/download_page.dart';
import 'feature/explore/explore_page.dart';
import 'feature/home/home_page.dart';
import 'feature/setting/setting_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyHomeApp extends StatefulWidget {
  const MyHomeApp({super.key});

  @override
  State<MyHomeApp> createState() => _MyHomeAppState();
}

class _MyHomeAppState extends State<MyHomeApp> {
  int pageIndex = 0;

  List<Widget> pageList = <Widget>[
    const HomePage(),
    const ExplorePage(),
    const DownloadPage(),
    const SettingPage(),
    // const MeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: pageList[pageIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: theme.colorScheme.background,
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

              printRed(value.toString());
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
                color: theme.colorScheme.tertiary,
              ),
              label: AppLocalizations.of(context)?.home,
              activeIcon: SvgPicture.asset(
                'assets/icons/home.svg',
                color: theme.colorScheme.onPrimary,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/package.svg',
                color: theme.colorScheme.tertiary,
              ),
              label: AppLocalizations.of(context)?.explore,
              activeIcon: SvgPicture.asset(
                'assets/icons/package.svg',
                color: theme.colorScheme.onPrimary,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/download.svg',
                color: theme.colorScheme.tertiary,
              ),
              label: AppLocalizations.of(context)?.download,
              activeIcon: SvgPicture.asset(
                'assets/icons/download.svg',
                color: theme.colorScheme.onPrimary,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/setting.svg',
                color: theme.colorScheme.tertiary,
              ),
              label: AppLocalizations.of(context)?.setting,
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
