

class BusinessCardFormModel {
  final String ?requestDate, employeeNameCard, employeeMobil,
      employeeExt, faxNo, employeeComments, requestHrCode;
  int status;

  BusinessCardFormModel(this.requestDate, this.employeeNameCard,
      this.employeeMobil, this.employeeExt, this.faxNo, this.employeeComments,
      this.status, this.requestHrCode);


  BusinessCardFormModel.fromJson(Map<String, dynamic>json):

        requestDate=json["date"],
        employeeNameCard=json["cardName"],
        employeeMobil=json["mobileNo"],
        employeeExt= json["extNo"],
        faxNo=json["faxNo"],
        employeeComments=json["comments"],
        status=json["status"],
        requestHrCode=json["requestHrCode"];
}