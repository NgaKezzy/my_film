import 'package:app/config/di.dart';
import 'package:app/feature/home/cubit/movie_cubit.dart';
import 'package:app/feature/home/watch_a_movie.dart';
import 'package:app/feature/splash/splash_screen.dart';
import 'package:app/my_home_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouteConstant {
  AppRouteConstant._();

  static const String initial = '/';
  static const String myHomeApp = '/my-home-app';
  static const String watchAVideo = 'watch-a-video';

  // Nested Key
  static final navigatorKeyMeansure = GlobalKey<NavigatorState>();
}

class AppRoutes {
  static final AppRoutes _singleton = AppRoutes._internal();

  factory AppRoutes() {
    return _singleton;
  }

  AppRoutes._internal();

  GoRouter router = GoRouter(
    initialLocation: AppRouteConstant.initial,
    routes: <RouteBase>[
      GoRoute(
        path: AppRouteConstant.initial,
        builder: (BuildContext context, GoRouterState state) =>
            BlocProvider<MovieCubit>.value(
          value: di.get<MovieCubit>(),
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
          path: AppRouteConstant.myHomeApp,
          builder: (BuildContext context, GoRouterState state) =>
              BlocProvider<MovieCubit>.value(
                value: di.get<MovieCubit>(),
                child: const MyHomeApp(),
              ),
          routes: [
            GoRoute(
              path: AppRouteConstant.watchAVideo,
              builder: (BuildContext context, GoRouterState state) =>
                  BlocProvider<MovieCubit>.value(
                value: di.get<MovieCubit>(),
                child: WatchAMovie(
                  slug: state.extra is String ? state.extra as String : '',
                ),
              ),
            ),
          ]),
    ],
  );
}
