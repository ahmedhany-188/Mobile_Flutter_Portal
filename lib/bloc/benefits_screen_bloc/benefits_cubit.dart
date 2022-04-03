import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data_providers/benefits_provider/benefits_provider.dart';

part 'benefits_state.dart';

class BenefitsCubit extends Cubit<BenefitsState> {
  BenefitsCubit() : super(BenefitsInitial());

  static BenefitsCubit get(context) => BlocProvider.of(context);

  List<dynamic> benefits = [];

  void getBenefits() {
    emit(BenefitsLoadingState());

    BenefitsProvider.getBenefitsData().then((value) {
      benefits = value.data;
      emit(BenefitsSuccessState(benefits));
    }).catchError((error) {
      print(error.toString());
      emit(BenefitsErrorState(error.toString()));
    });
  }

}
