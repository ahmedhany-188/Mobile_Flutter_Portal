

class AccessRightModel{


  int requestType;
  // bool usbException,vpnAccount,ipPhone,localAdmin,colorPrinting;
  bool permanent;
  String requestDate,fromDate,toDate,filePDF,comments;
  List<String> items;

  AccessRightModel(
      this.requestType,
      // this.usbException,
      // this.vpnAccount,
      // this.ipPhone,
      // this.localAdmin,
      // this.colorPrinting,
      this.permanent,
      this.requestDate,
      this.fromDate,
      this.toDate,
      this.filePDF,
      this.comments,
      this.items);
}