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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['result'] = this.result;
    data['serviceID'] = this.serviceID;
    data['requestNo'] = this.requestNo;
    return data;
  }
}