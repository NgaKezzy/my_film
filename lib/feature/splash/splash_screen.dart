import 'dart:async';
import 'package:app/l10n/cubit/locale_cubit.dart';
import 'package:app/my_home_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

bool isFirstCheck = true;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late LocaleCubit localeCubit;

  @override
  void initState() {
    super.initState();
    localeCubit = context.read<LocaleCubit>();
    localeCubit.checkIsSelectedLanguage();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const MyHomeApp()),
          (route) => false);
    });
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
                color: const Color(0xFFabc066),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
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
