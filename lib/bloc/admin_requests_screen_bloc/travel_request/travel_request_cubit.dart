import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'travel_request_state.dart';

class TravelRequestCubit extends Cubit<TravelRequestState> {
  TravelRequestCubit() : super(TravelRequestInitial());
}
