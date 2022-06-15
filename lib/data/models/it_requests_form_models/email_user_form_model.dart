
class EmailUserFormModel {

  final String ?requestDate, userMobile;
  final int ?requestType;

  final bool ?accountType, valid;

  EmailUserFormModel(this.requestDate, this.requestType, this.userMobile,
      this.accountType, this.valid);


  EmailUserFormModel.fromJson(Map<String, dynamic> json):

        requestDate= json["date"],
        requestType=json["reqType"],
        userMobile=json["ownerMobile"],
        valid =json["valid"],
        accountType=json["emailAccount"];

}

