import 'package:app/feature/favorite/download_page.dart';
import 'package:app/feature/home/home_page.dart';
import 'package:app/feature/home/search_movie.dart';
import 'package:app/feature/setting/select_language.dart';
import 'package:app/feature/setting/setting_page.dart';
import 'package:app/feature/splash/splash_screen.dart';
import 'package:app/my_home_app.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigation {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _rootNavigatorHome =
      GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final _rootNavigatorSearch =
      GlobalKey<NavigatorState>(debugLabel: 'shellSearch');
  static final _rootNavigatorDownLoad =
      GlobalKey<NavigatorState>(debugLabel: 'shellDownLoad');
  static final _rootNavigatorSettings =
      GlobalKey<NavigatorState>(debugLabel: 'shellSettings');

  static final router = GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        /// MainPage

        builder: (context, state, navigationShell) {
          return const MyHomeApp();
        },

        branches: <StatefulShellBranch>[
          /// Brach Home --------------------------------------------

          StatefulShellBranch(
            navigatorKey: _rootNavigatorHome,
            routes: [
              GoRoute(
                name:
                    'home', // Optional, add name to your routes. Allows you navigate by name instead of path
                path: '/home',
                builder: (context, state) => HomePage(
                  key: state.pageKey,
                ),
              ),
            ],
          ),

          /// Brach Search --------------------------------------------------
          StatefulShellBranch(
            navigatorKey: _rootNavigatorSearch,
            routes: [
              GoRoute(
                name:
                    'search', // Optional, add name to your routes. Allows you navigate by name instead of path
                path: '/search',
                builder: (context, state) => SearchMovie(
                  key: state.pageKey,
                ),
              ),
            ],
          ),

          /// Brach Download ---------------------------------------------
          StatefulShellBranch(
            navigatorKey: _rootNavigatorDownLoad,
            routes: [
              GoRoute(
                name:
                    'downLoad', // Optional, add name to your routes. Allows you navigate by name instead of path
                path: '/downLoad',
                builder: (context, state) => DownloadPage(
                  key: state.pageKey,
                ),
              ),
            ],
          ),

          /// Brach Settings --------------------------------------------
          StatefulShellBranch(
            navigatorKey: _rootNavigatorSettings,
            routes: [
              GoRoute(
                name:
                    'settings', // Optional, add name to your routes. Allows you navigate by name instead of path
                path: '/settings',
                builder: (context, state) => SettingsPage(
                  key: state.pageKey,
                ),
                routes: [
                  GoRoute(
                    name: 'selectLanguage',
                    path: 'selectLanguage',
                    builder: (context, state) {
                      return SelectLanguage(
                        key: state.pageKey,
                      );
                    },
                  )
                ],
              ),
            ],
          )
        ],
      ),
      GoRoute(
        name:
            'splash', // Optional, add name to your routes. Allows you navigate by name instead of path
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
    ],
  );

  static GoRouter? globalGoRouter;

  static GoRouter getGoRouter() {
    return globalGoRouter ??= router;
  }

  static void clearAndNavigate(String path) {
    while (getGoRouter().canPop() == true) {
      getGoRouter().pop();
    }
    getGoRouter().pushReplacement(path);
  }
}
