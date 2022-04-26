import 'dart:convert';
import 'package:http/http.dart' as http;

class MedicalRequestDataProvider{

      // example of servicedate "2022-04-21T12:39:19.532Z"
      // example of indate "2022-04-21T12:39:19.532Z"
     String HR_code,HAHuser_MedicalRequest,Patientname_MedicalRequest,selectedValueLab,selectedValueService,selectedDate;


     MedicalRequestDataProvider(
      this.HR_code,
      this.HAHuser_MedicalRequest,
      this.Patientname_MedicalRequest,
      this.selectedValueLab,
      this.selectedValueService,
         this.selectedDate);

  Future<http.Response> getMedicalRequestMessage() async {


      return http.post(
        Uri.parse(
            "https://api.hassanallam.com/api/SelfService/AddMedicalRequest"
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
            "ID": "1",
            "HrCode": HR_code,
            "ServiceDate": selectedDate,
            "Beneficiaryname": Patientname_MedicalRequest,
            "Servicetype": selectedValueLab,
            "LabType": selectedValueService,
            "InDate": selectedDate
        }),
      );
    }
}