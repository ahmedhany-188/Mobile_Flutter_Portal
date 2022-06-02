part of 'business_card_cubit.dart';

@immutable
abstract class BusinessCardState {

  const BusinessCardState();
  const BusinessCardState.copy({
    required RequestDate employeeNameCard,required RequestDate employeeMobile,
    required FormzStatus status});

}

class BusinessCardInitial extends BusinessCardState {
  const BusinessCardInitial({

    this.employeeNameCard = const RequestDate.pure(),
    this.employeeMobile = const RequestDate.pure(),
    this.employeeExt,
    this.employeeFaxNO,
    this.comment,
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.successMessage,

  });

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

}){
    return BusinessCardInitial(

      employeeNameCard: employeeNameCard ?? this.employeeNameCard,
      employeeMobile: employeeMobile ?? this.employeeMobile,
      employeeExt: employeeExt ?? this.employeeExt,
      employeeFaxNO: employeeFaxNO ?? this.employeeFaxNO,
      comment: comment ?? this.comment,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,

    );
  }

}
