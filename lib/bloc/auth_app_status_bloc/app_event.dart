part of 'app_bloc.dart';

@immutable
abstract class AppEvent extends Equatable{
  const AppEvent();

  @override
  List<Object> get props => [];
}
class AppLogoutRequested extends AppEvent {}

class AppUserChanged extends AppEvent {
  @visibleForTesting
  const AppUserChanged(this.userData);

  final MainUserData userData;
  // final EmployeeData employeeData;


  @override
  List<Object> get props => [userData];
}