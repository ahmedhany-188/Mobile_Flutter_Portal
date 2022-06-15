

class BusinessCardFormModel {
  final String ?requestDate, employeeNameCard, employeeMobil,
      employeeExt, faxNo, employeeComments;

  BusinessCardFormModel(this.requestDate, this.employeeNameCard,
      this.employeeMobil, this.employeeExt, this.faxNo, this.employeeComments);


  BusinessCardFormModel.fromJson(Map<String, dynamic>json)
      :

        requestDate=json["date"],
        employeeNameCard=json["cardName"],
        employeeMobil=json["employeeMobil"],
        employeeExt= json["extNo"],
        faxNo=json["faxNo"],
        employeeComments=json["comments"];


}