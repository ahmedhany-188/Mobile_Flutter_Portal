import 'dart:io';
import 'dart:isolate';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hassanallamportalflutter/data/helpers/download_pdf.dart';
import 'package:hassanallamportalflutter/data/repositories/payslip_repository.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'payslip_state.dart';

class PayslipCubit extends Cubit<PayslipState> {
  final downloadPdfHelper = DownloadPdfHelper();
  final _payslipRepository = PayslipRepository();
  final Connectivity connectivity = Connectivity();
  PayslipCubit() : super(PayslipInitialState());

  void getPdfLink(String email,String password) async {
    emit(PayslipLoadingState());
        try {
          var connectivityResult = await connectivity.checkConnectivity();
            if (connectivityResult == ConnectivityResult.wifi ||
                connectivityResult == ConnectivityResult.mobile) {
              final response = await _payslipRepository.getPayslipPdf(
                  email, password);
              bool _validURL = Uri
                  .parse(response)
                  .isAbsolute;

              _validURL ? downloadPdf(response) : emit(
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
  void downloadPdf(String link){
    emit(PayslipDownloadState("Downloading..."));
    List<String> split = link.split("/");
    int monthNumber  = int.parse(split[split.length-2]);
    var monthName = DateFormat('MMMM').format(DateTime(0, monthNumber));
    downloadPdfHelper.requestDownload(link, "Payslip-"+ monthName+".pdf");
    emit(PayslipSuccessState("Finished"));
  }


}
