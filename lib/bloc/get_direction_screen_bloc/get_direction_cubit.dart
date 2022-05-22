import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/data_providers/general_dio/general_dio.dart';

part 'get_direction_state.dart';

class GetDirectionCubit extends Cubit<GetDirectionState> {
  GetDirectionCubit() : super(GetDirectionInitial()){
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        try {

          getDirection();

        } catch (e) {
          emit(GetDirectionErrorState(e.toString()));
        }
      } else if (connectivityResult == ConnectivityResult.none) {
        emit(GetDirectionErrorState("No internet Connection"));
      }
    });
  }
  static const GOOGLE_API_KEY = 'AIzaSyAbkday4kMNt8-gG5Y-j2CDRKmpZXzkqeA';

  static GetDirectionCubit get(context) => BlocProvider.of(context);
  final Connectivity connectivity = Connectivity();

  List<dynamic> getDirectionList = [];


  void getDirection() {
    emit(GetDirectionLoadingState());
    // connectivity.onConnectivityChanged.listen((connectivityResult) async {
    //   if (connectivityResult == ConnectivityResult.wifi ||
    //       connectivityResult == ConnectivityResult.mobile) {
    //     try {
          GeneralDio.getGetDirectionData().then((value) {
            getDirectionList = value.data
                .where((element) =>
                    element['latitude'].toString().contains('.') &&
                    element['longitude'].toString().contains('.'))
                .toList();

            emit(GetDirectionSuccessState(getDirectionList));
          }).catchError((error) {
            emit(GetDirectionErrorState(error.toString()));
          });
        // } catch (e) {
        //   emit(GetDirectionErrorState(e.toString()));
        // }
    //   } else if (connectivityResult == ConnectivityResult.none) {
    //     emit(GetDirectionErrorState("No internet Connection"));
    //   }
    // });
  }
}
