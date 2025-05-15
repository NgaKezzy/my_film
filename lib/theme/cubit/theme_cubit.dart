import 'package:app/theme/cubit/theme_state.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/key_app.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState());
  Future<void> toggedTheme() async {

  // hàm này để gán lại giá trị, nếu sáng gán thành tối, tối gán thành sáng
    SharedPreferences prefs = await SharedPreferences.getInstance();

    emit(state.copyWith(status: ThemeStatus.loading));
    emit(state.copyWith(isDark: !state.isDark, status: ThemeStatus.success));
    prefs.setBool(KeyApp.IS_DARK, state.isDark);
  }

  Future<void> initTheme() async {

    // hàm này để khi bắt đầu mở app nên sẽ lấy giá trị dưới bộ nhớ máy xem đang ở chế độ sáng hay tối
    SharedPreferences prefs = await SharedPreferences.getInstance();
    emit(state.copyWith(status: ThemeStatus.loading));
    bool value = prefs.getBool(KeyApp.IS_DARK) ?? true;
    emit(state.copyWith(isDark: value, status: ThemeStatus.success));
  }
}
