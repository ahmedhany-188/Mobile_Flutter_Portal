import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/models/my_requests_model/my_requests_model_form.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';

part 'my_requests_state.dart';

class MyRequestsCubit extends Cubit<MyRequestsState> {
  MyRequestsCubit(this.requestRepository) : super(MyRequestsInitial());

  static MyRequestsCubit get(context) =>BlocProvider.of(context);


  final Connectivity connectivity = Connectivity();

  final RequestRepository requestRepository;

  void getRequests() async {

    emit(BlocGetMyRequestsLoadingState());
    try {
      var connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {

        requestRepository.getMyRequestsData()
            .then((value)async{
          emit(BlocGetMyRequestsSuccessState(value));
        }).catchError((error){
          emit(BlocGetMyRequestsErrorState(error.toString()));
        });
      }else{
        emit(BlocGetMyRequestsErrorState("No internet connection"));
      }
    }catch(e){
      emit(BlocGetMyRequestsErrorState(e.toString()));
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    // connectivityStreamSubscription?.cancel();
    return super.close();
  }

}
