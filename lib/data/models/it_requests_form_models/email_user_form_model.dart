
class EmailUserFormModel {

  String ?requestDate, userMobile;
  int ?requestType;

  bool ?accountType,valid;

  EmailUserFormModel(this.requestDate, this.requestType, this.userMobile,
      this.accountType);
}

