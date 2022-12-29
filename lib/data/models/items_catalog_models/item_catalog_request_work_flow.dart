class CatalogRequestWorkFlow {
  int? code;
  String? message;
  bool? error;
  List<DataWF>? data;

  CatalogRequestWorkFlow({this.code, this.message, this.error, this.data});

  CatalogRequestWorkFlow.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <DataWF>[];
      json['data'].forEach((v) {
        data!.add( DataWF.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = code;
    data['message'] = message;
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataWF {
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
  String? itemCode;
  String? itemName;
  String? itemDesc;
  String? tags;
  String? requesterHRCode;
  String? requesterName;
  String? requesterEmail;
  String? requestDate;

  DataWF(
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

  DataWF.fromJson(Map<String, dynamic> json) {
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
    data['id'] = id;
    data['group_ID'] = groupID;
    data['group_Name'] = groupName;
    data['action'] = action;
    data['action_Desc'] = actionDesc;
    data['catID_Workflow'] = catIDWorkflow;
    data['catWorkflowName'] = catWorkflowName;
    data['actionByHRCode'] = actionByHRCode;
    data['actionByName'] = actionByName;
    data['actionByEmail'] = actionByEmail;
    data['submitted_Date'] = submittedDate;
    data['submitted_Comment'] = submittedComment;
    data['requestID'] = requestID;
    data['findItem_ID'] = findItemID;
    data['cat_ID'] = catID;
    data['cat_Name'] = catName;
    data['itemCode'] = itemCode;
    data['item_Name'] = itemName;
    data['item_Desc'] = itemDesc;
    data['tags'] = tags;
    data['requester_HRCode'] = requesterHRCode;
    data['requester_Name'] = requesterName;
    data['requester_Email'] = requesterEmail;
    data['request_Date'] = requestDate;
    return data;
  }
}