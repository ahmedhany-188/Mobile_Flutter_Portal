part of 'contacts_cubit.dart';

@immutable
abstract class ContactsStates {}

class BlocInitialState extends ContactsStates {}

class BlocGetContactsLoadingState extends ContactsStates {}

class BlocGetContactsSuccessState extends ContactsStates {
  List<ContactsDataFromApi> contacts;

  BlocGetContactsSuccessState(this.contacts);
}

class BlocGetContactsErrorState extends ContactsStates {
  final String error;
  BlocGetContactsErrorState(this.error);
}

// class BlocGetFiltersForContactsLoadingState extends ContactsBlocStates{}
// class BlocGetFiltersForContactsSuccessState extends ContactsBlocStates{}
// class BlocGetFiltersForContactsErrorState extends ContactsBlocStates {
//   final String error;
//   BlocGetFiltersForContactsErrorState(this.error);
// }
