part of 'benefits_cubit.dart';

abstract class BenefitsState {}

class BenefitsInitial extends BenefitsState {}

class BenefitsLoadingState extends BenefitsState {}

class BenefitsSuccessState extends BenefitsState {
  final List<dynamic> benefits;

  BenefitsSuccessState(this.benefits);
}

class BenefitsErrorState extends BenefitsState {
  final String error;
  BenefitsErrorState(this.error);
}