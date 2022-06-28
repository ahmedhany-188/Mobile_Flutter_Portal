

class VacationModelFormData {

  final int? requestNo, noOfDays, status;
  final String? serviceId, requestHrCode, vacationType, responsible,
      date, comments, dateFrom, dateTo;

  const VacationModelFormData({
    this.requestNo,
    this.serviceId,
    this.requestHrCode,
    this.responsible,
    this.date,
    this.status,
    this.comments,
    this.vacationType,
    this.dateFrom,
    this.dateTo,
    this.noOfDays});


  VacationModelFormData.fromJson(Map<String, dynamic> json):

        requestNo = json["requestNo"],
        serviceId =json["serviceId"],
        requestHrCode=json["requestHrCode"],
        responsible=json["responsible"],
        date=json["date"],
        status=json["status"],
        comments=json["comments"],
        vacationType=json["vacationType"],
        dateFrom=json["dateFrom"],
        dateTo=json["dateTo"],
        noOfDays=json["noOfDays"];

}
