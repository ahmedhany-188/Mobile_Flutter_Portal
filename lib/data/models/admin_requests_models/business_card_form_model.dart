

class BusinessCardFormModel {
  final String? requestDate, employeeNameCard, employeeMobil,
      employeeExt, faxNo, employeeComments, requestHrCode;
  int? status;

  BusinessCardFormModel(this.requestDate, this.employeeNameCard,
      this.employeeMobil, this.employeeExt, this.faxNo, this.employeeComments,
      this.status, this.requestHrCode);

  BusinessCardFormModel.fromJson(Map<String, dynamic>json):

        requestHrCode=json["requestHrCode"],
        requestDate=json["date"],
        status=json["status"] ?? 0,
        employeeComments=json["comments"],
        employeeNameCard=json["cardName"],
        faxNo=json["faxNo"],
        employeeExt= json["extNo"],
        employeeMobil=json["mobileNo"];

}