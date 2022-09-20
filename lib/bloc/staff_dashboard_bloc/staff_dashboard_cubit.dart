import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/constants/constants.dart';
import 'package:hassanallamportalflutter/data/models/staff_dashboard_models/companystaffdashboard_model.dart';
import 'package:hassanallamportalflutter/data/repositories/staff_dashboard_repository.dart';
import 'package:hassanallamportalflutter/widgets/dialogpopoup/custom_date_picker.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'staff_dashboard_state.dart';

class StaffDashboardCubit extends Cubit<StaffDashboardState> with HydratedMixin {


  StaffDashboardCubit(this.userHRCode)
      : super(StaffDashboardState(date: DateTime
      .now()
      .month
      .toString())) {
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (state.companyStaffDashBoardEnumStates ==
          CompanyStaffDashBoardEnumStates.failed ||
          state.companyStaffDashBoardEnumStates ==
              CompanyStaffDashBoardEnumStates.noConnection) {
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          try {
            // getFirstAttendanceList(userHrCode,state.month);
          } catch (e) {
            emit(state.copyWith(
              companyStaffDashBoardEnumStates: CompanyStaffDashBoardEnumStates
                  .failed,
            ));
          }
        }
        else if (connectivityResult == ConnectivityResult.none) {
          emit(state.copyWith(
            companyStaffDashBoardEnumStates: CompanyStaffDashBoardEnumStates
                .noConnection,
          ));
        }
      }
    });
  }

  static StaffDashboardCubit get(context) => BlocProvider.of(context);
  final Connectivity connectivity = Connectivity();
  String userHRCode;

  Future<void> getFirstStaffBoardCompanies(userHRCode, date) async {
    if (state.companyStaffDashBoardList.isEmpty) {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        try {
          emit(state.copyWith(
            companyStaffDashBoardEnumStates: CompanyStaffDashBoardEnumStates
                .loading,
          ));
          await StaffDashBoardRepository().getStaffDashBoardData(
              "10203520", date)
              .then((value) async {
                if(value.length>1){
                  emit(state.copyWith(
                      companyStaffDashBoardEnumStates: CompanyStaffDashBoardEnumStates
                          .success,
                      companyStaffDashBoardList: value,
                      date:date
                  ));
                }else{
                  emit(state.copyWith(
                    companyStaffDashBoardEnumStates: CompanyStaffDashBoardEnumStates.noDataFound,
                  ));
                }

          }).catchError((error) {
            emit(state.copyWith(
              companyStaffDashBoardEnumStates: CompanyStaffDashBoardEnumStates.failed,
            ));
          });
        } catch (e) {
          emit(state.copyWith(
            companyStaffDashBoardEnumStates: CompanyStaffDashBoardEnumStates.failed,
          ));
        }
      } else {
        emit(state.copyWith(
          companyStaffDashBoardEnumStates: CompanyStaffDashBoardEnumStates
              .noConnection,
        ));
      }
    }
  }

  Future<void> getStaffBoardCompanies(userHRCode, date) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        try {
          emit(state.copyWith(
            companyStaffDashBoardEnumStates: CompanyStaffDashBoardEnumStates
                .loading,
          ));
          await StaffDashBoardRepository().getStaffDashBoardData(
              userHRCode, date)
              .then((value) async {
            emit(state.copyWith(
                companyStaffDashBoardEnumStates: CompanyStaffDashBoardEnumStates
                    .success,
                companyStaffDashBoardList: value,
                date:date
            ));
          }).catchError((error) {
            emit(state.copyWith(
              companyStaffDashBoardEnumStates: CompanyStaffDashBoardEnumStates.failed,
            ));
          });
        } catch (e) {
          emit(state.copyWith(
            companyStaffDashBoardEnumStates: CompanyStaffDashBoardEnumStates.failed,
          ));
        }
      } else {
        emit(state.copyWith(
          companyStaffDashBoardEnumStates: CompanyStaffDashBoardEnumStates
              .noConnection,
        ));
      }

  }

  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }

  @override
  StaffDashboardState? fromJson(Map<String, dynamic> json) {
    return StaffDashboardState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(StaffDashboardState state) {
    if (state.companyStaffDashBoardEnumStates ==
        CompanyStaffDashBoardEnumStates.success &&
        state.companyStaffDashBoardList.isNotEmpty) {
      return state.toMap();
    } else {
      return null;
    }
  }

  void staffDashBoardDateChanged(BuildContext context, hrCode) async {
    DateTime? date = DateTime.now();
    FocusScope.of(context).requestFocus(
        FocusNode());

    date = await openShowDatePicker(context);

    var formatter = GlobalConstants.dateFormatServerDashBoard;
    String formattedDate = formatter.format(
        date ?? DateTime.now());

    if(formattedDate!=state.date){
      // context.read<StaffDashboardCubit>()
      //     .
      getStaffBoardCompanies(
          hrCode,formattedDate);
    }

  }

}
