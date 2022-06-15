// import 'package:http/http.dart' as http;
//
// class MyRequestsDetailDataProvider {
//
//   MyRequestsDetailDataProvider();
//
//   Future<http.Response> getBusinessMission(hrCode, requestNumber) async {
//     http.Response rawAttendanceData = await http.get(
//       Uri.parse(
//           "https://api.hassanallam.com/api/SelfService/GetBusinessMission?HRCode=$hrCode&requestno=$requestNumber"
//       ),
//     );
//
//     return rawAttendanceData;
//   }
//
//   Future<http.Response> getPermission(hrCode, requestNumber) async {
//     http.Response rawAttendanceData = await http.get(
//       Uri.parse(
//           "https://api.hassanallam.com/api/SelfService/GetPermission?HRCode=$hrCode&requestno=$requestNumber"
//       ),
//     );
//     return rawAttendanceData;
//   }
//
//   Future<http.Response> getVacation(hrCode, requestNumber) async {
//     http.Response rawAttendanceData = await http.get(
//       Uri.parse(
//           "https://api.hassanallam.com/api/SelfService/GetVacation?HRCode=$hrCode&requestno=$requestNumber"
//       ),
//     );
//     return rawAttendanceData;
//   }
//
//   Future<http.Response> getEmbassy(hrCode, requestNumber) async {
//     http.Response rawAttendanceData = await http.get(
//       Uri.parse(
//           "https://api.hassanallam.com/api/SelfService/GetEmbassy?HRCode=$hrCode&requestno=$requestNumber"
//       ),
//     );
//
//     return rawAttendanceData;
//   }
//
//   Future<http.Response> getAccount(hrCode, requestNumber) async {
//     http.Response rawAttendanceData = await http.get(
//       Uri.parse(
//           "https://api.hassanallam.com/api/SelfService/GetUserAccount?HRCode=$hrCode&requestno=$requestNumber"
//       ),
//     );
//
//     return rawAttendanceData;
//   }
//
//   Future<http.Response> getGetAccessRight(hrCode, requestNumber) async {
//     http.Response rawAttendanceData = await http.get(
//       Uri.parse(
//           "https://api.hassanallam.com/api/SelfService/GetAccessRight?HRCode=$hrCode&requestno=$requestNumber"
//       ),
//     );
//     return rawAttendanceData;
//   }
//
//   Future<http.Response> getGetBusinessCard(hrCode, requestNumber) async {
//     http.Response rawAttendanceData = await http.get(
//       Uri.parse(
//           "https://api.hassanallam.com/api/SelfService/GetBusinessCard?HRCode=$hrCode&requestno=$requestNumber"
//       ),
//     );
//     return rawAttendanceData;
//   }
//
// }