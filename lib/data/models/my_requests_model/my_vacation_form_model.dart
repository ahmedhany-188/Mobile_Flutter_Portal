

class VacationModelFormData{

  int requestNo,noOfDays,status;
  String  serviceId,requestHrCode,vacationType,responsible,
  date,comments, dateFrom,dateTo;

  VacationModelFormData(
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
      this.noOfDays,);
}