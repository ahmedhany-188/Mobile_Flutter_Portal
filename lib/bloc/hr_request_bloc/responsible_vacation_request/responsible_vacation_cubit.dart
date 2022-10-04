import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hassanallamportalflutter/data/data_providers/general_dio/general_dio.dart';
import 'package:hassanallamportalflutter/data/models/contacts_related_models/contacts_data_from_api.dart';

part 'responsible_vacation_state.dart';

class ResponsibleVacationCubit extends Cubit<ResponsibleVacationInitial> {
  ResponsibleVacationCubit(this._generalDio) : super(const ResponsibleVacationInitial.loading());
  GeneralDio _generalDio;
  Future<void> fetchList() async {
    _generalDio.getContactListData().then((value) async {
      final contacts = List<ContactsDataFromApi>.from(
          value.data.map((model) => ContactsDataFromApi.fromJson(model)));
      emit(ResponsibleVacationInitial.success(contacts));
    }).catchError((error) {
      print(error.toString());
      emit(const ResponsibleVacationInitial.failure());
    });
  }
  Future<void> clearAll() async {
    emit(ResponsibleVacationInitial.success(state.items));
  }
  Future<void> searchForContacts(String value) async {
    try{
      List <ContactsDataFromApi> _searchList = [];
      List<ContactsDataFromApi> contacts = state.items;
        for (int i = 0; i < contacts.length; i++) {
          ContactsDataFromApi contact = contacts[i];
          if(contact.name != null){
            if (contact.name!.toLowerCase().contains(value.toLowerCase())) {
              print(contact.name );
              _searchList.add(contact);
            }
          }
        }
      emit(ResponsibleVacationInitial.successSearching(_searchList,state.items));
    }catch(_){
      emit(const ResponsibleVacationInitial.failure());
    }
  }

  Future<List<ContactsDataFromApi>> fetchItems() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return List.of(_generateItemsList(10));
  }

  List<ContactsDataFromApi> _generateItemsList(int length) {
    return List.generate(
      length,
          (index) => ContactsDataFromApi(email: "asd",userHrCode: "dsad",name: "$index"),
    );
  }
  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }


}
