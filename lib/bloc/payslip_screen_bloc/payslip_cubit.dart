
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/data/helpers/download_pdf.dart';
import 'package:hassanallamportalflutter/data/repositories/payslip_repository.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/url_links.dart';

part 'payslip_state.dart';

class PayslipCubit extends Cubit<PayslipState> {

  final Connectivity connectivity = Connectivity();
  PayslipCubit(this._payslipRepository) : super(PayslipState());


  final PayslipRepository _payslipRepository;

  void getPdfLink(User user,String password) async {
    // EasyLoading.init();

    // EasyLoading.showSuccess(status)
    emit(state.copyWith(
      payslipDataEnumStates: PayslipDataEnumStates.loading,));

        try {
          var connectivityResult = await connectivity.checkConnectivity();
            if (connectivityResult == ConnectivityResult.wifi ||
                connectivityResult == ConnectivityResult.mobile) {
              final response = await _payslipRepository.getPayslipPdf(
                  user.email, password);
              bool _validURL = Uri
                  .parse(response)
                  .isAbsolute;

              // downloadPdf(response);
              _validURL ? downloadPdf(user,response) :
                  emit(state.copyWith(
              payslipDataEnumStates: PayslipDataEnumStates.failed,
                  error: response));
            }else {
            emit(state.copyWith(
              payslipDataEnumStates: PayslipDataEnumStates.failed,
            error: "No internet Connection"));
          }
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          emit(state.copyWith(
              payslipDataEnumStates: PayslipDataEnumStates.failed,
              error: e.toString()));
        }
  }

  void getPayslipAvailableMonths(User user,String password) async {
    // EasyLoading.init();
    // EasyLoading.showSuccess(status)
    emit(state.copyWith(
      payslipDataEnumStates: PayslipDataEnumStates.loading,));
    try {
      var connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        if (password.trim().isEmpty) {
          emit(state.copyWith(
              payslipDataEnumStates: PayslipDataEnumStates.failed,
              error: "Invalid Password"));
        } else {
          final response = await _payslipRepository.getPayslipAvailableMonths(
              user.email, password);
            String months = response;
            List<String> monthsList = months.split("-").where((
                element) => element.toString().trim().isNotEmpty).toList();
            try{
              monthsList.map(int.parse).toList();
              monthsList.isNotEmpty ? emit(state.copyWith(
                payslipDataEnumStates: PayslipDataEnumStates.success,
                months: monthsList, response: "Success",
              )) : emit(state.copyWith(
                  payslipDataEnumStates: PayslipDataEnumStates.failed,
                  error: "No data found"));
            }catch(e){
              emit(state.copyWith(
                  payslipDataEnumStates: PayslipDataEnumStates.failed,
                  error: response));
            }
        }
      } else {
        emit(state.copyWith(
            payslipDataEnumStates: PayslipDataEnumStates.failed,
            error: "No internet Connection"));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
        emit(state.copyWith(
            payslipDataEnumStates: PayslipDataEnumStates.failed,
            error: e.toString()));
      }
    }
  }

  void getPayslipByMonth(User user,String password, String month) async {
    // EasyLoading.init();
    // EasyLoading.showSuccess(status)
    emit(state.copyWith(
      payslipDataEnumStates: PayslipDataEnumStates.loading,));
    try {
      var connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        final response = await _payslipRepository.getPayslipByMonth(
            user.email, password, month);
        if (password.trim().isEmpty) {
          emit(state.copyWith(
              payslipDataEnumStates: PayslipDataEnumStates.failed,
              error: "Invalid Password"));
        }else{
          bool _validURL = Uri
              .parse(response)
              .isAbsolute;
          _validURL ? downloadPdf(user,response) :
          emit(state.copyWith(
              payslipDataEnumStates: PayslipDataEnumStates.failed,
              error: response));
        }
      }else {
        emit(state.copyWith(
            payslipDataEnumStates: PayslipDataEnumStates.failed,
            error: "No internet Connection"));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(
          payslipDataEnumStates: PayslipDataEnumStates.failed,
          error: e.toString()));
    }
  }

  void downloadPdf(User user,String link){
    emit(state.copyWith(
        payslipDataEnumStates: PayslipDataEnumStates.download,
        response: "Downloading..."));
    List<String> split = link.split("/");
    int monthNumber  = int.parse(split[split.length-2]);
    var monthName = DateFormat('MMMM').format(DateTime(0, monthNumber));
    // downloadPdfHelper.requestDownload(link, "Payslip-"+ monthName+".pdf");

    DownloadPdfHelper(fileName: "Payslip-${user.userHRCode}-$monthName.pdf",fileUrl: link,success: (){
      emit(state.copyWith(
          payslipDataEnumStates: PayslipDataEnumStates.success,
          response: "Finished"));
    },failed: (){
      emit(state.copyWith(
          payslipDataEnumStates: PayslipDataEnumStates.failed,
          error: "Error"));
    }).download();

  }

  void openResetLink(){
    try {
      launchUrl(
        Uri.parse(resetPayslipLink()),
        mode: LaunchMode.externalApplication,
      );
    } catch (e, s) {
      print(s);
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    EasyLoading.dismiss();
    return super.close();

  }


}
