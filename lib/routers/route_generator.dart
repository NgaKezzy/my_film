import 'package:app/feature/download/download_page.dart';
import 'package:app/feature/explore/explore_page.dart';
import 'package:app/feature/home/home_page.dart';
import 'package:app/feature/splash/splash_screen.dart';
import 'package:app/my_home_app.dart';
import 'package:app/routers/router_name.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.SPLASH:
        return _GeneratePageRoute(
            widget: const SplashScreen(), routeName: settings.name);
      case RoutesName.HOME_APP:
        return _GeneratePageRoute(
            widget: const MyHomeApp(), routeName: settings.name);
      case RoutesName.HOME_PAGE:
        return _GeneratePageRoute(widget: HomePage(), routeName: settings.name);
      case RoutesName.Explore_Page:
        return _GeneratePageRoute(
            widget: ExplorePage(), routeName: settings.name);
      case RoutesName.DOWNLOAD_PAGE:
        return _GeneratePageRoute(
            widget: const DownloadPage(), routeName: settings.name);
      default:
        return _GeneratePageRoute(widget: HomePage(), routeName: settings.name);
    }
  }
}

class _GeneratePageRoute extends PageRouteBuilder {
  final Widget widget;
  final String? routeName;
  _GeneratePageRoute({required this.widget, this.routeName})
      : super(
            settings: RouteSettings(name: routeName),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return widget;
            },
            transitionDuration: Duration(milliseconds: 500),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return SlideTransition(
                textDirection: TextDirection.rtl,
                position: Tween<Offset>(
                  begin: Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            });
}
