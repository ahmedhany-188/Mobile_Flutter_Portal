import 'package:flutter_bloc/flutter_bloc.dart';
import 'contacts_bloc_states.dart';

class AppCubit extends Cubit<BlocStates> {
  AppCubit() : super(BlocInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<dynamic> contacts = [];

  void getContacts() {
    emit(BlocGetContactsLoadingState());

    DioHelper.getContactListData().then((value) {
      contacts = value.data;
      emit(BlocGetContactsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(BlocGetContactsErrorState(error.toString()));
    });
  }
}
