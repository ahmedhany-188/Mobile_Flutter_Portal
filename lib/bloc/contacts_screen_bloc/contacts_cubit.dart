import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../data/data_providers/general_dio/general_dio.dart';
import '../../data/models/contacts_related_models/contacts_data_from_api.dart';

part 'contacts_states.dart';

class ContactsCubit extends Cubit<ContactCubitStates> with HydratedMixin{
  ContactsCubit() : super(const ContactCubitStates()) {
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (state.contactStates == ContactsEnumStates.failed) {
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          try {
            getContacts();
          } catch (e) {
            emit(state.copyWith(
              contactStates: ContactsEnumStates.failed,
            ));
          }
        } else if (connectivityResult == ConnectivityResult.none) {
          emit(state.copyWith(
            contactStates: ContactsEnumStates.failed,
          ));
        }
      }
    });
  }
  final Connectivity connectivity = Connectivity();

  static ContactsCubit get(context) => BlocProvider.of(context);

  List<ContactsDataFromApi> contacts = [];

  void getContacts() {
    // emit(state.copyWith(
    //   contactStates: ContactsEnumStates.initial,
    // ));
    GeneralDio.getContactListData().then((value) {
      if (value.data != null) {
        contacts = List<ContactsDataFromApi>.from(
            value.data.map((model) => ContactsDataFromApi.fromJson(model)));

        var apiMap = <String>{};

        contacts.where((element) => apiMap.add(element.companyName!)).toList();
        List<String> companiesFilters = apiMap.toList();
        apiMap.clear();

        contacts.where((element) => apiMap.add(element.projectName!)).toList();
        List<String> projectFilters = apiMap.toList();
        apiMap.clear();

        contacts
            .where((element) => apiMap.add(element.mainDepartment!))
            .toList();
        List<String> departmentFilters = apiMap.toList();
        apiMap.clear();

        contacts.where((element) => apiMap.add(element.titleName!)).toList();
        List<String> titleFilters = apiMap.toList();
        apiMap.clear();

        emit(state.copyWith(
            contactStates: ContactsEnumStates.success,
            listContacts: contacts,
            companiesFilter: companiesFilters,
            projectsFilter: projectFilters,
            departmentFilter: departmentFilters,
            titleFilter: titleFilters));
      }
    }).catchError((error) {
      // emit(state.copyWith(contactStates: ContactsEnumStates.failed));
    });
  }

  void getAllContacts(){
    emit(state.copyWith(
      contactStates: ContactsEnumStates.success,
      listContacts: contacts,
    ));
  }

  void updateContacts(List<ContactsDataFromApi> updatedList) {
    emit(state.copyWith(
      contactStates: ContactsEnumStates.filtered,
      tempList: updatedList,
    ));
  }

  @override
  ContactCubitStates? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    // throw UnimplementedError();
    return ContactCubitStates.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ContactCubitStates state) {
    // TODO: implement toJson
    if (state.contactStates == ContactsEnumStates.success && state.listContacts.isNotEmpty) {
      return state.toMap();
    } else {
      return null;
    }
    return state.toMap();
    // throw UnimplementedError();

  }
}
