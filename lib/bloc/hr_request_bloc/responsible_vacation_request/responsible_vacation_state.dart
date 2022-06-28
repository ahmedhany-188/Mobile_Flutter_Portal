part of 'responsible_vacation_cubit.dart';

abstract class ResponsibleVacationState extends Equatable {
  const ResponsibleVacationState();
}
enum ResponsibleListStatus { loading, success, failure,successSearching }
class ResponsibleVacationInitial extends ResponsibleVacationState {
  const ResponsibleVacationInitial._({
    this.status = ResponsibleListStatus.loading,
    this.items = const <ContactsDataFromApi>[],
    this.tempItems = const <ContactsDataFromApi>[],
  });

  const ResponsibleVacationInitial.loading() : this._();

  const ResponsibleVacationInitial.success(List<ContactsDataFromApi> items)
      : this._(status: ResponsibleListStatus.success, items: items);

  const ResponsibleVacationInitial.successSearching(List<ContactsDataFromApi> items,List<ContactsDataFromApi> mainItems)
      : this._(status: ResponsibleListStatus.successSearching, tempItems: items,items: mainItems);

  const ResponsibleVacationInitial.failure() : this._(status: ResponsibleListStatus.failure);

  final ResponsibleListStatus status;
  final List<ContactsDataFromApi> items;
  final List<ContactsDataFromApi> tempItems;

  @override
  List<Object> get props => [status, items,tempItems];
}
