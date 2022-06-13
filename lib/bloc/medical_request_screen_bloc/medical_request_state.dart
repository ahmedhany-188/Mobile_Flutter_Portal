part of 'medical_request_cubit.dart';

@immutable
abstract class MedicalRequestState {
  const MedicalRequestState();

  const MedicalRequestState.copyWith({required RequestDate patientNameMedicalRequest,
    required RequestDate selectedValueLab, required RequestDate selectedValueService,
    required RequestDate requestDate, required FormzStatus status});

}


class MedicalRequestInitial extends MedicalRequestState {

  const MedicalRequestInitial({
    this.patientNameMedicalRequest=const RequestDate.pure(),
    this.selectedValueLab=const RequestDate.pure(),
    this.selectedValueService=const RequestDate.pure(),
    this.requestDate =  const RequestDate.pure() ,
    this.status =FormzStatus.pure,
    this.errorMessage,
    this.successMessage,
  });

  final RequestDate patientNameMedicalRequest;
  final RequestDate selectedValueLab;
  final RequestDate selectedValueService;
  final RequestDate requestDate;
  final FormzStatus status;
  final String? errorMessage;
  final String? successMessage;


  @override
  List<Object> get props => [patientNameMedicalRequest, selectedValueLab,
    selectedValueService, requestDate, status
  ];
  MedicalRequestInitial copyWith({

    RequestDate ?patientNameMedicalRequest,
    RequestDate ?selectedValueLab,
    RequestDate ?selectedValueService,
    RequestDate? requestDate,
    FormzStatus? status,
    String? errorMessage,
    String? successMessage,
  }) {
    return MedicalRequestInitial(
      patientNameMedicalRequest: patientNameMedicalRequest ?? this.patientNameMedicalRequest,
      selectedValueLab: selectedValueLab ?? this.selectedValueLab,
      selectedValueService: selectedValueService ?? this.selectedValueService,
      requestDate: requestDate ?? this.requestDate,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }

}



// class BlocGetTheMedicalRequestLoadingState extends MedicalRequestState{
// }
//
// class BlocgetTheMedicalRequestSuccesState extends MedicalRequestState{
//   String getMedicalRequestMessage;
//   BlocgetTheMedicalRequestSuccesState(this.getMedicalRequestMessage);
// }
//
// class BlocgetTheMedicalRequestErrorState extends MedicalRequestState{
//   String errorMedicalRequestMessage;
//   BlocgetTheMedicalRequestErrorState(this.errorMedicalRequestMessage);
// }





