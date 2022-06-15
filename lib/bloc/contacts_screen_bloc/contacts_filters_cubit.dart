import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/contacts_related_models/contacts_data_from_api.dart';

part 'contacts_filters_state.dart';

class ContactsFiltersCubit extends Cubit<ContactsFiltersInitial> {
  ContactsFiltersCubit(this.contactsList)
      : super(const ContactsFiltersInitial());
  List<ContactsDataFromApi> contactsList;

  static ContactsFiltersCubit get(context) => BlocProvider.of(context);

  getMainContactsList(List<ContactsDataFromApi> contactsList) {
    emit(state.copyWith(listContacts: contactsList));
  }

  writenTextSearch(String searchString) {
    emit(state.copyWith(searchString: searchString));
    checkAllFilters();
  }

  updateFilters() {
    var apiMap = <String>{};

    state.listContacts
        .where((element) => apiMap.add(element.companyName!))
        .toList();
    List<String> companiesFilters = apiMap.toList();
    apiMap.clear();

    state.listContacts
        .where((element) => apiMap.add(element.projectName!))
        .toList();
    List<String> projectFilters = apiMap.toList();
    apiMap.clear();

    state.listContacts
        .where((element) => apiMap.add(element.mainDepartment!))
        .toList();
    List<String> departmentFilters = apiMap.toList();
    apiMap.clear();

    state.listContacts
        .where((element) => apiMap.add(element.titleName!))
        .toList();
    List<String> titleFilters = apiMap.toList();
    apiMap.clear();

    emit(state.copyWith(
        companiesFilter: companiesFilters,
        projectsFilter: projectFilters,
        departmentFilter: departmentFilters,
        titleFilter: titleFilters));
  }

  checkAllFilters() {
    List<ContactsDataFromApi> contactSearchResultsList = [];
    if (state.chosenCompaniesFilter.isEmpty &&
        state.chosenProjectsFilter.isEmpty &&
        state.chosenDepartmentFilter.isEmpty &&
        state.chosenTitleFilter.isEmpty &&
        state.searchString.isEmpty) {
      onClearData();
    } else {
      var splitQuery = state.searchString.toLowerCase().trim().split(' ');
      contactSearchResultsList = contactsList.where((contactElement) {
        return ((state.searchString.isNotEmpty)
                ? splitQuery.every((singleSplitElement) => contactElement.name
                    .toString()
                    .toLowerCase()
                    .trim()
                    .contains(singleSplitElement))
                : true) &&
            ((state.chosenCompaniesFilter.isNotEmpty)
                ? state.chosenCompaniesFilter
                    .contains(contactElement.companyName!)
                : true) &&
            ((state.chosenProjectsFilter.isNotEmpty)
                ? state.chosenProjectsFilter
                    .contains(contactElement.projectName!)
                : true) &&
            ((state.chosenDepartmentFilter.isNotEmpty)
                ? state.chosenDepartmentFilter
                    .contains(contactElement.mainDepartment!)
                : true) &&
            ((state.chosenTitleFilter.isNotEmpty)
                ? state.chosenTitleFilter.contains(contactElement.titleName!)
                : true);
      }).toList();
      emit(state.copyWith(
          listContacts: contactSearchResultsList, isFiltered: true));
    }
  }

  chosenCompaniesOptions(List<String> chosenFilter) {
    emit(state.copyWith(chosenCompaniesFilter: chosenFilter));
  }

  chosenProjectsOptions(List<String> chosenFilter) {
    emit(state.copyWith(chosenProjectsFilter: chosenFilter));
  }

  chosenDepartmentsOptions(List<String> chosenFilter) {
    emit(state.copyWith(chosenDepartmentFilter: chosenFilter));
  }

  chosenTitlesOptions(List<String> chosenFilter) {
    emit(state.copyWith(chosenTitleFilter: chosenFilter));
  }

  onClearData() {
    emit(state.copyWith(
      listContacts: getMainContactsList(contactsList),
      isFiltered: false,
      titleFilter: [],
      departmentFilter: [],
      projectsFilter: [],
      companiesFilter: [],
      searchString: '',
      chosenTitleFilter: [],
      chosenProjectsFilter: [],
      chosenCompaniesFilter: [],
      chosenDepartmentFilter: [],
    ));
  }

  onClearDialog() {
    emit(state.copyWith(
      isFiltered: (state.searchString.isEmpty) ? false : true,
      chosenTitleFilter: [],
      chosenProjectsFilter: [],
      chosenCompaniesFilter: [],
      chosenDepartmentFilter: [],
    ));
  }
}
