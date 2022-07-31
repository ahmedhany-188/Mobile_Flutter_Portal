part of 'contacts_cubit.dart';

abstract class ContactsStates extends Equatable {}

enum ContactsEnumStates { initial, success, filtered, failed }

class ContactCubitStates extends Equatable {
  final ContactsEnumStates contactStates;
  final List<ContactsDataFromApi> listContacts;
  final List<ContactsDataFromApi> tempList;
  final List<String> companiesFilter;
  final List<String> projectsFilter;
  final List<String> departmentFilter;
  final List<String> titleFilter;
  const ContactCubitStates({
    this.contactStates = ContactsEnumStates.initial,
    this.listContacts = const <ContactsDataFromApi>[],
    this.tempList = const <ContactsDataFromApi>[],
    this.companiesFilter = const [],
    this.projectsFilter = const [],
    this.departmentFilter = const [],
    this.titleFilter = const [],
  });



  ContactCubitStates copyWith({
    ContactsEnumStates? contactStates,
    List<ContactsDataFromApi>? listContacts,
    List<ContactsDataFromApi>? tempList,
    List<String>? companiesFilter,
    List<String>? projectsFilter,
    List<String>? departmentFilter,
    List<String>? titleFilter,
  }) {
    return ContactCubitStates(
      contactStates: contactStates ?? this.contactStates,
      listContacts: listContacts ?? this.listContacts,
      tempList: tempList ?? this.tempList,
      companiesFilter: companiesFilter ?? this.companiesFilter,
      projectsFilter: projectsFilter ?? this.projectsFilter,
      departmentFilter: departmentFilter ?? this.departmentFilter,
      titleFilter: titleFilter ?? this.titleFilter,
    );
  }

  @override
  List<Object?> get props => [
        contactStates,
        listContacts,
        tempList,
        companiesFilter,
        projectsFilter,
        departmentFilter,
        titleFilter
      ];

   static ContactCubitStates? fromMap(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return const ContactCubitStates(
        contactStates :ContactsEnumStates.initial,
        listContacts : <ContactsDataFromApi>[],
        tempList : <ContactsDataFromApi>[],
        companiesFilter : [],
        projectsFilter : [],
        departmentFilter : [],
        titleFilter : [],
      );
    }
    int val = json['contactStates'];
    return ContactCubitStates(
      contactStates :ContactsEnumStates.values[val],
      listContacts : List<ContactsDataFromApi>.from(
          json['listContacts']?.map((p) => ContactsDataFromApi.fromJson(p))),
            // : null)json['listContacts'] as List<ContactsDataFromApi>,
      tempList : List<ContactsDataFromApi>.from(
          json['tempList']?.map((p) => ContactsDataFromApi.fromJson(p))),
      // json['tempList'],
      companiesFilter : json['companiesFilter'],
      projectsFilter : json['projectsFilter'],
      departmentFilter : json['departmentFilter'],
      titleFilter : json['titleFilter'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'contactStates':contactStates.index,
      'listContacts': listContacts,
      'tempList': tempList,
      'companiesFilter': companiesFilter,
      'projectsFilter': projectsFilter,
      'departmentFilter': departmentFilter,
      'titleFilter': titleFilter,
    };
  }
}

class BlocGetContactsErrorState extends ContactsStates {
  final String error;
  BlocGetContactsErrorState(this.error);
  @override
  List<Object?> get props => [];
}
