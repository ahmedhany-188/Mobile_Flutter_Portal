import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/data_providers/general_dio/general_dio.dart';

part 'contacts_states.dart';

class ContactsCubit extends Cubit<ContactsStates> {
  ContactsCubit() : super(BlocInitialState());

  static ContactsCubit get(context) => BlocProvider.of(context);

  List<dynamic> contacts = [];

  void getContacts() {
    emit(BlocGetContactsLoadingState());

    GeneralDio.getContactListData().then((value) {
      contacts = value.data;
      emit(BlocGetContactsSuccessState(contacts));
    }).catchError((error) {
      print(error.toString());
      emit(BlocGetContactsErrorState(error.toString()));
    });
  }
}
