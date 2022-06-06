
class EmailUserFormModel {

  String ?requestDate;
  int ?requestType;
  String ?userMobile;
  bool ?accountType;

  EmailUserFormModel(this.requestDate, this.requestType, this.userMobile,
      this.accountType);


}


// Head.Request_No = Request_No;
// Head.Service_ID = Request.QueryString["stype"].ToString();
//
// Head.Request_HR_Code = Request_HR_Code;
// Head.ReqType = int.Parse(RB_ReqType.Value.ToString());
// Head.Owner_HR_Code = txtAssHrCode.Text;
// Head.Owner_FullName = txtAssName.Text;
// Head.Owner_Location = DWLLocation.Value.ToString();
// Head.Owner_Title = DWLTitle.Value.ToString();
// Head.Owner_Mobile = txtMobile.Text;
// Head.Owner_EmailDisabled = txtAssName.Text;
// Head.Date = DateTime.Now;
// //Head.Comments = txtJustify.Text;
// Head.Status = 0;
// if (item.Text == "Login User Account")
// {
// MR.LoginUserAccount = true;
// }
// else if (item.Text == "Email Account")
// {
// MR.EmailAccount = true;
// }

