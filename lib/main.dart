import 'package:app/feature/home/cubit/home_page_cubit.dart';
import 'package:app/l10n/cubit/locale_cubit.dart';
import 'package:app/theme/cubit/theme_cubit.dart';
import 'package:app/theme/dark_theme.dart';
import 'package:app/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feature/splash/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String language = 'vi';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocaleCubit(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => HomePageCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late LocaleCubit localeCubit;
  late ThemeCubit themeCubitRead;
  @override
  void initState() {
    themeCubitRead = context.read<ThemeCubit>();
    localeCubit = context.read<LocaleCubit>();
    themeCubitRead.initTheme();
    localeCubit.initLanguage();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeCubit themeCubit = context.watch<ThemeCubit>();
    final LocaleCubit localeCubitWatch = context.watch<LocaleCubit>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(localeCubit.state.languageCode.isEmpty
          ? 'en'
          : localeCubitWatch.state.languageCode),
      theme: themeCubit.state.isDark ? dark : light,
      home: const SplashScreen(),
    );
  }
}
