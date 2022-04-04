import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/data_providers/get_direction_provider/get_direction_provider.dart';

part 'get_direction_state.dart';

class GetDirectionCubit extends Cubit<GetDirectionState> {
  GetDirectionCubit() : super(GetDirectionInitial());
  static const GOOGLE_API_KEY = 'AIzaSyAbkday4kMNt8-gG5Y-j2CDRKmpZXzkqeA';

  static GetDirectionCubit get(context) => BlocProvider.of(context);


  List<dynamic> getDirectionList = [];

  void getDirection() {
    emit(GetDirectionLoadingState());

    GetDirectionProvider.getGetDirectionData().then((value) {
      getDirectionList = value.data
          .where((element) =>
              element['latitude'].toString().contains('.') &&
              element['longitude'].toString().contains('.'))
          .toList();

      emit(GetDirectionSuccessState(getDirectionList));
    }).catchError((error) {
      print(error.toString());
      emit(GetDirectionErrorState(error.toString()));
    });
  }
}
