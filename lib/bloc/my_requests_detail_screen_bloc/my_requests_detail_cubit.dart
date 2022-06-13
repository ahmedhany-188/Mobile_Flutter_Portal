
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/data_providers/it_request_data_provider/itemail_anduseraccount_data_provider.dart';
import 'package:hassanallamportalflutter/data/data_providers/my_requests_data_provider/my_requests_detail_data_provider.dart';
import 'package:meta/meta.dart';

part 'my_requests_detail_state.dart';

class MyRequestsDetailCubit extends Cubit<MyRequestsDetailState> {
  MyRequestsDetailCubit() : super(MyRequestsDetailInitial());

  final Connectivity connectivity = Connectivity();

  static MyRequestsDetailCubit get(context) => BlocProvider.of(context);

  void getVacationRequestData(String hrCode, int reqNumber) async {
    emit(BlocGetTheDataLoadingState());
    try {
      var connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        MyRequestsDetailDataProvider().getVacation(hrCode, reqNumber)
            .then((value) {
          emit(BlocGetTheVacationDataSuccesState(value.body));
        }).catchError((onError) {
          emit(BlocGetTheDataErrorState(onError));
        });
      } else {
        emit(BlocGetTheDataErrorState("No internet connection"));
      }
    } catch (e) {
      emit(BlocGetTheDataErrorState(e.toString()));
    }
  }

  void getPermissionRequestData(String hrCode, int reqNumber) async {
    emit(BlocGetTheDataLoadingState());
    try {
      var connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        MyRequestsDetailDataProvider().getPermission(hrCode, reqNumber)
            .then((value) {
          emit(BlocGetThePermissionDataSuccesState(value.body));
        }).catchError((onError) {
          emit(BlocGetTheDataErrorState(onError));
        });
      } else {
        emit(BlocGetTheDataErrorState("No internet connection"));
      }
    } catch (e) {
      emit(BlocGetTheDataErrorState(e.toString()));
    }
  }

  void getBusinessMissionData(String hrCode, int reqNumber) async {
    emit(BlocGetTheDataLoadingState());
    try {
      var connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        MyRequestsDetailDataProvider().getBusinessMission(hrCode, reqNumber)
            .then((value) {
          emit(BlocGetTheBusinessMissionDataSuccesState(value.body));
        }).catchError((onError) {
          emit(BlocGetTheDataErrorState(onError));
        });
      } else {
        emit(BlocGetTheDataErrorState("No internet connection"));
      }
    } catch (e) {
      emit(BlocGetTheDataErrorState(e.toString()));
    }
  }

  void getEmbassyLetterData(String hrCode, int reqNumber) async {
    emit(BlocGetTheDataLoadingState());
    try {
      var connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        MyRequestsDetailDataProvider().getEmbassy(hrCode, reqNumber)
            .then((value) {
          emit(BlocGetTheEmbassyLetterDataSuccesState(value.body));
        }).catchError((onError) {
          emit(BlocGetTheDataErrorState(onError));
        });
      } else {
        emit(BlocGetTheDataErrorState("No internet connection"));
      }
    } catch (e) {
      emit(BlocGetTheDataErrorState(e.toString()));
    }
  }

  void getEmailAccountData(String hrCode, int reqNumber) async {
    emit(BlocGetTheDataLoadingState());
    try {
      var connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        MyRequestsDetailDataProvider().getAccount(hrCode, reqNumber)
            .then((value) {
          emit(BlocGetTheEmailAccountDataSuccesState(value.body));
        }).catchError((onError) {
          emit(BlocGetTheDataErrorState(onError));
        });
      } else {
        emit(BlocGetTheDataErrorState("No internet connection"));
      }
    } catch (e) {
      emit(BlocGetTheDataErrorState(e.toString()));
    }
  }

  void getBusinessCardData(String hrCode, int reqNumber) async {
    emit(BlocGetTheDataLoadingState());
    try {
      var connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        MyRequestsDetailDataProvider().getGetBusinessCard(hrCode, reqNumber)
            .then((value) {
          emit(BlocGetTheBusinessCardDataSuccesState(value.body));
        }).catchError((onError) {
          emit(BlocGetTheDataErrorState(onError));
        });
      } else {
        emit(BlocGetTheDataErrorState("No internet connection"));
      }
    } catch (e) {
      emit(BlocGetTheDataErrorState(e.toString()));
    }
  }

  void getAccessRightITData(String hrCode, int reqNumber) async {
    emit(BlocGetTheDataLoadingState());
    try {
      var connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        MyRequestsDetailDataProvider().getGetAccessRight(hrCode, reqNumber)
            .then((value) {
          emit(BlocGetTheAccessRightDataSuccesState(value.body));
        }).catchError((onError) {
          emit(BlocGetTheDataErrorState(onError));
        });
      } else {
        emit(BlocGetTheDataErrorState("No internet connection"));
      }
    } catch (e) {
      emit(BlocGetTheDataErrorState(e.toString()));
    }
  }

}



