part of 'business_card_cubit.dart';

@immutable
abstract class BusinessCardState  extends Equatable{

  const BusinessCardState();
  const BusinessCardState.copy({
    required RequestDate employeeNameCard,required RequestDate employeeMobile,
    required FormzStatus status});

}

class BusinessCardInitial  extends Equatable {
  const BusinessCardInitial({

    this.requestStatus = RequestStatus.newRequest,
    this.employeeNameCard = const RequestDate.pure(),
    this.employeeMobile = const RequestDate.pure(),
    this.employeeExt,
    this.employeeFaxNO,
    this.comment,
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.successMessage,
    this.takeActionStatus,
    this.statusAction,
    this.requestDate = const RequestDate.pure(),

  });
  final RequestDate requestDate;
  final TakeActionStatus? takeActionStatus;
  final String? statusAction;
  final RequestStatus? requestStatus;
  final RequestDate employeeNameCard;
  final RequestDate employeeMobile;
  final String ?employeeExt;
  final String ?employeeFaxNO;
  final String ?comment;
  final FormzStatus status;
  final String? errorMessage;
  final String? successMessage;

  @override
  List<Object> get props => [employeeNameCard,employeeMobile,status];



  BusinessCardInitial copyWith({
    RequestDate ?employeeNameCard,
    RequestDate ?employeeMobile,
    String ?employeeExt,
    String ?employeeFaxNO,
    String ?comment,
    FormzStatus ?status,
    String? errorMessage,
    String? successMessage,
    RequestDate ?requestDate,
    RequestStatus? requestStatus,
    String? statusAction,


  }){
    return BusinessCardInitial(
      requestDate: requestDate ?? this.requestDate,
      employeeNameCard: employeeNameCard ?? this.employeeNameCard,
      employeeMobile: employeeMobile ?? this.employeeMobile,
      employeeExt: employeeExt ?? this.employeeExt,
      employeeFaxNO: employeeFaxNO ?? this.employeeFaxNO,
      comment: comment ?? this.comment,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
        takeActionStatus: takeActionStatus ?? this.takeActionStatus,
        statusAction: statusAction ?? this.statusAction,
      requestStatus: requestStatus ?? this.requestStatus,

    );
  }

}
