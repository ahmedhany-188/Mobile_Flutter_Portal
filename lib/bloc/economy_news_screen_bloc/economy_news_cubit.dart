import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/data_providers/economy_news_data_provider/economy_news_data_provider.dart';
import 'package:meta/meta.dart';
part 'economy_news_state.dart';

class EconomyNewsCubit extends Cubit<EconomyNewsState> {
  EconomyNewsCubit() : super(EconomyNewsInitial());

  static EconomyNewsCubit get(context) => BlocProvider.of(context);
  String economyNews ="";

  void getEconomyNews() async {
    emit(BlocGetTheEconomyNewsLoadingState());
    EconomyNewsDataProvider().getEconomyNews().then((value){
      economyNews = value.body;
      print("----------"+economyNews);
      emit(BlocGetTheEconomyNewsSuccesState(economyNews));

    }).catchError((error){
      print(error.toString());
      emit(BlocGetTheEconomyNewsErrorState(error.toString()));
    });
  }
  @override
  Future<void> close() {
    // TODO: implement close
    // connectivityStreamSubscription?.cancel();
    return super.close();
  }

}
