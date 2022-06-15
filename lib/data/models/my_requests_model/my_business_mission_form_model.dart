

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


  BusinessMissionFormModelData.fromJson(Map<String, dynamic> json):

        requestNo=json["requestNo"],
        serviceId=json["serviceId"],
        requestHrCode=json["requestHrCode"],
        date=json["date"],
        status=json["status"],
        comments=json["comments"],
        missionLocation=json["missionLocation"],
        dateFrom=json["dateFrom"],
        dateTo=json["dateTo"],
        hourFrom=json["hourFrom"],
        hourTo=json["hourTo"],
        dateFromAmpm=json["dateFromAmpm"],
        dateToAmpm=json["dateToAmpm"];
}