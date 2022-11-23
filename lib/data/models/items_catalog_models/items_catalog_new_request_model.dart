
class NewRequestCatalogModel {
  int? requestID;
  int? findItemID;
  int? groupStep;
  int? catID;
  String? systemItemCode;
  String? itemCode;
  String? itemName;
  String? itemDesc;
  int? itemUOM;
  int? itemMatGroup;
  int? itemMatType;
  String? tags;
  int? itemQty;
  int? itemPrice;
  bool? itemAppearPrice;
  int? status;
  String? inUser;
  String? inDate;
  String? upUser;
  String? upDate;
  List<ItemsAttaches>? itemsAttaches;
  String? mainPhoto;

  NewRequestCatalogModel(
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

  NewRequestCatalogModel.fromJson(Map<String, dynamic> json) {
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
      itemsAttaches = <ItemsAttaches>[];
      json['items_Attaches'].forEach((v) {
        itemsAttaches!.add(new ItemsAttaches.fromJson(v));
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
          this.itemsAttaches!.map((v) => v.toJson()).toList();
    }
    data['mainPhoto'] = this.mainPhoto;
    return data;
  }
}

class ItemsAttaches {
  int? id;
  int? requestID;
  String? attachFile;
  String? inUser;
  String? inDate;
  String? upUser;
  String? upDate;

  ItemsAttaches(
      {this.id,
        this.requestID,
        this.attachFile,
        this.inUser,
        this.inDate,
        this.upUser,
        this.upDate});

  ItemsAttaches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestID = json['requestID'];
    attachFile = json['attach_File'];
    inUser = json['in_User'];
    inDate = json['in_Date'];
    upUser = json['up_User'];
    upDate = json['up_Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['requestID'] = this.requestID;
    data['attach_File'] = this.attachFile;
    data['in_User'] = this.inUser;
    data['in_Date'] = this.inDate;
    data['up_User'] = this.upUser;
    data['up_Date'] = this.upDate;
    return data;
  }
}