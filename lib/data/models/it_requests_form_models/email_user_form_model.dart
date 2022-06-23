
class EmailUserFormModel {

  final String ?requestDate, userMobile, comments;
  final int ?requestType, status,requestHrCode;


  final bool ?accountType, valid;


  EmailUserFormModel(this.requestDate, this.requestType, this.userMobile,
      this.accountType, this.valid, this.requestHrCode, this.status,
      this.comments);


  EmailUserFormModel.fromJson(Map<String, dynamic> json)
      :

        requestDate= json["date"],
        requestType=json["reqType"],
        userMobile=json["ownerMobile"],
        valid =json["valid"],
        accountType=json["emailAccount"],
        status = json['status'],
        requestHrCode = json['requestHrCode'],
        comments=json["comments"];
}

