

class EmbassyLetterFormModel {


  final String ?requestDate, purpose, embassy, dateFrom, dateTo, passportNo,
      comments,
      addSalary;

  const EmbassyLetterFormModel(this.requestDate,
      this.purpose,
      this.embassy,
      this.dateFrom,
      this.dateTo,
      this.passportNo,
      this.addSalary,
      this.comments);


  EmbassyLetterFormModel.fromJson(Map<String, dynamic>json)
      :

        requestDate=json["date"],
        purpose=json["purpose"],
        embassy=json["embassyId"],
        dateFrom=json["dateFrom"],
        dateTo=json["dateTo"],
        passportNo=json["passportNo"],
        addSalary=json["addSalary"],
        comments=json["comments"];


}