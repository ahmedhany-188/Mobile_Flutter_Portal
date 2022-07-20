
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:hassanallamportalflutter/data/helpers/download_pdf.dart';
import 'package:hassanallamportalflutter/data/repositories/payslip_repository.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

part 'payslip_state.dart';

class PayslipCubit extends Cubit<PayslipState> {

  final _payslipRepository = PayslipRepository();
  final Connectivity connectivity = Connectivity();
  PayslipCubit() : super(PayslipInitialState());

  void getPdfLink(User user,String password) async {
    emit(PayslipLoadingState());
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
              _validURL ? downloadPdf(user,response) : emit(
                  PayslipErrorState(
                      response));
            }else {
            PayslipErrorState("No internet Connection");
          }
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          emit(PayslipErrorState(e.toString()));
        }
  }
  void downloadPdf(User user,String link){
    emit(PayslipDownloadState("Downloading..."));
    List<String> split = link.split("/");
    int monthNumber  = int.parse(split[split.length-2]);
    var monthName = DateFormat('MMMM').format(DateTime(0, monthNumber));
    // downloadPdfHelper.requestDownload(link, "Payslip-"+ monthName+".pdf");

    DownloadPdfHelper(fileName: "Payslip-${user.userHRCode}-$monthName.pdf",fileUrl: link,success: (){
      emit(PayslipSuccessState("Finished"));
    },failed: (){
      emit(PayslipErrorState("Error"));
    }).download();

  }

  void openResetLink(){
    try {
      launchUrl(
        Uri.parse("https://portal.hassanallam.com/PaySlip_Login.aspx"),
        mode: LaunchMode.externalApplication,
      );
    } catch (e, s) {
      print(s);
    }
  }


}
