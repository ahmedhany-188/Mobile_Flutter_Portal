part of 'medical_request_cubit.dart';

@immutable
abstract class MedicalRequestState {}

class MedicalRequestInitial extends MedicalRequestState {}

class BlocGetTheMedicalRequestLoadingState extends MedicalRequestState{}

// class BlocGetTheMedicalRequestDownloadState extends MedicalRequestState{
//   String getMedicalRequestDownloadMessage;
//   BlocGetTheMedicalRequestDownloadState(this.getMedicalRequestDownloadMessage);
// }

class BlocgetTheMedicalRequestSuccesState extends MedicalRequestState{
  String getMedicalRequestMessage;
  BlocgetTheMedicalRequestSuccesState(this.getMedicalRequestMessage);
}

class BlocgetTheMedicalRequestErrorState extends MedicalRequestState{
  String errorMedicalRequestMessage;
  BlocgetTheMedicalRequestErrorState(this.errorMedicalRequestMessage);
}





