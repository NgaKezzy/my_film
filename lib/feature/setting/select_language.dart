import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../component/button.dart';
import '../../component/flag.dart';
import '../../config/print_color.dart';
import '../../l10n/cubit/locale_cubit.dart';
import '../../l10n/cubit/locale_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectLanguage extends StatefulWidget {
  const SelectLanguage({super.key});

  @override
  State<SelectLanguage> createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  int indexSelect = -1;

  @override
  Widget build(BuildContext context) {
    final LocaleCubit localeCubit = context.read<LocaleCubit>();
    final theme = Theme.of(context);
    return Scaffold(
      // backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: BlocBuilder<LocaleCubit, LocaleState>(
                builder: (context, state) {
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    itemCount: state.languageCodes.length,
                    itemBuilder: (context, index) {
                      return FlagAndCountryName(
                        onTap: () {
                          localeCubit
                              .setLanguageCode(state.languageCodes[index]);
                          setState(() {
                            indexSelect = index;
                          });
                          printRed(index.toString());
                          printRed(indexSelect.toString());
                        },
                        isSelected: indexSelect == index,
                        countryName: state.countryNames[index],
                        pathImage: state.pathCountryFlags[index],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                  );
                },
              ),
            ),
            // const Expanded(child: SizedBox())
            Button(
              onTap: () async {
                await localeCubit.successSetLanguage();
                Navigator.pop(context);
              },
              text: AppLocalizations.of(context)!.ok,
              colorBt: theme.colorScheme.primary,
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
