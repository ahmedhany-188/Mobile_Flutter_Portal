import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hassanallamportalflutter/data/models/weather.dart';
import 'package:hassanallamportalflutter/data/repositories/weather_repository.dart';
import 'dart:async';
import 'package:meta/meta.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final _weatherRepository = WeatherRepository();
  final Connectivity connectivity = Connectivity();
  // StreamSubscription? connectivityStreamSubscription;
  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) async {
      // TODO: implement event handle

       monitorInternetConnection();

      // if (event is WeatherRequest) {
      //   emit(WeatherLoadInProgress());
      //   ConnectivityResult connection = await Connectivity().checkConnectivity();
      //   Connectivity().onConnectivityChanged.listen((event) async{
      //     try {
      //       if (connection != ConnectivityResult.none){
      //         final weatherResponse =
      //         await _weatherRepository.getWeather();
      //         emit(WeatherLoadSuccess(weather: weatherResponse));
      //       }else{
      //         emit(WeatherLoadFailure(error: "No Internet Connection"));
      //       }
      //
      //     } catch (e) {
      //       print(e);
      //       emit(WeatherLoadFailure(error: e.toString()));
      //     }
      //   });

      // }
    });


    // @override
    // Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    //   if (event is WeatherRequest) {
    //     yield WeatherLoadInProgress();
    //     try {
    //       final weatherResponse =
    //       await _weatherRepository.getWeather();
    //       yield WeatherLoadSuccess(weather: weatherResponse);
    //     } catch (e) {
    //       print(e);
    //       yield WeatherLoadFailure(error: e.toString());
    //     }
    //   }
    // }
  }

  void monitorInternetConnection() {
    // return connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) async {
          if (connectivityResult == ConnectivityResult.wifi ||
              connectivityResult == ConnectivityResult.mobile) {
            // emitInternetConnected(ConnectionType.wifi);
            // } else if () {
            //   emitInternetConnected(ConnectionType.mobile);
            try {
              final weatherResponse =
              await _weatherRepository.getWeather();
              emit(WeatherLoadSuccess(weather: weatherResponse));
            } catch (e) {
              print(e);
              emit(WeatherLoadFailure(error: e.toString()));
            }
          } else if (connectivityResult == ConnectivityResult.none) {
            WeatherLoadFailure(error: "No internet Connection");
          }
        });
  }

  @override
  Future<void> close() {
    // TODO: implement close
    // connectivityStreamSubscription?.cancel();
    return super.close();
  }
}
