class ResponseTakeAction {
    int? id;
    int? requestNo;
    String? result;
    String? serviceID;

    ResponseTakeAction({this.id, this.requestNo, this.result, this.serviceID});

    factory ResponseTakeAction.fromJson(Map<String, dynamic> json) {
        return ResponseTakeAction(
            id: json['id'],
            requestNo: json['requestNo'],
            result: json['result'],
            serviceID: json['serviceID'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['id'] = id;
        data['requestNo'] = requestNo;
        data['result'] = result;
        data['serviceID'] = serviceID;
        return data;
    }
}