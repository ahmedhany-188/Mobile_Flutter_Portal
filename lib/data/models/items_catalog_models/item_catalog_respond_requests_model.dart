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
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = code;
    data['message'] = message;
    data['error'] = error;
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
    json['request'] != null ? Request.fromJson(json['request']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['group_ID'] = groupID;
    data['requestNo'] = requestNo;
    data['cat_ID'] = catID;
    data['in_User'] = inUser;
    data['in_Date'] = inDate;
    data['action'] = action;
    data['submitted_HrCode'] = submittedHrCode;
    data['submitted_Date'] = submittedDate;
    data['submitted_Comment'] = submittedComment;
    data['findItemCode'] = findItemCode;
    data['action_Name'] = actionName;
    data['cat_Name'] = catName;
    data['user_Action'] = userAction;
    if (request != null) {
      data['request'] = request!.toJson();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['requestID'] = requestID;
    data['findItem_ID'] = findItemID;
    data['group_Step'] = groupStep;
    data['cat_ID'] = catID;
    data['systemItemCode'] = systemItemCode;
    data['itemCode'] = itemCode;
    data['item_Name'] = itemName;
    data['item_Desc'] = itemDesc;
    data['item_UOM'] = itemUOM;
    data['item_MatGroup'] = itemMatGroup;
    data['item_MatType'] = itemMatType;
    data['tags'] = tags;
    data['item_Qty'] = itemQty;
    data['item_Price'] = itemPrice;
    data['item_AppearPrice'] = itemAppearPrice;
    data['status'] = status;
    data['in_User'] = inUser;
    data['in_Date'] = inDate;
    data['up_User'] = upUser;
    data['up_Date'] = upDate;
    if (itemsAttaches != null) {
      data['items_Attaches'] =
          itemsAttaches!.map((v) => v).toList();
    }
    data['mainPhoto'] = mainPhoto;
    return data;
  }
}