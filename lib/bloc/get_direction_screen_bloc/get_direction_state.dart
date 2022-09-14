part of 'get_direction_cubit.dart';

// abstract class GetDirectionState {
//   // const GetDirectionState();
// }

enum GetDirectionStatus { loading, success, failure,successSearching}
class GetDirectionInitial extends Equatable {
  const GetDirectionInitial._({
    this.status = GetDirectionStatus.loading,
    this.items = const <LocationData>[],
    this.tempItems = const <LocationData>[],
    this.mappedItems = const <LocationData>[],
    this.errorMessage = "",
  });

  const GetDirectionInitial.loading() : this._();

  const GetDirectionInitial.success(List<LocationData> items,List<LocationData> mappedItems)
      : this._(status: GetDirectionStatus.success, items: items,mappedItems: mappedItems);

  const GetDirectionInitial.successSearching(List<LocationData> items,
      List<LocationData> mainItems)
      : this._(status: GetDirectionStatus.successSearching,
      tempItems: items,
      items: mainItems);

  const GetDirectionInitial.failure(String errorMessage)
      : this._(status: GetDirectionStatus.failure,errorMessage: errorMessage);

  final GetDirectionStatus status;
  final List<LocationData> items;
  final List<LocationData> mappedItems;
  final List<LocationData> tempItems;
  final String errorMessage;

  @override
  List<Object> get props => [status, items, tempItems,mappedItems];
}

// class GetDirectionInitial extends GetDirectionState {}
//
// class GetDirectionLoadingState extends GetDirectionState {}
//
// class GetDirectionSuccessState extends GetDirectionState {
//   List<LocationData> getDirectionList;
//
//   GetDirectionSuccessState(this.getDirectionList);
// }
//
// class GetDirectionErrorState extends GetDirectionState {
//   final String error;
//   GetDirectionErrorState(this.error);
// }
