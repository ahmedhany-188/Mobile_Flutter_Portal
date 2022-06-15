import 'dart:convert';

import 'package:hassanallamportalflutter/data/data_providers/upgrader_data_provider/upgrader_provider.dart';
import 'package:hassanallamportalflutter/data/models/upgrader_model/upgrader.dart';
import 'package:http/http.dart' as http;

class UpgraderRepository{

  Future<Upgrader> getUpgradingData() async{
    final http.Response rawUpgradingData = await UpgraderProvider()
        .getUpgraderData();
    final json = await jsonDecode(rawUpgradingData.body);
    final Upgrader response = Upgrader.fromJson(json);
    return response;
  }

}