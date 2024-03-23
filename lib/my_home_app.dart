import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'config/print_color.dart';
import 'feature/download/download_page.dart';
import 'feature/search/search_page.dart';
import 'feature/home/home_page.dart';
import 'feature/setting/setting_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyHomeApp extends StatefulWidget {
  const MyHomeApp({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  State<MyHomeApp> createState() => _MyHomeAppState();
}

class _MyHomeAppState extends State<MyHomeApp> {
  int pageIndex = 0;

  void _goToBranch(int index) {
    widget.navigationShell.goBranch(index,
        initialLocation: index == widget.navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: widget.navigationShell,
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
            _goToBranch(value);
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
