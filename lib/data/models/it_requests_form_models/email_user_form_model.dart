
class EmailUserFormModel {

  final String ?requestDate, userMobile, comments, requestHrCode, location,
      title, fullName, email;
  final int ?requestType, status;

  final bool ?accountType, valid;


  EmailUserFormModel(this.requestDate, this.requestType, this.userMobile,
      this.accountType, this.valid, this.requestHrCode, this.status,
      this.comments, this.location, this.title, this.fullName, this.email);


  EmailUserFormModel.fromJson(Map<String, dynamic> json):

        requestDate= json["date"],
        requestType=json["reqType"],
        userMobile=json["ownerMobile"],
        valid =json["valid"],
        accountType=json["emailAccount"],
        status = json['status'],
        requestHrCode = json['ownerHrCode'],
        comments=json["comments"],
        location=json["ownerLocation"],
        title=json["ownerTitle"],
        fullName=json["ownerFullName"],
        email=json["email"];

}

