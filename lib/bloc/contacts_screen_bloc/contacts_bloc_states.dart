abstract class ContactsBlocStates {}

class BlocInitialState extends ContactsBlocStates {}

class BlocGetContactsLoadingState extends ContactsBlocStates {}

class BlocGetContactsSuccessState extends ContactsBlocStates {
  List<dynamic> contacts;

  BlocGetContactsSuccessState(this.contacts);
}

class BlocGetContactsErrorState extends ContactsBlocStates {
  final String error;
  BlocGetContactsErrorState(this.error);
}

// class BlocGetFiltersForContactsLoadingState extends ContactsBlocStates{}
// class BlocGetFiltersForContactsSuccessState extends ContactsBlocStates{}
// class BlocGetFiltersForContactsErrorState extends ContactsBlocStates {
//   final String error;
//   BlocGetFiltersForContactsErrorState(this.error);
// }
