abstract class BlocStates{}

class BlocInitialState extends BlocStates{}

class BlocGetContactsLoadingState extends BlocStates{}
class BlocGetContactsSuccessState extends BlocStates{}
class BlocGetContactsErrorState extends BlocStates {
  final String error;
  BlocGetContactsErrorState(this.error);
}

class BlocGetFiltersForContactsLoadingState extends BlocStates{}
class BlocGetFiltersForContactsSuccessState extends BlocStates{}
class BlocGetFiltersForContactsErrorState extends BlocStates {
  final String error;
  BlocGetFiltersForContactsErrorState(this.error);
}



