part of 'contacts_filters_cubit.dart';

class ContactsFiltersInitial extends Equatable {
  final List<ContactsDataFromApi> listContacts;
  final String searchString;
  final bool isFiltered;
  final List<String> companiesFilter;
  final List<String> projectsFilter;
  final List<String> departmentFilter;
  final List<String> titleFilter;
  final List<String> chosenCompaniesFilter;
  final List<String> chosenProjectsFilter;
  final List<String> chosenDepartmentFilter;
  final List<String> chosenTitleFilter;

  const ContactsFiltersInitial({
    this.listContacts = const <ContactsDataFromApi>[],
    this.searchString = '',
    this.isFiltered = false,
    this.companiesFilter = const [],
    this.projectsFilter = const [],
    this.departmentFilter = const [],
    this.titleFilter = const [],
    this.chosenCompaniesFilter = const [],
    this.chosenProjectsFilter = const [],
    this.chosenDepartmentFilter = const [],
    this.chosenTitleFilter = const [],
  });

  ContactsFiltersInitial copyWith({
    List<ContactsDataFromApi>? listContacts,
    String? searchString,
    bool? isFiltered,
    List<String>? companiesFilter,
    List<String>? projectsFilter,
    List<String>? departmentFilter,
    List<String>? titleFilter,
    List<String>? chosenCompaniesFilter,
    List<String>? chosenProjectsFilter,
    List<String>? chosenDepartmentFilter,
    List<String>? chosenTitleFilter,
  }) {
    return ContactsFiltersInitial(
      listContacts: listContacts ?? this.listContacts,
      searchString: searchString ?? this.searchString,
      isFiltered: isFiltered ?? this.isFiltered,
      companiesFilter: companiesFilter ?? this.companiesFilter,
      projectsFilter: projectsFilter ?? this.projectsFilter,
      departmentFilter: departmentFilter ?? this.departmentFilter,
      titleFilter: titleFilter ?? this.titleFilter,
      chosenCompaniesFilter:
          chosenCompaniesFilter ?? this.chosenCompaniesFilter,
      chosenProjectsFilter: chosenProjectsFilter ?? this.chosenProjectsFilter,
      chosenDepartmentFilter:
          chosenDepartmentFilter ?? this.chosenDepartmentFilter,
      chosenTitleFilter: chosenTitleFilter ?? this.chosenTitleFilter,
    );
  }

  @override
  List<Object?> get props => [
        listContacts,
        searchString,
        isFiltered,
        companiesFilter,
        projectsFilter,
        departmentFilter,
        titleFilter,
        chosenCompaniesFilter,
        chosenProjectsFilter,
        chosenDepartmentFilter,
        chosenTitleFilter,
      ];
}
