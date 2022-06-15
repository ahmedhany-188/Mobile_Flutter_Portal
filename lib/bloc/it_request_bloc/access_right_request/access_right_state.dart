part of 'access_right_cubit.dart';

@immutable
abstract class AccessRightState extends Equatable{

  const AccessRightState();

  const AccessRightState.copyWith({
    required RequestDate requestItems,required FormzStatus status,required });
}

class AccessRightInitial extends Equatable {
  const AccessRightInitial({
    this.requestStatus = RequestStatus.newRequest,
    this.requestDate = const RequestDate.pure(),
    this.requestType=1,
    this.requestItems  = const RequestDate.pure(),
    this.fromDate= const RequestDate.pure(),
    this.toDate= const RequestDate.pure(),
    this.permanent=false,
    this.comments="",
    this.filePDF="",
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.successMessage,
  });

  final RequestDate requestDate;
  final int requestType;
  final RequestDate requestItems;
  final RequestDate fromDate;
  final RequestDate toDate;
  final bool permanent;
  final String comments;
  final String filePDF;
  final FormzStatus status;
  final String? errorMessage;
  final String? successMessage;
  final RequestStatus? requestStatus;

  @override
  List<Object> get props => [requestDate,requestItems,fromDate,toDate,status];

  AccessRightInitial copyWith({
    RequestDate ?requestDate,
    int ?requestType,
    RequestDate ?requestItems,
     RequestDate ?fromDate,
     RequestDate ?toDate,
     bool ?permanent,
    String ?comments,
    String ?filePDF,
    FormzStatus ?status,
    String? errorMessage,
    String? successMessage,
    RequestStatus? requestStatus,
  }) {
    return AccessRightInitial(
      requestDate: requestDate ?? this.requestDate,
      requestType: requestType ?? this.requestType,
      requestItems: requestItems ?? this.requestItems,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      permanent: permanent ?? this.permanent,
      comments: comments ?? this.comments,
      filePDF: filePDF ?? this.filePDF,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      requestStatus: requestStatus ?? this.requestStatus,
    );
  }

}
