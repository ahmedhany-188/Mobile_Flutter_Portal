part of 'app_bloc.dart';

@immutable
class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.userData = MainUserData.empty,
  });

  const AppState.authenticated(MainUserData userData)
      : this._(status: AppStatus.authenticated, userData: userData);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  final AppStatus status;
  final MainUserData userData;

  @override
  List<Object> get props => [status, userData];
}
enum AppStatus {
  authenticated,
  unauthenticated,
}

