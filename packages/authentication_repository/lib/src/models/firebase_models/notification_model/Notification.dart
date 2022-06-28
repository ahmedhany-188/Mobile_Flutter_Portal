class FirebaseUserNotification {
  String? from;
  String? requestNo;
  String? requestType;
  String? type;
  String? requesterHRCode;

  FirebaseUserNotification({this.from, this.requestNo, this.requestType, this.type,this.requesterHRCode});

  FirebaseUserNotification.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    requestNo = json['requestNo'];
    requestType = json['requestType'];
    type = json['type'];
    requesterHRCode = json['requesterHRCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = from;
    data['requestNo'] = requestNo;
    data['requestType'] = requestType;
    data['type'] = type;
    data['requesterHRCode'] = requesterHRCode;
    return data;
  }
}