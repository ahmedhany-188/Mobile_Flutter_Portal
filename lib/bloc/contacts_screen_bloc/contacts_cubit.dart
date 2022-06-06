import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/data_providers/general_dio/general_dio.dart';
import '../../data/models/contacts_related_models/contacts_data_from_api.dart';

part 'contacts_states.dart';

class ContactsCubit extends Cubit<ContactsStates> {
  ContactsCubit() : super(BlocInitialState());

  static ContactsCubit get(context) => BlocProvider.of(context);

  List<ContactsDataFromApi> contacts = [];

  void getContacts() {
    emit(BlocGetContactsLoadingState());

    GeneralDio.getContactListData().then((value) {
      if (value.data != null) {
        contacts = List<ContactsDataFromApi>.from(
            value.data.map((model) => ContactsDataFromApi.fromJson(model)));

        emit(BlocGetContactsSuccessState(contacts));
      }
    }).catchError((error) {
      print(error.toString());
      emit(BlocGetContactsErrorState(error.toString()));
    });
  }
}
