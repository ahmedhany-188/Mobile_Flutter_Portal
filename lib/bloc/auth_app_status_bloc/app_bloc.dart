import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/data_providers/firebase_provider/FirebaseProvider.dart';
import '../../life_cycle_states.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
        authenticationRepository.currentUser.isNotEmpty
            ? AppState.authenticated(authenticationRepository.currentUser)
            : const AppState.unauthenticated(),
      ) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authenticationRepository.status.listen(
          (userData) => add(AppUserChanged(userData)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<MainUserData> _userSubscription;

  Future<void> _onUserChanged(AppUserChanged event, Emitter<AppState> emit) async {
    if(event.userData.isNotEmpty){
      FirebaseProvider(event.userData.user!).updateUserOnline(AppLifecycleStatus.online);
    }

    emit(
      event.userData.isNotEmpty
          ? AppState.authenticated(event.userData)
          : const AppState.unauthenticated(),
    );
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    if(_authenticationRepository.currentUser.isNotEmpty){
      FirebaseProvider(_authenticationRepository.currentUser.user!).updateUserOnline(AppLifecycleStatus.offline);
    }
    unawaited(_authenticationRepository.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }
}
