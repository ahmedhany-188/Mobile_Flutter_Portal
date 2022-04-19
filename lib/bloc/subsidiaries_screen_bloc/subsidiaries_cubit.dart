import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import '../../data/data_providers/general_dio/general_dio.dart';

part 'subsidiaries_state.dart';

class SubsidiariesCubit extends Cubit<SubsidiariesState> {
  SubsidiariesCubit() : super(SubsidiariesInitial());

  static SubsidiariesCubit get(context) => BlocProvider.of(context);


  Map<String,dynamic> subsidiariesList = {};

  void getSubsidiaries() {
    emit(SubsidiariesLoadingState());

    GeneralDio.subsidiariesData().then((value) {
      subsidiariesList = value.data;

      emit(SubsidiariesSuccessState(subsidiariesList));
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(SubsidiariesErrorState(error.toString()));
    });
  }


}
