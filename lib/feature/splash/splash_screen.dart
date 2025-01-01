import 'dart:async';
import 'package:app/config/app_color.dart';
import 'package:app/feature/home/cubit/home_page_cubit.dart';
import 'package:app/feature/home/cubit/movie_cubit.dart';
import 'package:app/l10n/cubit/locale_cubit.dart';
import 'package:app/my_home_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

bool isFirstCheck = true;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late LocaleCubit localeCubit;
  late HomePageCubit homePageCubit;
  late MovieCubit movieCubit;

  @override
  void initState() {
    super.initState();
    localeCubit = context.read<LocaleCubit>();
    homePageCubit = context.read<HomePageCubit>();
    movieCubit = context.read<MovieCubit>();

    homePageCubit.initIsSelectedNotifications();

    getData();
    localeCubit.checkIsSelectedLanguage();

    Timer(const Duration(seconds: 3), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
        SystemUiOverlay.top,
      ]);

      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
      );
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MyHomeApp()),
          (route) => false);
    });
  }

  void getData() async {
    await movieCubit.getMovieDataTheLocalStorage();
    await movieCubit.getViewHistoryTheLocalStorage();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.asset(
                'assets/icons/icon_app.svg',
                height: 130,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
