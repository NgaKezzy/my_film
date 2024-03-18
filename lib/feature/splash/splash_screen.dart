import 'dart:async';
import 'package:app/my_home_app.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:app/feature/home/cubit/home_page_cubit.dart';
import 'package:app/l10n/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
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

  void checkStatusNetwork() {
    homePageCubit.checkNetwork().then(
          (value) => {
            if (homePageCubit.state.isConnectNetwork == false)
              {
                if (isFirstCheck)
                  {
                    showSnackBar(
                        color: Colors.white,
                        messenger:
                            AppLocalizations.of(context)!.noNetworkConnection,
                        context: context),
                    setState(
                      () {
                        isFirstCheck = false;
                      },
                    )
                  },
                Future.delayed(const Duration(seconds: 1), () {
                  checkStatusNetwork();
                }),
              }
            else
              {
                Timer(const Duration(seconds: 2), () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyHomeApp(),
                      ));
                }),
                if (isFirstCheck == false)
                  {
                    showSnackBar(
                        color: Colors.green,
                        messenger: AppLocalizations.of(context)!
                            .networkConnectionRestored,
                        context: context)
                  }
              }
          },
        );
  }

  @override
  void initState() {
    localeCubit = context.read<LocaleCubit>();
    localeCubit.checkIsSelectedLanguage();
    homePageCubit = context.read<HomePageCubit>();
    if (isFirstCheck) {
      checkStatusNetwork();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.asset(
                'assets/icons/icon_app.svg',
                height: 130,
                color: Color(0xFFabc066),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'My Film',
              style: TextStyle(
                letterSpacing: 0.5,
                fontSize: 70,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}

showSnackBar(
    {required String messenger,
    required BuildContext context,
    required Color color}) {
  SnackBar snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Text(
      messenger,
      style: TextStyle(color: color),
    ),
    backgroundColor: Theme.of(context).colorScheme.outline,
    duration: const Duration(seconds: 3),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
