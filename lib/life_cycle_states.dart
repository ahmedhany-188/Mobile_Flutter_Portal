import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'bloc/auth_app_status_bloc/app_bloc.dart';

class LifeCycleState extends StatefulWidget  {
  final Widget child;
  const LifeCycleState({Key? key, required this.child}) : super(key: key);

  @override
  _LifeCycleStateState createState() => _LifeCycleStateState();
}

class _LifeCycleStateState extends State<LifeCycleState> with WidgetsBindingObserver {

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print("life cycle --> started");
        return widget.child;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    print("life cycle --> closed");
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    final status = context
        .read<AppBloc>().state.status;
    if(state == AppLifecycleState.resumed){
      print("life cycle -->resumed");
      print(status== AppStatus.authenticated ? "life cycle --> authenticated":"life cycle -->unauthenticated");
      updateFirebaseWithStatus(AppLifecycleStatus.online);
    }else if (state == AppLifecycleState.inactive){
      print("life cycle -->inactive");
      print(status== AppStatus.authenticated ? "life cycle inactive --> authenticated":"life cycle inactive-->unauthenticated");
      updateFirebaseWithStatus(AppLifecycleStatus.offline);
    }else if (state == AppLifecycleState.paused || state == AppLifecycleState.detached){
      print("life cycle -->paused");
      print(status== AppStatus.authenticated ? "life cycle paused --> authenticated":"life cycle paused-->unauthenticated");
      updateFirebaseWithStatus(AppLifecycleStatus.offline);
    }
  }

  updateFirebaseWithStatus(AppLifecycleStatus appLifecycleStatus){

    FirebaseProvider(context
        .read<AppBloc>().state.userData).updateUserOnline(appLifecycleStatus);

  }
}

