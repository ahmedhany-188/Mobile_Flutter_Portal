class RequestResponse {
  int? id;
  String? result;
  String? serviceID;
  String? requestNo;

  RequestResponse({this.id, this.result, this.serviceID, this.requestNo});

  RequestResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    result = json['result'];
    serviceID = json['serviceID'];
    requestNo = json['requestNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['result'] = result;
    data['serviceID'] = serviceID;
    data['requestNo'] = requestNo;
    return data;
  }
}