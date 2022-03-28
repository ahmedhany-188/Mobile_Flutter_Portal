import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/data_providers/dio_provider.dart';
import 'contacts_bloc_states.dart';

class ContactsCubit extends Cubit<ContactsBlocStates> {
  ContactsCubit() : super(BlocInitialState());

  static ContactsCubit get(context) => BlocProvider.of(context);

  List<dynamic> contacts = [];

  void getContacts() {
    emit(BlocGetContactsLoadingState());

    DioProvider.getContactListData().then((value) {
      contacts = value.data;
      emit(BlocGetContactsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(BlocGetContactsErrorState(error.toString()));
    });
  }
}
