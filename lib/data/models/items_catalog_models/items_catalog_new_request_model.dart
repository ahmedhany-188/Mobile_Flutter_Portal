
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
  bool? brandEnabled;
  bool? qualityEnabled;

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
        this.mainPhoto,
        this.brandEnabled,
        this.qualityEnabled});

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
        itemsAttaches!.add(ItemsAttaches.fromJson(v));
      });
    }
    mainPhoto = json['mainPhoto'];
    brandEnabled = json['brand_Enabled'];
    qualityEnabled = json['quality_Enabled'];
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
          itemsAttaches!.map((v) => v.toJson()).toList();
    }
    data['mainPhoto'] = mainPhoto;
    data['brand_Enabled'] = this.brandEnabled;
    data['quality_Enabled'] = this.qualityEnabled;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['requestID'] = requestID;
    data['attach_File'] = attachFile;
    data['in_User'] = inUser;
    data['in_Date'] = inDate;
    data['up_User'] = upUser;
    data['up_Date'] = upDate;
    return data;
  }
}