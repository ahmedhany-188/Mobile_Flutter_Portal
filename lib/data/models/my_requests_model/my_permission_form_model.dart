class PermissionFormModelData{
  int requestNo,status,type;
  String  serviceId, requestHrCode,
   date,
  comments,
  dateFrom,
  dateTo,
  dateFromAmpm,
  dateToAmpm,
  permissionDate;
  PermissionFormModelData(
      this.requestNo,
      this.serviceId,
      this.requestHrCode,
      this.date,
      this.status,
      this.comments,
      this.type,
      this.dateFrom,
      this.dateTo,
      this.dateFromAmpm,
      this.dateToAmpm,
      this.permissionDate,
      );
}