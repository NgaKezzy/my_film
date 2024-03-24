import 'package:app/config/key_app.dart';
import 'package:bloc/bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../config/print_color.dart';
import 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(const LocaleState());

  Future<void> initLanguage() async {
    emit(state.copyWith(status: LocaleStatus.loading));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String code = prefs.getString(KeyApp.LANGUAGE_CODE) ?? 'en';

    emit(state.copyWith(
        languageCode: code,
        languageCodes: codes,
        countryNames: newCountryNames,
        pathCountryFlags: newPathCountryFlag,
        status: LocaleStatus.success));
  }

  Future<void> setLanguageCode(String code) async {
    emit(state.copyWith(status: LocaleStatus.loading));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(KeyApp.LANGUAGE_CODE, code);
    emit(state.copyWith(languageCode: code));
    printYellow('Language: $code');
  }

  Future<void> successSetLanguage() async {
    emit(state.copyWith(status: LocaleStatus.loading));
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool(KeyApp.IS_SET_LANGUAGE, true);
    emit(state.copyWith(isSelectLanguage: true, status: LocaleStatus.success));
  }

  Future<void> checkIsSelectedLanguage() async {
    emit(state.copyWith(status: LocaleStatus.loading));
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? isSelected = prefs.getBool(KeyApp.IS_SET_LANGUAGE);
    emit(state.copyWith(
        isSelectLanguage: isSelected, status: LocaleStatus.success));
  }
}
