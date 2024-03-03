import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'home_page_state.g.dart';

enum HomePageStatus { init, loading, success, error }

@CopyWith()
class HomePageState extends Equatable {
  const HomePageState(
      {this.isConnectNetwork = false, this.status = HomePageStatus.init});
  final bool isConnectNetwork;
  final HomePageStatus status;

  @override
  List<Object> get props => [isConnectNetwork, status];
}
