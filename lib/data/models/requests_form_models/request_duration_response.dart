class DurationResponse {
  List<Result>? result;
  int? id;
  String? exception;
  int? status;
  bool? isCanceled;
  bool? isCompleted;
  bool? isCompletedSuccessfully;
  int? creationOptions;
  String? asyncState;
  bool? isFaulted;

  DurationResponse(
      {this.result,
        this.id,
        this.exception,
        this.status,
        this.isCanceled,
        this.isCompleted,
        this.isCompletedSuccessfully,
        this.creationOptions,
        this.asyncState,
        this.isFaulted});

  DurationResponse.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
    id = json['id'];
    exception = json['exception'];
    status = json['status'];
    isCanceled = json['isCanceled'];
    isCompleted = json['isCompleted'];
    isCompletedSuccessfully = json['isCompletedSuccessfully'];
    creationOptions = json['creationOptions'];
    asyncState = json['asyncState'];
    isFaulted = json['isFaulted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['exception'] = this.exception;
    data['status'] = this.status;
    data['isCanceled'] = this.isCanceled;
    data['isCompleted'] = this.isCompleted;
    data['isCompletedSuccessfully'] = this.isCompletedSuccessfully;
    data['creationOptions'] = this.creationOptions;
    data['asyncState'] = this.asyncState;
    data['isFaulted'] = this.isFaulted;
    return data;
  }
}

class Result {
  int? id;
  String? result;

  Result({this.id, this.result});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['result'] = this.result;
    return data;
  }
}
