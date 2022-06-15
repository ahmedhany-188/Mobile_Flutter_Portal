import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/models/my_requests_model/my_requests_model_form.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';
import 'package:meta/meta.dart';

part 'my_requests_state.dart';

class MyRequestsCubit extends Cubit<MyRequestsState> {
  MyRequestsCubit(this.requestRepository) : super(MyRequestsInitial());

  static MyRequestsCubit get(context) =>BlocProvider.of(context);
  List<MyRequestsModelData> myRequests=[];

  final Connectivity connectivity = Connectivity();

  final RequestRepository requestRepository;

  void getRequests(userHRcode) async {

    emit(BlocGetMyRequestsLoadingState());
    try {
      var connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {

        requestRepository.getMyrequestsData(userHRCode:userHRcode)
            .then((value)async{

          myRequests = await jsonDecode(value.body);
          print("-----oo-----"+myRequests.toString());
          print("-----o8-----"+value.body);

          // myRequests = value.body;

          emit(BlocGetMyRequestsSuccessState(myRequests));
        }).catchError((error){
          print(error.toString()+"0000000000");
          emit(BlocGetMyRequestsErrorState(error.toString()));
        });

        // final MyRequestsResponse = await requestRepository.getMyrequestsData(userHRCode:userHRcode);
        // if (MyRequestsResponse!=null) {
        //   myRequests=MyRequestsResponse as List<MyRequestsModelData>;
        //   myRequests= List<MyRequestsModelData>.from(
        //       MyRequestsResponse((model) => MyRequestsModelData.fromJson(model)));
        //   print("---0.-+"+myRequests.toString());
        //   emit(BlocGetMyRequestsSuccessState(myRequests));
        // }else{
        //   emit(BlocGetMyRequestsErrorState(MyRequestsResponse.result!));
        // }
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
