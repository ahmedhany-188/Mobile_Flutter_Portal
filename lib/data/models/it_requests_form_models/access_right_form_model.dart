

class AccessRightModel {

  final int ?requestType;
  final bool ?permanent, usbException, vpnAccount, ipPhone,
      localAdmin; //colorPrinting;
  final String ?requestDate, fromDate, toDate, filePDF, comments;

   AccessRightModel(
    this.requestType,
    this.usbException,
    this.vpnAccount,
    this.ipPhone,
    this.localAdmin,
    // this.colorPrinting,
    this.permanent,
    this.requestDate,
    this.fromDate,
    this.toDate,
    this.filePDF,
    this.comments,
  );


  AccessRightModel.fromJson(Map<String, dynamic> json)
      :

        requestType=json["reqType"],
        usbException=json["usbException"],
        vpnAccount=json["vpnAccount"],
        ipPhone=json["ipPhone"],
        localAdmin=json["localAdmin"],
        permanent=json["isPermanent"],
        requestDate=json["date"],
        fromDate=json["startDate"],
        toDate=json["endDate"],
        filePDF=json["filePdf"],
        comments=json["comments"];

}