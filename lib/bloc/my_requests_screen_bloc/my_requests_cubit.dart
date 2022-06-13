import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/data_providers/my_requests_data_provider/my_requests_data_provider.dart';
import 'package:meta/meta.dart';

part 'my_requests_state.dart';

class MyRequestsCubit extends Cubit<MyRequestsState> {
  MyRequestsCubit() : super(MyRequestsInitial());

  static MyRequestsCubit get(context) =>BlocProvider.of(context);
  String myRequests ="";

  final Connectivity connectivity = Connectivity();

  void getRequests(userHRcode) async {

    emit(BlocGetMyRequestsLoadingState());
    try {
      var connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        MyRequestsDataProvider().getMyRequestsList(userHRcode).then((value){
          myRequests = value.body;
          emit(BlocGetMyRequestsSuccesState(myRequests));
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
