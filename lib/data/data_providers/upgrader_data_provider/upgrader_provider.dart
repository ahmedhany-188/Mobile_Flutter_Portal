import 'package:http/http.dart' as http;

class UpgraderProvider{

  Future<http.Response> getUpgraderData() async{
    http.Response rawDurationData = await http.get(
      Uri.parse(
          "https://portal.hassanallam.com/Public/IOS_App/flutterUpgrader.json"),
    ).timeout(const Duration(seconds: 2));
    print(rawDurationData.body);
    return rawDurationData;
  }
}