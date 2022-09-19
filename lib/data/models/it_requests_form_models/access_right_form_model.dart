

class AccessRightModel {

  final int ?requestType, status;
  final bool ?permanent, usbException, vpnAccount, ipPhone,
      localAdmin, printing;
  final String ?requestDate, fromDate, toDate, filePDF, comments, requestHrCode;

  AccessRightModel(this.requestType,
      this.status,
      this.usbException,
      this.vpnAccount,
      this.ipPhone,
      this.localAdmin,
      this.printing,
      this.permanent,
      this.requestDate,
      this.fromDate,
      this.toDate,
      this.filePDF,
      this.comments,
      this.requestHrCode,);


  AccessRightModel.fromJson(Map<String, dynamic> json):
        requestType=json["reqType"],
        status = json['status'],
        usbException=json["usbException"],
        vpnAccount=json["vpnAccount"],
        ipPhone=json["ipPhone"],
        localAdmin=json["localAdmin"],
        printing=json["printing"],
        permanent=json["isPermanent"],
        requestDate=json["date"],
        fromDate=json["startDate"],
        toDate=json["endDate"],
        filePDF=json["filePdf"],
        comments=json["comments"],
        requestHrCode = json['requestHrCode'];

}