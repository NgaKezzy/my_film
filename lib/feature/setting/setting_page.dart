import 'package:app/component/header_app.dart';
import 'package:app/component/item_setting.dart';
import 'package:app/feature/select_language/select_language.dart';
import 'package:app/theme/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final ThemeCubit themeCubit = context.watch<ThemeCubit>();
    return Scaffold(
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
                Text(AppLocalizations.of(context)!.darkMode),
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
            text: AppLocalizations.of(context)!.language,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectLanguage(),
                  ));
            },
          )
        ],
      ),
    );
  }
}
