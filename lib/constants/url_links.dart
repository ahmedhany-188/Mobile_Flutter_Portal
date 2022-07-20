photosLinks(String photoName) {
  return "https://portal.hassanallam.com/images/Albums/$photoName";
}
benefitsLogosLink(String benefitsId){
  return 'https://portal.hassanallam.com/images/Benefits/$benefitsId.jpg';
}
benefitsExtraDataLink(String benefitsId){
  return 'https://portal.hassanallam.com/images/Benefits/$benefitsId.pdf';
}
subsidiariesIconLink(String subIcon){
  return 'https://portal.hassanallam.com/images/subsidiaries/$subIcon';
}
videosLinks(String videoName) {
  return 'https://portal.hassanallam.com/Public/Videos/Video/$videoName';
}
resetPayslipLink() {
  return 'https://portal.hassanallam.com/PaySlip_Login.aspx';
}
getPayslipLink(String email,String password){
  return "http://api.hassanallam.com:3415/api/Portal/Payslip?Email=$email&Password=$password";
}
addPermissionLink(){
  return "https://api.hassanallam.com/api/SelfService/AddPermission";
}
addITAccessRightLink(){
  return "https://api.hassanallam.com/api/SelfService/AddITAccessRight";
}
addITUserAccountLink(){
  return "https://api.hassanallam.com/api/SelfService/AddITUserAccount";
}
addBusinessCardLink(){
  return "https://api.hassanallam.com/api/SelfService/AddBusinessCard";
}
addEmbassyLetterLink(){
  return "https://api.hassanallam.com/api/SelfService/AddEmbassyLetter";
}
getVacationDurationLink(int type,String dateFrom,String dateTo){
  return "https://api.hassanallam.com/api/SelfService/GetVacationDuration?VacationType=$type&FromDate=$dateFrom&ToDate=$dateTo";
}
getVacationRequestLink(String hrCode,String requestNo){
  return "https://api.hassanallam.com/api/SelfService/GetVacation?HRCode=$hrCode&requestno=$requestNo";
}
getBusinessCardLink(String hrCode,String requestNo){
  return "https://api.hassanallam.com/api/SelfService/GetBusinessCard?HRCode=$hrCode&requestno=$requestNo";
}
getAccessRightLink(String hrCode,String requestNo){
  return "https://api.hassanallam.com/api/SelfService/GetAccessRight?HRCode=$hrCode&requestno=$requestNo";
}