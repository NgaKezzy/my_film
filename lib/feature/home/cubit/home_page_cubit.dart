import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../config/print_color.dart';
import 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(const HomePageState());

  Future<void> checkNetwork() async {
    emit(state.copyWith(status: HomePageStatus.init));
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      printRed('No connect network');
      emit(state.copyWith(
          isConnectNetwork: false, status: HomePageStatus.success));
    } else {
      printRed('Connect network');
      emit(state.copyWith(
          isConnectNetwork: true, status: HomePageStatus.success));
    }
  }

  Future<void> loadingHomeIsFalse() async {
    emit(state.copyWith(status: HomePageStatus.init));

    emit(state.copyWith(isLoadingHome: false, status: HomePageStatus.success));
  }
}
