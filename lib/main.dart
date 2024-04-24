import 'package:app/bloc_observer/my_bloc_observer.dart';
import 'package:app/feature/home/cubit/home_page_cubit.dart';
import 'package:app/feature/home/cubit/movie_cubit.dart';
import 'package:app/feature/splash/splash_screen.dart';
import 'package:app/firebase/firebase_api.dart';
import 'package:app/l10n/cubit/locale_cubit.dart';
import 'package:app/local_storage/local_storage.dart';
import 'package:app/theme/cubit/theme_cubit.dart';
import 'package:app/theme/dark_theme.dart';
import 'package:app/theme/light_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

String language = 'vi';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  await Hive.initFlutter('dev_box');
  await LocalStorage.hiveRegisterAdapter();
  await LocalStorage.hiveOpenBox();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.blue, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
  ));
  // Bloc.observer = MyBlocObserver();
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
        BlocProvider(
          create: (context) => MovieCubit(),
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
