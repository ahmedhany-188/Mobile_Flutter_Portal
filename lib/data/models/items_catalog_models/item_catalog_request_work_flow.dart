class CatalogRequestWorkFlow {
  int? code;
  String? message;
  bool? error;
  List<Data>? data;

  CatalogRequestWorkFlow({this.code, this.message, this.error, this.data});

  CatalogRequestWorkFlow.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? groupID;
  String? groupName;
  int? action;
  String? actionDesc;
  int? catIDWorkflow;
  String? catWorkflowName;
  String? actionByHRCode;
  String? actionByName;
  String? actionByEmail;
  String? submittedDate;
  String? submittedComment;
  int? requestID;
  int? findItemID;
  int? catID;
  String? catName;
  int? itemCode;
  String? itemName;
  String? itemDesc;
  String? tags;
  String? requesterHRCode;
  String? requesterName;
  String? requesterEmail;
  String? requestDate;

  Data(
      {this.id,
        this.groupID,
        this.groupName,
        this.action,
        this.actionDesc,
        this.catIDWorkflow,
        this.catWorkflowName,
        this.actionByHRCode,
        this.actionByName,
        this.actionByEmail,
        this.submittedDate,
        this.submittedComment,
        this.requestID,
        this.findItemID,
        this.catID,
        this.catName,
        this.itemCode,
        this.itemName,
        this.itemDesc,
        this.tags,
        this.requesterHRCode,
        this.requesterName,
        this.requesterEmail,
        this.requestDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupID = json['group_ID'];
    groupName = json['group_Name'];
    action = json['action'];
    actionDesc = json['action_Desc'];
    catIDWorkflow = json['catID_Workflow'];
    catWorkflowName = json['catWorkflowName'];
    actionByHRCode = json['actionByHRCode'];
    actionByName = json['actionByName'];
    actionByEmail = json['actionByEmail'];
    submittedDate = json['submitted_Date'];
    submittedComment = json['submitted_Comment'];
    requestID = json['requestID'];
    findItemID = json['findItem_ID'];
    catID = json['cat_ID'];
    catName = json['cat_Name'];
    itemCode = json['itemCode'];
    itemName = json['item_Name'];
    itemDesc = json['item_Desc'];
    tags = json['tags'];
    requesterHRCode = json['requester_HRCode'];
    requesterName = json['requester_Name'];
    requesterEmail = json['requester_Email'];
    requestDate = json['request_Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['group_ID'] = this.groupID;
    data['group_Name'] = this.groupName;
    data['action'] = this.action;
    data['action_Desc'] = this.actionDesc;
    data['catID_Workflow'] = this.catIDWorkflow;
    data['catWorkflowName'] = this.catWorkflowName;
    data['actionByHRCode'] = this.actionByHRCode;
    data['actionByName'] = this.actionByName;
    data['actionByEmail'] = this.actionByEmail;
    data['submitted_Date'] = this.submittedDate;
    data['submitted_Comment'] = this.submittedComment;
    data['requestID'] = this.requestID;
    data['findItem_ID'] = this.findItemID;
    data['cat_ID'] = this.catID;
    data['cat_Name'] = this.catName;
    data['itemCode'] = this.itemCode;
    data['item_Name'] = this.itemName;
    data['item_Desc'] = this.itemDesc;
    data['tags'] = this.tags;
    data['requester_HRCode'] = this.requesterHRCode;
    data['requester_Name'] = this.requesterName;
    data['requester_Email'] = this.requesterEmail;
    data['request_Date'] = this.requestDate;
    return data;
  }
}