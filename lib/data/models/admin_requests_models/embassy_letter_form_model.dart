

class EmbassyLetterFormModel {


  final String ?requestDate, purpose, embassy, dateFrom, dateTo, passportNo,
      comments,
      addSalary, requestHrCode;

  final int ?status;

  const EmbassyLetterFormModel(this.requestDate,
      this.purpose,
      this.embassy,
      this.dateFrom,
      this.dateTo,
      this.passportNo,
      this.addSalary,
      this.comments,
      this.status,
      this.requestHrCode);


  EmbassyLetterFormModel.fromJson(Map<String, dynamic>json):
        requestDate=json["date"],
        purpose=json["purpose"],
        embassy=json["embassyId"],
        dateFrom=json["dateFrom"],
        dateTo=json["dateTo"],
        passportNo=json["passportNo"],
        addSalary=json["addSalary"],
        comments=json["comments"],
        status=json["status"],
        requestHrCode=json["requestHrCode"];

}