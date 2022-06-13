

class BusinessMissionFormModelData{


  int requestNo,status;
  String  serviceId, requestHrCode,
      date, comments,  missionLocation,
      dateFrom, dateTo, hourFrom,
      hourTo, dateFromAmpm, dateToAmpm;


  BusinessMissionFormModelData(
      this.requestNo,
      this.serviceId,
      this.requestHrCode,
      this.date,
      this.status,
      this.comments,
      this.missionLocation,
      this.dateFrom,
      this.dateTo,
      this.hourFrom,
      this.hourTo,
      this.dateFromAmpm,
      this.dateToAmpm);
}