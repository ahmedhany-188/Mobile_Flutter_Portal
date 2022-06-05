part of 'embassy_letter_cubit.dart';

@immutable
abstract class EmbassyLetterState {

  const EmbassyLetterState();

  const EmbassyLetterState.copywith({
    required RequestDate dateFrom ,required RequestDate dateTo
    , required RequestDate passortNumber, required FormzStatus status});
}

class EmbassyLetterInitial extends EmbassyLetterState {
  const EmbassyLetterInitial({
    this.purpose,
    this.embassy,
    this.dateFrom = const RequestDate.pure(),
    this.dateTo = const RequestDate.pure(),
    this.passportNumber = const RequestDate.pure(),
    this.salary,
    this.comments,
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.successMessage,
  });

  final String ?purpose;
  final String ?embassy;

  final RequestDate dateFrom;
  final RequestDate dateTo;
  final RequestDate passportNumber;
  final String ?salary;
  final String ?comments;

  final FormzStatus status;
  final String? errorMessage;
  final String? successMessage;

  @override
  List<Object> get props => [dateFrom, dateTo, passportNumber, status];


  EmbassyLetterInitial copyWith({

    String ?purpose,
    String ?embassy,
    RequestDate ?dateFrom,
    RequestDate ?dateTo,
    RequestDate ?passportNumber,
    String ?salary,
    String ?comments,
    FormzStatus ?status,
    String? errorMessage,
    String? successMessage,

  }) {
    return EmbassyLetterInitial(
      purpose: purpose ?? this.purpose,
      embassy: embassy ?? this.embassy,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      passportNumber: passportNumber ?? this.passportNumber,
      salary: salary ?? this.salary,
      comments: comments ?? this.comments,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }
}
