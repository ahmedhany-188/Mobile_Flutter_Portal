import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hassanallamportalflutter/data/models/upgrader_model/upgrader.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

import '../../data/repositories/upgrader_repository.dart';

part 'app_upgrader_state.dart';

class AppUpgraderCubit extends Cubit<AppUpgraderInitial> {
  AppUpgraderCubit(this._upgraderRepository) : super(const AppUpgraderInitial());
  final UpgraderRepository _upgraderRepository;
  Future<void> getUpgradeFromServer(BuildContext context) async {

    emit(state.copyWith(appUpgrader: AppUpgrader.initial));
    try{
      final upgraderResponse = await _upgraderRepository.getUpgradingData();
      // final version = upgraderResponse.android?.version;
      if(await checkVersionNumber(upgraderResponse)){
        print("noNeedUpdate");
        emit(state.copyWith(appUpgrader: AppUpgrader.noNeedUpdate));
      }else{
        print("needUpdate");
        emit(state.copyWith(appUpgrader: AppUpgrader.needUpdate,upgrader: upgraderResponse
        ));
      }
    } catch(e){
      print("update Failure");
      emit(state.copyWith(appUpgrader: AppUpgrader.failure));
    }

  }

  onLaterAction(){
    emit(state.copyWith(appUpgrader: AppUpgrader.failure));
  }
  onUpdateAction(){
    try {
      if(Platform.isAndroid){
        launchUrl(
          Uri.parse(state.upgrader.android?.link ?? ""),
          mode: LaunchMode.externalApplication,
        );
      }else{
        launchUrl(
          Uri.parse(state.upgrader.ios?.link ?? ""),
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e, s) {
      emit(state.copyWith(appUpgrader: AppUpgrader.failure));
      print(s);
    }
  }

  Future<bool> checkVersionNumber(Upgrader upgrader) async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;
    String code = packageInfo.buildNumber;
    int currentVersionNumber = getExtendedVersionNumber(version);
    int serverVersionNumber;

    if (Platform.isAndroid) {
      serverVersionNumber = getExtendedVersionNumber(upgrader.android?.version ?? "");
    } else{
      serverVersionNumber = getExtendedVersionNumber(upgrader.ios?.version ?? "");
    }


    if(currentVersionNumber < serverVersionNumber){
      return false;
    }else{
      return true;
    }
  }
  int getExtendedVersionNumber(String version) {
    List versionCells = version.split('.');
    versionCells = versionCells.map((i) => int.parse(i)).toList();
    return versionCells[0] * 100000 + versionCells[1] * 1000 + versionCells[2];
  }
}
