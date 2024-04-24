import 'package:app/component/header_app.dart';
import 'package:app/component/item_setting.dart';
import 'package:app/config/app_size.dart';
import 'package:app/feature/home/cubit/movie_cubit.dart';
import 'package:app/feature/setting/select_language.dart';
import 'package:app/feature/setting/view_history.dart';
import 'package:app/theme/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context).colorScheme;
    final ThemeCubit themeCubit = context.watch<ThemeCubit>();
    final app = AppLocalizations.of(context);
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: HeaderApp(title: AppLocalizations.of(context)!.setting),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              height: 60,
              width: width,
              // color: Colors.red,\
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      themeCubit.state.isDark
                          ? SvgPicture.asset('assets/icons/moon.svg',
                              color: theme.onPrimary)
                          : SvgPicture.asset('assets/icons/sun.svg',
                              color: theme.onPrimary),
                      const SizedBox(
                        width: AppSize.size10,
                      ),
                      Text(app!.darkMode),
                    ],
                  ),
                  Switch(
                    // This bool value toggles the switch.
                    value: themeCubit.state.isDark,
                    activeColor: Colors.red,
                    onChanged: (bool value) {
                      context.read<ThemeCubit>().toggedTheme();
                    },
                  )
                ],
              ),
            ),
            ItemSetting(
              path: 'assets/icons/global.svg',
              text: app.language,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SelectLanguage()));
              },
            ),
            ItemSetting(
              path: 'assets/icons/bookmark.svg',
              text: app.viewHistory,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ViewHistory()));
              },
            ),
            ItemSetting(
              path: 'assets/icons/trash.svg',
              text: app.clearCache,
              onTap: () {
                _showMyDialog(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

Future<void> _showMyDialog(BuildContext context) async {
  final app = AppLocalizations.of(context);
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(app!.notification),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(app.areYouSureYouWantToClearTheCache),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(app.cancel),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(app.ok),
            onPressed: () async {
              context.read<MovieCubit>().clearCache();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
