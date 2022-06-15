part of 'app_upgrader_cubit.dart';

class AppUpgraderInitial extends Equatable {
  const AppUpgraderInitial({this.appUpgrader = AppUpgrader.initial,this.upgrader = Upgrader.empty});
  final AppUpgrader appUpgrader;
  final Upgrader upgrader;
  AppUpgraderInitial copyWith({
    AppUpgrader? appUpgrader,
    Upgrader? upgrader,
  }) {
    return AppUpgraderInitial(
      appUpgrader: appUpgrader ?? this.appUpgrader,
      upgrader: upgrader ?? this.upgrader,
    );
  }

  @override
  List<Object> get props => [appUpgrader];
}
enum AppUpgrader{
  initial,
  failure,
  needUpdate,
  noNeedUpdate
}

