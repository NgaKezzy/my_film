import 'package:app/component/header_app.dart';
import 'package:app/component/item_setting.dart';
import 'package:app/config/app_size.dart';
import 'package:app/feature/setting/select_language.dart';
import 'package:app/feature/setting/view_history.dart';
import 'package:app/theme/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context).colorScheme;
    final ThemeCubit themeCubit = context.watch<ThemeCubit>();
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
                      Text(AppLocalizations.of(context)!.darkMode),
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
              text: AppLocalizations.of(context)!.language,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SelectLanguage()));
              },
            ),
            ItemSetting(
              path: 'assets/icons/bookmark.svg',
              text: AppLocalizations.of(context)!.viewHistory,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ViewHistory()));
              },
            )
          ],
        ),
      ),
    );
  }
}
