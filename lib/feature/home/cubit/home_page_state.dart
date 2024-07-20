import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'home_page_state.g.dart';

enum HomePageStatus { init, loading, success, error }

@CopyWith()
class HomePageState extends Equatable {
  const HomePageState(
      {this.isConnectNetwork = false,
      this.status = HomePageStatus.init,
      this.isLoadingHome = true,
      this.currentIndexPage = 0,
      this.isNotification = false
      });
  final bool isConnectNetwork;
  final HomePageStatus status;
  final bool isLoadingHome;
  final bool isNotification;
  final int currentIndexPage;

  @override
  List<Object> get props => [isConnectNetwork, status, isLoadingHome, isNotification, currentIndexPage];
}
