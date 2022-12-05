class ItemCatalogRespondRequests {
  int? code;
  String? message;
  bool? error;
  List<Data>? data;

  ItemCatalogRespondRequests({this.code, this.message, this.error, this.data});

  ItemCatalogRespondRequests.fromJson(Map<String, dynamic> json) {
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
  int? requestNo;
  int? catID;
  String? inUser;
  String? inDate;
  int? action;
  String? submittedHrCode;
  String? submittedDate;
  String? submittedComment;
  int? findItemCode;
  String? actionName;
  String? catName;
  String? userAction;
  Request? request;

  Data(
      {this.id,
        this.groupID,
        this.requestNo,
        this.catID,
        this.inUser,
        this.inDate,
        this.action,
        this.submittedHrCode,
        this.submittedDate,
        this.submittedComment,
        this.findItemCode,
        this.actionName,
        this.catName,
        this.userAction,
        this.request});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupID = json['group_ID'];
    requestNo = json['requestNo'];
    catID = json['cat_ID'];
    inUser = json['in_User'];
    inDate = json['in_Date'];
    action = json['action'];
    submittedHrCode = json['submitted_HrCode'];
    submittedDate = json['submitted_Date'];
    submittedComment = json['submitted_Comment'];
    findItemCode = json['findItemCode'];
    actionName = json['action_Name'];
    catName = json['cat_Name'];
    userAction = json['user_Action'];
    request =
    json['request'] != null ? new Request.fromJson(json['request']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['group_ID'] = this.groupID;
    data['requestNo'] = this.requestNo;
    data['cat_ID'] = this.catID;
    data['in_User'] = this.inUser;
    data['in_Date'] = this.inDate;
    data['action'] = this.action;
    data['submitted_HrCode'] = this.submittedHrCode;
    data['submitted_Date'] = this.submittedDate;
    data['submitted_Comment'] = this.submittedComment;
    data['findItemCode'] = this.findItemCode;
    data['action_Name'] = this.actionName;
    data['cat_Name'] = this.catName;
    data['user_Action'] = this.userAction;
    if (this.request != null) {
      data['request'] = this.request!.toJson();
    }
    return data;
  }
}

class Request {
  int? requestID;
  int? findItemID;
  int? groupStep;
  int? catID;
  int? systemItemCode;
  String? itemCode;
  String? itemName;
  String? itemDesc;
  int? itemUOM;
  int? itemMatGroup;
  int? itemMatType;
  String? tags;
  int? itemQty;
  double? itemPrice;
  double? itemAppearPrice;
  int? status;
  String? inUser;
  String? inDate;
  String? upUser;
  String? upDate;
  List<String>? itemsAttaches;
  String? mainPhoto;

  Request(
      {this.requestID,
        this.findItemID,
        this.groupStep,
        this.catID,
        this.systemItemCode,
        this.itemCode,
        this.itemName,
        this.itemDesc,
        this.itemUOM,
        this.itemMatGroup,
        this.itemMatType,
        this.tags,
        this.itemQty,
        this.itemPrice,
        this.itemAppearPrice,
        this.status,
        this.inUser,
        this.inDate,
        this.upUser,
        this.upDate,
        this.itemsAttaches,
        this.mainPhoto});

  Request.fromJson(Map<String, dynamic> json) {
    requestID = json['requestID'];
    findItemID = json['findItem_ID'];
    groupStep = json['group_Step'];
    catID = json['cat_ID'];
    systemItemCode = json['systemItemCode'];
    itemCode = json['itemCode'];
    itemName = json['item_Name'];
    itemDesc = json['item_Desc'];
    itemUOM = json['item_UOM'];
    itemMatGroup = json['item_MatGroup'];
    itemMatType = json['item_MatType'];
    tags = json['tags'];
    itemQty = json['item_Qty'];
    itemPrice = json['item_Price'];
    itemAppearPrice = json['item_AppearPrice'];
    status = json['status'];
    inUser = json['in_User'];
    inDate = json['in_Date'];
    upUser = json['up_User'];
    upDate = json['up_Date'];
    if (json['items_Attaches'] != null) {
      itemsAttaches = <String>[];
      json['items_Attaches'].forEach((v) {
        itemsAttaches!.add((v));
      });
    }
    mainPhoto = json['mainPhoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestID'] = this.requestID;
    data['findItem_ID'] = this.findItemID;
    data['group_Step'] = this.groupStep;
    data['cat_ID'] = this.catID;
    data['systemItemCode'] = this.systemItemCode;
    data['itemCode'] = this.itemCode;
    data['item_Name'] = this.itemName;
    data['item_Desc'] = this.itemDesc;
    data['item_UOM'] = this.itemUOM;
    data['item_MatGroup'] = this.itemMatGroup;
    data['item_MatType'] = this.itemMatType;
    data['tags'] = this.tags;
    data['item_Qty'] = this.itemQty;
    data['item_Price'] = this.itemPrice;
    data['item_AppearPrice'] = this.itemAppearPrice;
    data['status'] = this.status;
    data['in_User'] = this.inUser;
    data['in_Date'] = this.inDate;
    data['up_User'] = this.upUser;
    data['up_Date'] = this.upDate;
    if (this.itemsAttaches != null) {
      data['items_Attaches'] =
          this.itemsAttaches!.map((v) => v).toList();
    }
    data['mainPhoto'] = this.mainPhoto;
    return data;
  }
}