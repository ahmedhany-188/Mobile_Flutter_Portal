class Statistics {
  int? id;
  String? serviceName;
  String? balance;
  String? consumed;
  String? remaining;

  Statistics(
      {this.id, this.serviceName, this.balance, this.consumed, this.remaining});

  Statistics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceName = json['serviceName'];
    balance = json['balance'];
    consumed = json['consumed'];
    remaining = json['remaining'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['serviceName'] = serviceName;
    data['balance'] = balance;
    data['consumed'] = consumed;
    data['remaining'] = remaining;
    return data;
  }
}