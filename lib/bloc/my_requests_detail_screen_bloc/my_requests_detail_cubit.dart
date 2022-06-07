import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'my_requests_detail_state.dart';

class MyRequestsDetailCubit extends Cubit<MyRequestsDetailState> {
  MyRequestsDetailCubit() : super(MyRequestsDetailInitial());
}
